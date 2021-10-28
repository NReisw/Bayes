#Load Library and Set Path
library(rethinking)
Sys.setlocale(locale='Chinese') #Makes the histograms show
#setwd("C:/Users/brad.davis/Desktop/Dakota/PerforationStan")

#Load Experimental Data as e
#e <- read.table("expdata.dat",header=TRUE,sep="")
e <- read.table(file = 'C:/Users/Gregory Langone/OneDrive - West Point/OneDrive/Cow Year/1st Semester/CE 389 - Independent Study/R files/expdata.dat')

#Load Perforation Simulations Data as v, Penetration Simulations Data as d
#v <- read.table("epicdata.dat",header=TRUE,sep="")
v <- read.table(file = 'C:/Users/Gregory Langone/OneDrive - West Point/OneDrive/Cow Year/1st Semester/CE 389 - Independent Study/R files/epicdata.dat', header=TRUE,sep="")

#Mean/SD and min/max of data
a_mean<-mean(v$A______)
b_mean<-mean(v$B______)
n_mean<-mean(v$n______)
c_mean<-mean(v$c______)
s_mean<-mean(v$s______)
d_mean<-mean(v$d______)
pc_mean<-mean(v$pc_____)
uc_mean<-mean(v$uc_____)
k1_mean<-mean(v$k1_____)
k2_mean<-mean(v$k2_____)
k3_mean<-mean(v$k3_____)
ul_mean<-mean(v$ul_____)
pl_mean<-mean(v$pl_____)
y_mean<-mean(v$obj_fn)
y_max<-max(v$obj_fn)
y_min<-min(v$obj_fn)
v_max<-max(v$vel____)
v_min<-min(v$vel____)
theta_max<-max(v$theta__)
theta_min<-min(v$theta__)

a_sd<-sd(v$A______)
b_sd<-sd(v$B______)
n_sd<-sd(v$n______)
c_sd<-sd(v$c______)
s_sd<-sd(v$s______)
d_sd<-sd(v$d______)
pc_sd<-sd(v$pc_____)
uc_sd<-sd(v$uc_____)
k1_sd<-sd(v$k1_____)
k2_sd<-sd(v$k2_____)
k3_sd<-sd(v$k3_____)
ul_sd<-sd(v$ul_____)
pl_sd<-sd(v$pl_____)
y_sd<-sd(v$obj_fn)

#Standardize Training Parameters and put into a data frame
vel<-(v$vel____-v_min)/(v_max-v_min) #strike velocities are centered then standardized by the range to a 0-1 scale
theta<-(v$theta__-theta_min)/(theta_max-theta_min) #theta is centered then standardized by the range
a<-(v$A______-a_mean)/a_sd
b<-(v$B______-b_mean)/b_sd
n<-(v$n______-n_mean)/n_sd
c<-(v$c______-c_mean)/c_sd
s<-(v$s______-s_mean)/s_sd
d<-(v$d______-d_mean)/d_sd
pc<-(v$pc_____-pc_mean)/pc_sd
uc<-(v$uc_____-uc_mean)/uc_sd
k1<-(v$k1_____-k1_mean)/k1_sd
k2<-(v$k2_____-k2_mean)/k2_sd
k3<-(v$k3_____-k3_mean)/k3_sd
pl<-(v$pl_____-pl_mean)/pl_sd
ul<-(v$ul_____-ul_mean)/ul_sd
y<-vel<-(v$obj_fn-y_min)/(y_max-y_min)

#Training Data Set
dat_slim <- cbind(vel,theta,a,b,n,c,s,d,pc,uc,k1,k2,k3,pl,ul,y)
x <- cbind(vel,theta,a,b,n,c,s,d,pc,uc,k1,k2,k3,pl,ul)
#matrix dimensions
N<-nrow(dat_slim)
D<-ncol(dat_slim)-1

stan_data <- list(N=N, D=D, x=x, y=y)
fit<- stan(file = 'C:/Users/Gregory Langone/OneDrive - West Point/OneDrive/Cow Year/1st Semester/CE 389 - Independent Study/R files/GP model att3_code.stan', 
           data = stan_data)

#Plot of prior simulation v. experimental
plot(v$vel____,v$obj_fn,xlab="Strike Velocity [m/s]", ylab="Residual Velocity [m/s]",
     xlim=c(300, 800), ylim=c(200, 700))
points(e$vs[1:5],e$obj[1:5],col='black',pch=16, cex=1)




