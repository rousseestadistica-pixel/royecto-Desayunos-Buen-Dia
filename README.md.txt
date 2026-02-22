# 🥗 Desayunos Nutritivos "Buen Día" ☀️
> *Potenciando el rendimiento académico a través de la nutrición inteligente en la ciudad de Ica.*

---

## 📝 Descripción del Proyecto
El proyecto **"Buen Día"** surge como respuesta a la necesidad de alimentación balanceada para estudiantes y trabajadores jóvenes en Ica. Este repositorio combina la planificación de negocios con un **Laboratorio Estadístico (StatLab v1.0)** desarrollado en R Shiny para optimizar la toma de decisiones basada en datos nutricionales y costos.

## 📋 Menú Estratégico Analizado (Base de Datos)
Esta es la lista de productos que hemos integrado en nuestro análisis estadístico, diseñada para cubrir diferentes necesidades nutricionales:

| ID | Producto / Combo | Categoría | Calorías | Proteínas (g) | Fibra | Precio (S/) |
|:---|:---|:---|:---:|:---:|:---:|:---:|
| 1 | **Combo Energía Escolar** | Combo | 350 | 12 | Alto | 5.50 |
| 2 | **Combo Universitario (Power)** | Combo | 480 | 18 | Medio | 8.50 |
| 3 | **Nutri Bowl Amazónico** | Bowl | 410 | 10 | Muy Alto | 11.00 |
| 4 | **Súper Completo Buen Día** | Combo | 580 | 24 | Alto | 13.00 |
| 5 | **Saludable Fit (Bajo Carb)** | Combo | 320 | 20 | Bajo | 10.00 |
| 6 | **Avena con Chía y Mango** | Bebida | 240 | 7 | Muy Alto | 4.00 |
| 7 | **Quinoa Real con Manzana** | Bebida | 210 | 5 | Alto | 3.50 |
| 8 | **Maca Punch Energizante** | Bebida | 220 | 6 | Medio | 3.50 |
| 9 | **Jugo Naranja Antigripal** | Bebida | 140 | 2 | Bajo | 4.50 |
| 10 | **Extracto Verde Detox** | Bebida | 95 | 3 | Muy Alto | 6.00 |
| 11 | **Pan Integral con Palta y Huevo** | Sólido | 340 | 14 | Alto | 5.00 |
| 12 | **Sandwich de Pollo y Apio** | Sólido | 290 | 16 | Medio | 5.00 |
| 13 | **Tortilla Veggie de Espinaca** | Sólido | 230 | 11 | Alto | 4.50 |
| 14 | **Triple Saludable (Huevo/Tomate)** | Sólido | 270 | 10 | Medio | 6.00 |
| 15 | **Yogurt Griego con Granola** | Bowl | 310 | 15 | Medio | 8.50 |
| 16 | **Ensalada Frutas Estación (M)** | Bowl | 190 | 3 | Alto | 6.50 |
| 17 | **Ensalada Frutas Especial (G)** | Bowl | 320 | 5 | Alto | 9.50 |
| 18 | **Pack 2 Huevos Sancochados** | Extra | 150 | 13 | Nulo | 2.50 |
| 19 | **Mix Frutos Secos (30g)** | Extra | 185 | 6 | Alto | 4.50 |
| 20 | **Muffin de Avena y Plátano** | Sólido | 260 | 5 | Alto | 3.50 |

---

## 📊 Análisis Estadístico con R Shiny
La aplicación `app.R` permite realizar un estudio profundo de esta data:
* **Relación Proteína-Precio:** Mediante regresión lineal, observamos cómo el valor nutricional justifica el costo premium de ciertos productos.
* **Márgenes de Utilidad:** Evaluación de la sostenibilidad del negocio comparando costos de insumos vs. precios de venta.

## 🛠️ Tecnologías y Librerías
* **Lenguaje:** R 4.3+
* **Framework:** Shiny & Shinydashboard
* **Librerías:** `DT`, `plotly`, `dplyr`, `readxl`, `ggplot2`.

## 📂 Estructura del Repositorio
1. `app.R`: Código de la aplicación interactiva en R.
2. `datos_desayunos.xlsx`: Base de datos con los 20 productos.
3. `README.md`: Este archivo de presentación.
4. `PROYECTO_DESAYUNO_SALUDABLE.pdf`: Informe técnico completo.

---
**Equipo de Proyecto:**
👤 Portocarrero Purilla Rodrigo | 👤 Chauca Chavez Yudit | 👤 Keyth Fatima De Luren Mayuri Junchaya | 👤 Caja Casas Tadeo | 👤 Garcia Huachaca Rousse