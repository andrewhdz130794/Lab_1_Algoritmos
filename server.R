library(shiny)
library(reticulate)
library(webshot)

# Configurar reticulate para usar Python
use_python("C:/Users/andre/AppData/Local/Programs/Python/Python312/python.exe")

# Cargar el script de Python
source_python("C:/Users/andre/Downloads/Lab 1 Andrea Hernandez/bisection_newton.py")

# Verificar instalación de phantomjs
if (!webshot::is_phantomjs_installed()) {
  webshot::install_phantomjs()
}

# Definir la lógica del servidor
shinyServer(function(input, output) {
  observeEvent(input$capture, {
    # Capturar la pantalla de la aplicación
    webshot::webshot("http://127.0.0.1:7808", file = "screenshot.png")
  })
  
  output$bisection_result <- renderTable({
    # Asegúrate de que la función f se define en el entorno de R
    f <- function(x) { x^2 + exp(-x) }
    bisection <- bisection_method(f, input$a, input$b, input$tol)
    bisection[[2]]
  })
  
  output$newton_result <- renderTable({
    # Asegúrate de que la función f y df se definen en el entorno de R
    f <- function(x) { x^2 + exp(-x) }
    df <- function(x) { 2*x - exp(-x) }
    newton <- newton_raphson_method(f, df, input$x0, input$tol)
    newton[[2]]
  })
})
