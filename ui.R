library(shiny)

# Definir la interfaz de usuario
shinyUI(fluidPage(
  titlePanel("Métodos Numéricos: Bisección y Newton-Raphson"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("a", "Inicio del intervalo (a):", value = 0),
      numericInput("b", "Fin del intervalo (b):", value = 1),
      numericInput("tol", "Tolerancia (ε):", value = 1e-12),
      numericInput("x0", "Solución inicial para Newton-Raphson (x0):", value = 0.5),
      actionButton("capture", "Capturar Pantalla")
    ),
    
    mainPanel(
      h3("Resultados del Método de Bisección"),
      tableOutput("bisection_result"),
      
      h3("Resultados del Método de Newton-Raphson"),
      tableOutput("newton_result")
    )
  )
))
