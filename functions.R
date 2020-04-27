

sim_out<-function(n_start,avg_offspring,avg_mortality,generations){
  
  pop<-vector(length=generations)
  
  pop[1]<-n_start
    
  for (i in 2:generations){
    
    pop[i]<-(pop[i-1]-avg_mortality)*avg_offspring
    
    if (pop[i]<=0) break
  }
  
  tibble(pop_size=pop) %>%
    mutate(gen=1:n())->sim
 
  return(sim) 
}




