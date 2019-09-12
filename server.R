# Server 
server <- function(input, output, session) {
    
    rv<-reactiveValues()

    observeEvent(input$run_sim,{
        
        data<-sim_out(input$n_start,
                input$avg_offspring,
                input$avg_mortality,
                input$generations)
        
        if (is.null(rv$data)) rv$data<-data 
        
        else bind_rows(rv$data,data)->rv$data

        rv$data %>% 
            mutate(sim=cumsum(gen==1)) %>%
            mutate(sim=as.character(sim))->rv$data
        
        if (is.null(rv$param)) rv$param <- tibble(pop_size=input$n_start,
                                                  clutch_size=input$avg_offspring,
                                                  mortality=input$avg_mortality,
                                                  gen=input$generations)
        else bind_rows(rv$param,tibble(
                    pop_size=input$n_start,
                    clutch_size=input$avg_offspring,
                    mortality=input$avg_mortality,
                    gen=input$generations))->rv$param
        
         
        rv$data %>%
            group_by(sim)%>%
            summarise(n=last(pop_size))->max_n
            
        rv$param %>% 
            mutate(sim=1:n()) %>%
            mutate(sim=as.character(sim)) %>%
            select(sim,pop_size,clutch_size,mortality,gen) %>%
            left_join(.,max_n,by="sim")->rv$param
        })
    
    output$plot<-renderPlot({
        validate(
            need(!is.null(rv$data), "Choose starting parameters and then run simulation")
        )
        rv$data %>%
            ggplot()+
            geom_line(aes(gen,pop_size,group=sim,color=sim),size=1)+
            geom_point(aes(gen,pop_size,color=sim),size=2)+
            scale_colour_discrete(name  ="Simulation #")+
            xlab("Generation")+
            ylab("Population size")
        
    })
    
    output$paramters<-renderTable({
        
        validate(
            need(!is.null(rv$data), " ")
        )
        rv$param %>% 
            rename(`Simulation #`=sim,
                `Starting pop size`=pop_size,
                `Clutch size (average)`=clutch_size,
                `Mortality per generation`=mortality,
                `Total generations`=gen,
                `Final pop size`=n)
        
        # tibble(pop_size=input$n_start,
        #        clutch_size=input$avg_offspring,
        #        mortality=input$avg_mortality,
        #        gen=input$generations)
        # 
        
    },
    striped = TRUE,  
    spacing = 'xs',
    width = '100%')
    
    observeEvent(input$restart,{
        
        rv$param<-NULL
        rv$data<-NULL
    })
}