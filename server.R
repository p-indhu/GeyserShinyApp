library(shiny)
library(datasets)
library(caret)

fitmodel <- function()
 {
        data(faithful)
        geyserdata <- as.data.frame(faithful)
        set.seed(975)
        inTrain = createDataPartition(geyserdata$eruptions, p = 0.80)[[1]]
        trainsub = geyserdata[ inTrain,]
        testsub = geyserdata[-inTrain,]
        set.seed(978)
        modelfit <- lm(eruptions ~ waiting, data = trainsub)
        modelfit
}

predictduration <- function(fit, waittime)
{
        pduration <- as.numeric(predict(fit, newdata = data.frame(waiting = waittime)))
        pduration
}

mainplot <- function(fit)
{
        data(faithful)
        geyserdata <- as.data.frame(faithful)
        peruptions <- predict(fit, newdata = geyserdata, interval = "prediction")
        ordered <- order(geyserdata$waiting)
        plot(geyserdata$waiting, geyserdata$eruptions, pch = 19, main = "Prediction interval", xlab = "Waiting time between eruptions(in mins)", ylab = "Eruption duration(in mins)")
        matlines(geyserdata$waiting[ordered], peruptions[ordered,], type = "l", col = c(2,3,3), lty = c(1,1,1), lwd = 3)
}
shinyServer(
        function(input, output) {
                fit <- fitmodel()
                output$owaittime <- renderPrint( {input$waittime} )
                output$oduration <- renderPrint(predictduration(fit, input$waittime))
                output$omap <- renderPlot({mainplot(fit)}, height = 400, width = 600 )
        
        }
        )