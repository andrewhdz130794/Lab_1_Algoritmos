library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
dashboardPage(
    dashboardHeader(title = "Algoritmos en la Ciencia de Datos"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Metodo de Biseccion", tabName = "Biseccion"),
            menuItem("Metodo de Newton-Raphson", tabName = "newton-raphson")
        ) 
    ),
    dashboardBody(
        tabItems(
            tabItem("Ceros",
                    h1("Método de Newton"),
                    box(textInput("ecuacion", "Ingrese la Ecuación"),
                        textInput("initVal", "X0"),
                        textInput("Error", "Error")),
                    actionButton("nwtSolver", "Newton Solver"),
                    tableOutput("salidaTabla")),
            
            tabItem("Derivacion",
                    h1("Diferencias Finitas"),
                    box(textInput("difFinEcu", "Ingrese la Ecuación"),
                    textInput("valorX", "x"),
                    textInput("valorH", "h")),
                    actionButton("diferFinEval", "Evaluar Derivada"),
                    textOutput("difFinitOut")),
            
            tabItem("Biseccion",
                    h1("Método de Bisección"),
                    box(textInput("ecuacionBisect", "Ingrese la Ecuación"),
                        textInput("initA", "Valor de a"),
                        textInput("initB", "Valor de b"),
                        textInput("ErrorBisect", "Error"),
                        textInput("kMax", "Máximo de Iteraciones")),
                    actionButton("bisectSolver", "Resolver"),
                    tableOutput("salidaBiseccion")),

            tabItem("newton-raphson",
                    h1("Método de Newton-Raphson"),
                    box(textInput("ecuacion", "Ingrese la Ecuación"),
                        textInput("initVal", "X0"),
                        textInput("Error", "Error"),
                        textInput("kMaxNewton", "Máximo de Iteraciones")),
                    actionButton("nwtSolver", "Resolver"),
                    tableOutput("salidaTabla"))
        )
    )
)
