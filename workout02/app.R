#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  titlePanel("Savings Simulations"),
  
  fluidRow(
    column(4, 
           sliderInput(inputId = "amount", label = "Initial Amount",
                       value = 1000, min = 1, max = 100000, pre = "$")
    ),
    column(4, 
           sliderInput(inputId = "rate", label = "Return Rate (in %)",
                       value = 5, min = 0, max = 20)
    ),
    column(4, 
           sliderInput(inputId = "years", label = "Years",
                       value = 10, min = 0, max = 50)
    )
  ),
  
  fluidRow(
    column(4, 
           sliderInput(inputId = "contrib", label = "Annual Contribution",
                       value = 2000, min = 0, max = 50000, pre = "$")
    ),
    column(4, 
           sliderInput(inputId = "growth", label = "Growth Rate (in %)",
                       value = 2, min = 0, max = 20)
    ),
    column(4, 
           selectInput(inputId = "facet", label = "Facet?",
                       choices = c("No", "Yes"))
    )
    
  ),
  
  h4("Timelines"),
  plotOutput("timelines"),
  
  h4("Balances"),
  verbatimTextOutput("balances")
)


#' @title future value function
#' @description computes future value of investment
#' @param amount initial invested amount
#' @param rate annual rate of return
#' @param years number of years
#' @return the future value
future_value <- function(amount, rate, years) {
  return(amount * (1+rate)^years)
}

#' @title future value of annuity function
#' @description computes the future value of annuity
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param years number of years
#' @return the future value of annuity
annuity <- function(contrib, rate, years) {
  return(contrib * ((1+rate)^years - 1) / rate)
}

#' @title future value of growing annuity function
#' @description computes the future value of growing annuity
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years number of years
#' @return the future value of growing annuity
growing_annuity <- function(contrib, rate, growth, years) {
  return(contrib * ((1+rate)^years - (1+growth)^years) / (rate-growth))
}

#' @title construct modalities dataframe
#' @description constructs a dataframe from three modes of saving
#' @param years number of years
#' @param amount initial invested amount
#' @param contrib contributed amount
#' @param growth annual growth rate
#' @param rate annual rate of return
#' @return dataframe consisting of three modes of savings
get_modalities <- function(years, amount, contrib, growth, rate) {
  rate <- rate/100
  growth <- growth/100
  
  year_vec <- rep(0:years, 3)
  
  mode_vec <- c(rep("no_contrib", years+1), rep("fixed_contrib", years+1), rep("growing_contrib", years+1))
  
  mode_vec <- factor(mode_vec, levels = c("no_contrib", "fixed_contrib", "growing_contrib"))
  
  value_vec <- rep(0, (years+1)*3)
  
  for (i in 1:(years+1)) {
    value_vec[i] <- future_value(amount=amount, rate=rate, years=i-1)
    value_vec[i+years+1] <- future_value(amount=amount, rate=rate, years=i-1) + annuity(contrib=contrib, rate=rate, years=i-1)
    value_vec[i+2*years+2] <- future_value(amount=amount, rate=rate, years= i-1) + growing_annuity(contrib = contrib, rate = rate, growth=growth, years = i-1)
  }
  
  modalities <- data.frame(year = year_vec, value = value_vec, mode = mode_vec)
  
  return(modalities)
}


server <- function(input, output) {
  pl <- reactive({get_modalities(input$years, input$amount, input$contrib, input$growth, input$rate)})
  y <- reactive({
    if (input$facet == "No") {
      return(ggplot(data = pl(), aes(x=year, y=value, color=mode)) + geom_point() + geom_line() + ggtitle("Three modes of investing")) 
    } else {
      return(ggplot(data = pl(), aes(x=year, y=value, color=mode)) + geom_point() + geom_line() + ggtitle("Three modes of investing") + facet_wrap(~ mode) + geom_area(aes(fill=mode), alpha=0.6) + theme_bw())
    }
  })
  
  output$timelines <- renderPlot({
    title <- "Three modes of investing"
    y()
  })
  
  tb <- reactive({data.frame(year=1:(input$years+1), no_contrib=pl()$value[1:11], fixed_contrib=pl()$value[12:22], growing_contrib=pl()$value[23:33])})
  output$balances <- renderPrint(tb())
}


# Run the application 
shinyApp(ui = ui, server = server)

