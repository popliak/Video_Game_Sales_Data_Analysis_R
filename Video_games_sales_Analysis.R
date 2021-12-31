### Installing relevant packages######
install.packages("pacman")

### Asking pacman to load additional packages
pacman::p_load(pacman,tidyverse,rio,janitor,QuantPsyc,lmtest)

##Importing required dataset and storing it into dataframe#####
df<-import("VideoGameSalesData.xlsx") %>%
  as_tibble()

####Removing spaces and changing capitalization for column names ####
library(janitor)
df3<- clean_names(df)
(names(df3))

### Getting the scatterplot matrix to view collinearity in variables ####
### graphics.off() ###uncomment this if margins too large error occurs or increase the size of plots window
pairs(df3[,17:30],pch = 20,col= 'blue', lower.panel = NULL)

#### Running regression test####
  
fit1<- lm(ltd_dollars_m ~ gcn + xbx + ps2 
          + review + prior_release_genre 
          + total_prior_sales_brand_m + first_year_ratio
          + avg_release_year_price + concurrent_release_brand
          + concurrent_release_genre + prior_release_brand
          + ltd_asp, data = df3 )

summary(fit1)


 ## converting unstandardized coefficents into standardized
lm.beta(fit1)

##Creating residual plots####

res<-resid(fit1)

plot(fitted(fit1), res, ###adding more options to the plot
     main = "Residual-fit plot for ltd_dollards (M)",
     xlab = "Fitted value",
     ylab = "Residuals",
     col = "gray",
     pch = 20
     )
abline(fit1) ##Adding line to the plot

qqnorm(res,
       main = "Q-Q plot for Ltd_dollars (M)",
       col= "#A7CAE9",
       pch= 20) ## Getting a Q-Q plot
qqline(res) ## adding line to the Q-Q plot
hist(res)


## Recoding the ltd dollars into log ltd dollars####

df4<- df3 %>%
  mutate(logged_ltd_dollars = log(ltd_dollars_m))

###re-running the regression with logged variables####


fit2<- lm(logged_ltd_dollars ~ gcn + xbx + ps2 
          + review + prior_release_genre 
          + total_prior_sales_brand_m + first_year_ratio
          + avg_release_year_price + concurrent_release_brand
          + concurrent_release_genre + prior_release_brand
          + ltd_asp, data = df4)

summary(fit2) ## regression results unstandardized coefficents
confint(fit2) ##Getting confidence intervals around the coefficicents 
### Converting unstandardized coefficents into standardized coefficents####
lm.beta(fit2)

### New regression residual plots
res1<-resid(fit2)

plot(fitted(fit2), res,
     main = "Residual-fit plot for logged ltd_dollards (M)",
     xlab = "Fitted value",
     ylab = "Residuals",
     col = "gray",
     pch = 20)
abline(0,0) ##Adding line to the plot

qqnorm(res1,
       main = "Q-Q plot for logged Ltd_dollars (M)",
       col= "#A7CAE9",
       pch= 20) ## Getting a Q-Q plot
qqline(res1) ## adding line to the Q-Q plot
hist(res1)


### Getting diagnostic plots to verify assumptions of regression####
plot(fit2)
plot(fit1)  


par(mfrow=c(2,2))## run this if you want all diagnostic plots in a single view

###Running a Durbin watson test to check independence of errors
dwtest(fit1)
dwtest((fit2))

