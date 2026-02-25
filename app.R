# ==============================================
# 1. CARGA DE LIBRERÍAS
# ==============================================
library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(dplyr)
library(readxl)
library(ggplot2)

# ==============================================
# 2. INTERFAZ DE USUARIO (UI)
# ==============================================
ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "StatLab v1.0", titleWidth = 250),
  
  dashboardSidebar(
    width = 250,
    sidebarMenu(
      id = "sidebar",
      menuItem("Carga de Datos", tabName = "data", icon = icon("upload")),
      menuItem("Análisis Exploratorio", tabName = "explore", icon = icon("search")),
      menuItem("Estadística Descriptiva", tabName = "descriptive", icon = icon("chart-bar")),
      menuItem("Pruebas de Hipótesis", tabName = "hypothesis", icon = icon("check-double")),
      menuItem("Modelado", tabName = "modeling", icon = icon("project-diagram"))
    ),
    conditionalPanel(
      condition = "input.sidebar == 'data'",
      h4("Opciones de Carga", style = "padding-left: 20px;"),
      fileInput("file", "Subir archivo", accept = c(".csv", ".xlsx", ".txt")),
      selectInput("sep", "Separador (Solo CSV)", choices = c("Coma" = ",", "Punto y Coma" = ";", "Tab" = "\t")),
      checkboxInput("header", "Encabezado", TRUE)
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "data",
              fluidRow(
                valueBoxOutput("row_count", width = 4),
                valueBoxOutput("col_count", width = 4),
                valueBoxOutput("mem_size", width = 4)
              ),
              box(title = "Vista Previa de los Datos", width = 12, DTOutput("data_preview"))
      ),
      
      tabItem(tabName = "explore",
              box(title = "Estructura Técnica", width = 12, verbatimTextOutput("data_structure"))
      ),
      
      tabItem(tabName = "descriptive",
              box(width = 12, 
                  selectInput("desc_var", "Variables a analizar:", choices = NULL, multiple = TRUE),
                  actionButton("run_desc", "Calcular Estadísticas", class = "btn-primary"),
                  hr(),
                  DTOutput("descriptive_table"))
      ),
      
      tabItem(tabName = "hypothesis",
              box(width = 12,
                  selectInput("t_var1", "Variable A:", choices = NULL),
                  selectInput("t_var2", "Variable B:", choices = NULL),
                  actionButton("run_ttest", "Ejecutar Prueba t", class = "btn-warning"),
                  hr(),
                  verbatimTextOutput("ttest_results"))
      ),
      
      tabItem(tabName = "modeling",
              box(title = "Regresión Lineal", status = "primary", solidHeader = TRUE, width = 12,
                  selectInput("lm_dep", "Y (Dependiente):", choices = NULL),
                  selectInput("lm_indep", "X (Independientes):", choices = NULL, multiple = TRUE),
                  actionButton("run_lm", "Ajustar Modelo", class = "btn-success"),
                  hr(),
                  tabsetPanel(
                    tabPanel("Resumen", verbatimTextOutput("lm_summary")),
                    tabPanel("Diagnóstico", plotOutput("lm_diagnostics")),
                    tabPanel("Coeficientes", DTOutput("lm_coeff"))
                  )
              )
      )
    )
  )
)

# ==============================================
# 3. SERVIDOR (LÓGICA)
# ==============================================
server <- function(input, output, session) {
  
  data_loaded <- reactiveVal(NULL)
  
  observeEvent(input$file, {
    req(input$file)
    ext <- tools::file_ext(input$file$name)
    
    df <- tryCatch({
      if (ext == "csv") {
        read.csv(input$file$datapath, sep = input$sep, header = input$header)
      } else if (ext %in% c("xls", "xlsx")) {
        read_excel(input$file$datapath)
      } else {
        read.table(input$file$datapath, sep = input$sep, header = input$header)
      }
    }, error = function(e) {
      showNotification("Error al leer el archivo", type = "error")
      return(NULL)
    })
    
    if(!is.null(df)) {
      data_loaded(df)
      num_vars <- names(df)[sapply(df, is.numeric)]
      updateSelectInput(session, "desc_var", choices = num_vars)
      updateSelectInput(session, "t_var1", choices = num_vars)
      updateSelectInput(session, "t_var2", choices = num_vars)
      updateSelectInput(session, "lm_dep", choices = num_vars)
      updateSelectInput(session, "lm_indep", choices = names(df))
    }
  })
  
  output$data_preview <- renderDT({ req(data_loaded()); datatable(head(data_loaded(), 20), options = list(scrollX = TRUE)) })
  
  output$row_count <- renderValueBox({ valueBox(ifelse(is.null(data_loaded()), 0, nrow(data_loaded())), "Filas", icon = icon("table"), color = "blue") })
  output$col_count <- renderValueBox({ valueBox(ifelse(is.null(data_loaded()), 0, ncol(data_loaded())), "Columnas", icon = icon("columns"), color = "green") })
  output$mem_size <- renderValueBox({ 
    mem <- if(is.null(data_loaded())) "0 MB" else paste(round(object.size(data_loaded())/1024^2, 2), "MB")
    valueBox(mem, "Memoria", icon = icon("memory"), color = "yellow") 
  })
  
  output$data_structure <- renderPrint({ req(data_loaded()); str(data_loaded()) })
  
  output$descriptive_table <- renderDT({
    req(input$run_desc, input$desc_var)
    df_desc <- data_loaded()[, input$desc_var, drop = FALSE]
    datatable(as.data.frame(do.call(cbind, lapply(df_desc, summary))))
  })
  
  output$ttest_results <- renderPrint({
    req(input$run_ttest, input$t_var1, input$t_var2)
    t.test(data_loaded()[[input$t_var1]], data_loaded()[[input$t_var2]])
  })
  
  lm_model <- eventReactive(input$run_lm, {
    req(input$lm_dep, input$lm_indep)
    formula <- as.formula(paste(input$lm_dep, "~", paste(input$lm_indep, collapse = "+")))
    lm(formula, data = data_loaded())
  })
  
  output$lm_summary <- renderPrint({ req(lm_model()); summary(lm_model()) })
  output$lm_diagnostics <- renderPlot({ req(lm_model()); par(mfrow=c(2,2)); plot(lm_model()) })
  output$lm_coeff <- renderDT({ req(lm_model()); datatable(as.data.frame(summary(lm_model())$coefficients)) })
}

# ==============================================
# 4. LANZAR APP
# ==============================================
shinyApp(ui = ui, server = server)