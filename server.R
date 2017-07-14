#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  model1 <- lm(circumference ~ age, data = Orange)
  
  model1pred <- reactive({
    Oage <- input$age
    predict(model1, newdata = data.frame(age = Oage))
  })
  
  output$distPlot <- renderPlot({
    
    # convert factor to numeric for convenience 
    Orange$Tree <- as.numeric(Orange$Tree) 
    ntrees <- max(Orange$Tree)
    
    # get the range for the x and y axis 
    xrange <- range(Orange$age) 
    yrange <- range(Orange$circumference) 
    
    # set up the plot 
    plot(xrange, yrange, type="n", xlab="Age (days)",
         ylab="Circumference (mm)" ) 
    colors <- rainbow(ntrees) 
    linetype <- c(1:ntrees) 
    plotchar <- seq(18,18+ntrees,1)
    
    # add lines 
    for (i in 1:ntrees) { 
      tree <- subset(Orange, Tree==i) 
      lines(tree$age, tree$circumference, type="b", lwd=1.5,
            lty=linetype[i], col=colors[i], pch=plotchar[i]) 
    } 
    
    # add a title and subtitle 
    title("Tree Growth","Orange Tree Dataset")
    
    # add a legend 
    legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,
           pch=plotchar, lty=linetype, title="Tree")
    abline(model1, col = "red", lwd = 2)
  })
  output$pred1 <- renderText({
    model1pred()
  })
  output$mytable = renderDataTable({
    Orange
  })
  output$summary <- renderPrint({
    summary(Orange)
  })
  
  
})
