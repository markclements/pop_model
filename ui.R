# UI
ui <- fluidPage(
  
  column(width=2,
         style = "background-color:lightgrey;",
         numericInput(inputId = "n_start",
                      label = "Starting population size",
                      value = 100,
                      min = 1,
                      max = 100,
                      step = 1),
         numericInput(inputId = "avg_offspring",
                      label="Clutch size (average)",
                      value=1,
                      min=0,
                      max=10,
                      step=0.01),
         numericInput(inputId = "avg_mortality",
                      label="Mortality per generation",
                      value=0,
                      min=0,
                      max=100,
                      step=1),
         numericInput(inputId = "generations",
                      label = "Number of generations to simulate",
                      value = 10,
                      min=1,
                      max=500,
                      step=1),
         hr(),
         actionButton(inputId = "run_sim",
                      label = "Run simulation"),
         br(),
         br(),
         actionButton(inputId = "restart",
                      label= "Start over"),
         br(),
         br()
  ),
  
  column(width=10,
         plotOutput("plot"),
         tableOutput("paramters")
         )
  
)