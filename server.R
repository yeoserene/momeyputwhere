source ('helpers.R')

shinyServer(
  function(input, output) {
    #output$table1 <- renderTable(
    #  dbs(input$salary, input$cc, input$home_loan, input$insure, input$invest, input$savings))
    
    #output$table3 <- renderTable(
    #  uob(input$salary, input$cc, input$giro, input$savings))
    
    #output$table2 <- renderTable(
    #  ocbc(input$salary, input$cc, input$balance, input$insure, input$invest, input$savings)
    #)
    
    output$final <- renderTable(
      all(input$salary, input$cc, input$insure, input$invest, input$home_loan, input$giro, input$balance, input$savings)
    )

    output$sal <- renderText(
      paste("DBS: no minimum", "OCBC: minimum $2000", "UOB: no minimum", sep="\n")
    )
    
    output$cc <- renderText(
      paste("DBS: no minimum", "OCBC: minimum $500", "UOB: minimum $500 on selected cards only", sep="\n")
    )
    
    output$home_loan <- renderText(
      paste("Applicable to DBS only.")
    )
    
    output$giro <- renderText(
      paste("Applicable to UOB only.")
    )
    
    output$balance <- renderText(
      paste("Applicable to OCBC only.", "All increase: 1.0% on the interest itself", "At least $500 increase: 0.3-0.6%",
            sep="\n")
    )
    
    output$insure <- renderText(
      paste("Applicable to DBS and ", "OCBC only.", "DBS: Selected policies only", 
            "OCBC: Selected policies only. Extra 0.6% to 1.2% interest only valid for first 12 months.", sep="\n")
      )
    
    
    output$wealth <- renderText(
      paste("Applicable to DBS and ", "OCBC only.", "DBS: Dividends, unit trusts, equities traded on DBS platforms",
            "OCBC: Selected policies only. Extra 0.6% to 1.2% interest only valid for first 12 months", sep="\n")
    )
  }
)