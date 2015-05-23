library(shiny)
shinyUI(navbarPage("Geyser Eruption Duration Prediction",
        
        tabPanel("About",
                sidebarPanel(
                        
                         p("Old Faithful is a cone geyser located in Wyoming, in Yellowstone National Park in the United States. It is one of the most predictable geographical features on Earth, erupting almost every 63 minutes. Eruptions can shoot 3,700 to 8,400 US gallons (14,000 to 32,000 L) of boiling water to a height of 106 to 185 feet (32 to 56 m) lasting from 1.5 to 5 minutes"),
                         a(href = "http://en.wikipedia.org/wiki/Old_Faithful", "source:wikipedia"),
                         img(src = "Old_Faithfull.jpg", height = 400, width = 400)
                 ),
                mainPanel(
                        br(),                        
                        p("This application uses the R dataset", a(href="http://stat.ethz.ch/R-manual/R-devel/library/MASS/html/geyser.html", "geyser"), ".It is a version of the eruptions data from the 'Old Faithful' geyser in Yellowstone National Park, Wyoming."),
                        p("In the",strong("Try it out"), "tab, you will be able to predict the eruption duration for the usual waiting time (between 40 minutes and 100 minutes)"),
                        br(),
                        p("A linear model is built on the dataset for predicting the duration of geyser eruption based on the waiting time between eruptions."),
                        br(),
                        p("The dataset was split into training and test sets and the model was built on the training set. Effectiveness of the model is tested using test set. "),
                        p("A plot of the predicted values of eruption duration for the waiting times in the entire dataset can be found below. Red line shows the fitted linear model and the green lines show the prediction intervals."),
                        plotOutput("omap")
                        
                )
        ),
        
        tabPanel("Try it out",
                 sidebarPanel(
                         h3('Input section'),
                        sliderInput('waittime', 'Select waiting time (in minutes) : ', value = 40, min = 40, max = 100, step = 1),
                        submitButton('Submit')
                        
                 ),
                 mainPanel(
                         h3('Results section'),
                         h5("You selected : "),
                         verbatimTextOutput("owaittime"),
                         h5("Predicted duration of eruption (in minutes) : "),
                         verbatimTextOutput("oduration")
                         )
        )
)
)
