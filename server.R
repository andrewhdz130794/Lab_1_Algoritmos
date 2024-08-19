
library(shiny)
library(reticulate)

source_python("algoritmos.py")

#tableOut, soluc = newtonSolverX(-5, "2x^5 - 3", 0.0001)

shinyServer(function(input, output) {
    
    #Evento y evaluación de metodo de newton para ceros
    newtonCalculate<-eventReactive(input$nwtSolver, {
        inputEcStr<-input$ecuacion[1]
        print(inputEcStr)
        initVal<-input$initVal[1]
        error<-input$Error[1]
        #outs<-add(initVal, error)
        outs<-newtonSolverX(initVal, inputEcStr, error)
        outs
    })
    
    #Evento y evaluación de diferencias finitas
    diferFinitCalculate<-eventReactive(input$diferFinEval, {
        inputEcStr<-input$difFinEcu[1]
        valX<-input$valorX[1]
        h<-input$valorH[1]
        outs<-evaluate_derivate_fx(inputEcStr, valX, h)
        as.character(outs)
    })
    
    
    #REnder metodo de Newton
    output$salidaTabla<-renderTable({
        newtonCalculate()
    })
    
    #Render Diferncias Finitas
    output$difFinitOut<-renderText({
        diferFinitCalculate()
    })
    
    # Evento y evaluación de método de Bisección
    bisectionCalculate <- eventReactive(input$bisectSolver, {
      inputEcStr <- input$ecuacionBisect[1]
      initA <- input$initA[1]
      initB <- input$initB[1]
      error <- input$ErrorBisect[1]
      k_max <- input$kMax[1]
      
      outs <- bisectionSolverX(initA, initB, inputEcStr, error, k_max)
      outs
    })
    
    # Render método de Bisección
    output$salidaBiseccion <- renderTable({
      bisectionCalculate()
    })
    
    newtonCalculate <- eventReactive(input$nwtSolver, {
      inputEcStr <- input$ecuacion[1]
      initVal <- input$initVal[1]
      error <- input$Error[1]
      k_max <- input$kMaxNewton[1]
      
      outs <- newtonSolverX(initVal, inputEcStr, error, k_max)
      outs
    })
    
    # Render método de Newton-Raphson
    output$salidaTabla <- renderTable({
      newtonCalculate()
    })
    
    
})
