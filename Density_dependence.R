K = 3000
R = 1.3
g<-vector()
x<-vector()
x[1]<-1
gen<-100
for (i in 1:gen){ 
#g[i]<-length(unique(sample(1:K,size = x[i],replace = T)))
#x[i+1]<-(g[i])*R

g[i]<-sum(duplicated(sample(1:K,x[i],replace = T)))
x[i+1]<-(x[i]-g[i])*R

}


plot(1:gen,x[1:gen],"l",ylim=c(0,K+100))
lines(g,col="red")
abline(h=K,lty=3)

plot(1:(gen-1),x[2:gen]/x[1:(gen-1)], type = "l")

hist(replicate(100,sum(duplicated(sample(1:100,20,replace = T)))))



####
# Thus space limitation can be used to derive a
# logistic growth equation, but the so-called carrying 
# capacity, K, is less than the total number
# of available spaces, T, by a factor (b0 − d0)/b0
# K = alpha/r, r = b0-d0
# dN/dt=r-aplha*N

K<-800
R<-2.0
x<-vector()
repro<-vector()
surv<-vector()
x[1]<-1
for (i in 1:99){ 
	repro[i]<-(x[i]*R)
	surv[i]<-(1-(x[i]/K))
	
	x[i+1]<-repro[i]*surv[i]
}

for (i in 1:99){ 
	repro[i] <-x[i]*R
	surv[i] <- (x[i]*R)*(x[i]/K)
	x[i+1]<- repro[i] - surv[i]
	}

plot(x)

lines(x)
lines(repro)
diff(x)
x[2:100]/x[1:99]

repro
surv
repro*surv


### density dependence 
### mortality and/or reproductive output is proportional to density
### y = mx + b where b = maximum reproductive ouput when population is small (0) and 
### x is slope or the proportional reduction in reproductive output/survival per indiviudal 
## in the population. Could be a non-linear relationship between x and y (x^2, x^3, e^x). 
