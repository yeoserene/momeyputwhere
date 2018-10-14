# ui.R
library(shiny)
library(png)
source ("helpers.R")

shinyUI(fluidPage(
  titlePanel("Be calculative."),
  
  sidebarLayout(
    sidebarPanel(
      helpText("This calculator app is meant to help several groups of people -- those who
               just began their savings journey, those who are too lazy or find it
               too troublesome to do comparisons, those who need cash assets 
               liquidity and of course, many others who may possible find this app
               useful in one way or another."),

      helpText("Its purpose is to help you easily and quickly visualize which is the best allocation 
                of money across the savings accounts in Singapore that has one of the highest interest
                rates [", a(strong("DBS Multiplier"), href="https://www.dbs.com.sg/personal/landing/dbs-multiplier/"), 
                "/", a(strong("OCBC 360"), href="https://www.ocbc.com/personal-banking/accounts/360-account-cpa1.html"), "/", 
                a(strong("UOB One"), href="https://www.uob.com.sg/personal/save/chequeing/one-account.page"),"], 
                based on the criteria that you can fulfill. Unfortunately,things don't come free. These banks often 
                require you to fulfill their criteria, so be sure to check them out properly."),
      
      helpText("Once again, this tool is nowhere near perfect, as it makes its fair share of assumptions."),
      
      helpText("With no further matters, ", strong("ENJOY!")),
      
      br(),
      br(),
      
      div(img(src = "cat.jpg", height="200", width="250"), style="text-align: center;"),
      
      br(),
      
      p("Creator: Serene Yeo"),
      
      width= 3),
    
    
    mainPanel(
      h4 ("Disclaimer: "),
      h5 ("This is solely meant as a personal exploratory project and it exists for your convenience. You are to rely 
          on the results at your own risk. The creator will not under any circumstances accept responsibility 
          or liability for any losses that may arise from a decision that you may make as a result of using 
          the calculator."),
      h5 ("Information is accurate as of 13 Oct '18 23:45."),
      h5 ("The rates used in the interest computation from OCBC360 account are the rates
          that will take effect from 1 Nov '18."),
      h5 ("Please do note that there will be some slight differences (approximately a few cents
          to a few dollars off) with the amount you may get from the interest calculators at the
          respective bank websites. This is due to some rounding off errors and also the fact
          that interests are computed in a more sophisticated way (average end-day balance etc.) in actual."),
      
      h3 ("How much savings (S$) do you have now?"),
      fluidRow(
        column(12,
               (numericInput("savings", label = h6(""), min=0, value = 10000)))
      ),
      
      h3("Let us also find out what are some of the requirements that you can meet before
        we provide you with the recommendations :)"),
      
      h5("We would require you to fill in the following figures (S$) for each category that
         you can contribute to every month. You should leave the input as S$0 if you do not transact
         in that category."),
      
      fluidRow(
        column(3,
               (numericInput("salary", label = h4("Salary through GIRO"), min = 0, value = 0))),
               
        column(3,
               (numericInput("cc", label = h4("Credit card spending"), min = 0, value = 0))),
        
        column(3,
               (numericInput("insure", label = h4("Insurance with banks"), min = 0, value = 0))),
        
        column(3,
               (numericInput("invest", label = h4("Investment with banks"), min = 0, value = 0)))

      ),
      
      fluidRow(
        column(3,
               (verbatimTextOutput('sal'))),
        
        column(3,
               (verbatimTextOutput('cc'))),

        column(3,
               (verbatimTextOutput('insure'))),
        
        column(3,
               (verbatimTextOutput('wealth')))
        
      ),
      
      fluidRow(
        column(3,
               (numericInput("home_loan", label = h4("Bank housing loan"), min = 0, value = 0))),
        column(3,
               (numericInput("balance", label = h4("Increasing your monthly balance?"), min = 0, value = 0))),
        column(3,
               radioButtons("giro", label = h4("3 GIRO arrangements"), choices=c("Yes", "No")))

      ),

      
      fluidRow(
        column(3,
               (verbatimTextOutput('home_loan'))),
        
        column(3,
               (verbatimTextOutput('balance'))),
        
        column(3,
               (verbatimTextOutput('giro')))
        
      ),
      
      h3 ("Now, this is the estimated monthly interest (S$) you'll be getting."),
      h5 ("As we have mentioned before, and as a friendly reminder, this is purely just an estimated monthly amount 
          (total interest per year/12) which differs slightly from the computation done by banks as their interests 
          are computed on a daily basis."),
      h5 ("There are guaranteed cashbacks on the credit cards that you use at various banks, that are EXCLUDED from
          this computation. This is because there are just too many different rebates schemes for all the available
          credit cards. For example, spending $500 on the UOB One card monthly gets you $200 annual interest but 
          this piece of information is not included in the figures presented to you below."),
      
      fluidRow (
        column(6,
               (tableOutput('final')))
      )
    )
  )
))
