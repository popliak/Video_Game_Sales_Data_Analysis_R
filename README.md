# Video_Game_Sales_Data_Analysis_R
Exploring Video games sales data (2003-2004) using R programming language

Explanation of dataset: This dataset was provided by the instructor for one of the data analysis course and is based off of real world data. Data dictionary can be found in the appendix.
Purpose: To determine the relationship between Life to date sales and various other variables to find how to maximize revenue. The purpose is not to find a real-world root cause but to use my skills in R and data analysis on a real-world dataset.
Skills and tools used: 
-	R for data analysis
-	Data cleaning and recoding
-	Tidyverse, Pacman, rio, Janitor and QuantPsyc packages
-	Data wrangling using filter and mutate command for recoding and computing variables
-	Multiple and linear regression using scatter plots, correlation matrix 

Verifying the assumptions for the validity of multiple linear regression:
We asked R to give us some diagnostic plots for our regression results that would help to verify if our regression model meets the assumptions for a valid linear regression.
 ####  
   ![image](https://user-images.githubusercontent.com/96156022/147822730-0a87c7fc-464b-446e-96db-8fce1cccf7ce.png)
   ![image](https://user-images.githubusercontent.com/96156022/147822742-bd2f558b-c88b-418f-9bb0-406bd99b40c7.png)

1.	Relation between X and Y is linear (linearity) : If the relation was linear we would have seen an almost straight line in the residuals v/s fitted plot. Hence, this assumption is not satisfied as of now.
2.	The residuals are normally distributed: As seen from the residual-fit plot and the Quantile-Quantile (Q-Q) plot, residuals are not normally distributed. Hence, this assumption is also violated.
3.	There is no multi-collinearity in data: Using the scatterplot matrix (full matrix in appendix) it was clear that, First year sales is highly correlated with life to date sales, but it has no business meaning since we cannot say that the root cause of success in video games is making more revenue in the first year. Secondly, another scatterplot shows that first year units sold and life to date units sold are correlated which creates the same problem of inadequate business meaning. Hence, for our regression analysis, first year sales, first year units sold and last year units sold would be removed to make sure we get accurate regression results and its assumptions are not violated.

![image](https://user-images.githubusercontent.com/96156022/147822772-65ecbb83-52ef-4b4d-bc8a-ef116e1d0774.png)
![image](https://user-images.githubusercontent.com/96156022/147822793-6963ce8e-a98f-4976-b0b1-2aebfcedac31.png)
  
4.	The value of residuals are independent: This can be verified using the Durban-western test in R.


![image](https://user-images.githubusercontent.com/96156022/147823020-77b6c65d-e01c-481d-bfbc-f4e0802e6be2.png)
 
 
Since the p value is less than 0.05, we reject the null hypothesis that the error terms are independent, which means we do not have enough evidence to believe that errors are independently distributed. Hence, this assumption is violated.
Roadblock: The assumptions for a valid regression model are being violated leading to a bias or invalid model.
Solution: We will try to use natural log to make the distribution more normally distributed and avoid overfitting the model since we have too many variables that might be skewing with the distributions of the residuals.
Re-Verifying the assumptions of linear regression again with the log-transformed response variable (Logged LTD dollars):



We produced another set of diagnostic plots with the log-transformed response variable:

![image](https://user-images.githubusercontent.com/96156022/147823048-96264834-aaa6-41ed-998c-cdf2324e16c3.png)
![image](https://user-images.githubusercontent.com/96156022/147823059-2bd20d4a-a4f0-4bcc-8272-cfed8f63f180.png)

   
1.	Linearity: As the residual v/s fitted plot indicates the line is much straighter than it was before and the skew in the line might be attributed to the presence of very large outliers, once dealt with the outliers, we might see a fairly straight line throughout the model.
2.	Normal distribution of residuals: We can see that Q-Q plots gives us a fairly straight line for the residuals, means that residuals are now normally distributed.
3.	There is no multi-collinearity: These assumptions are still valid as we do not have any correlated variables in the model.
4.	Independence of error terms: We re-ran the Dublin-Watson test and it returned the following results: 
![image](https://user-images.githubusercontent.com/96156022/147823076-b70aab92-6def-42c4-9d08-f4c68b1dea09.png)
 
Since the p value is less than 0.05, we reject the null hypothesis that the error terms are independent, which means we do not have enough evidence to believe that errors are independently distributed. Hence, this assumption is violated. This indicates there might be a chance of bias in the model.

Limitations of the model and analysis: The dataset is derived from a real-world data, and it is quite complex to get the data to match all our expectations, such as not meeting all the assumptions of the regression analysis. Since my objective is to showcase the application of my skills in R programming language, I still decided to carry on with the analysis. Given an ideal environment with more sophisticated tools (such as tools to solve non-linear regression) we would have derived some more useful results but given the limited availability of tools and nature of our data I will try my best to do the best analysis as per my knowledge.

Analysis: Running the regression analysis will show the coefficients and significance of various variables that influence Life to date sales for videogames.
Regression results with Ltd dollars (sales revenue) as response variable and other relevant variables as explanatory variables:

 ![image](https://user-images.githubusercontent.com/96156022/147823132-49bddb67-2ce9-4f0b-90f7-98d56e1942c5.png)
![image](https://user-images.githubusercontent.com/96156022/147823136-f2d3814f-9514-4b91-9d5b-a9e011ee9ba2.png)
![image](https://user-images.githubusercontent.com/96156022/147823139-26949b14-ef00-4b6d-b01b-ce31c6e59036.png)

These estimates gives a high level overview of how much each variable impacts the Ltd dollars, however to compare these explanatory variables with each other requires standardized coefficent estimates, hence we’ll get R to give us the standardized estimates.

![image](https://user-images.githubusercontent.com/96156022/147823155-c92fce6e-5ac8-4010-9e91-538f82bd2414.png)

 
As the standardized estimates indicates, review and other consoles (GCN<ps2<xbx) ranks as the highest driving factors (in terms of standard deviation) for ltd dollars. These variables being the driving factor for ltd sales is counter-intuitive since, review is given after the game is released. It cannot be said for a game to do better, we need to make a game that will get better review from critics. XBOX, GCN, PS2 are the indicator variables showing whether the game was released on these platforms, which means that games will earn higher if they are released on GCN than ps2 or Xbox but that cannot be the only be the deciding factor for making business decisions.

 ![image](https://user-images.githubusercontent.com/96156022/147823166-c8b25a4a-ef15-4514-86d1-a023b2d9738e.png)

The adjusted R-square is 0.5085 which means that the model explains almost 50% of variability in the response variable.
Conclusion: The results of the regression do not provide much insights into root cause of video game sales but gives an overview of how different variables affect the total life to date sales of video games. In business context, the video game companies look at these results and can eliminate any variables that the regression deems as insignificant and can further analyze the results to find useful patterns of data.



Appendix

Correlation Matrix 
 ![image](https://user-images.githubusercontent.com/96156022/147823187-5e8038db-70ca-4741-b530-749d361fc375.png)

Diagnostic plots for response variable before logging ltd dollars.
 ![image](https://user-images.githubusercontent.com/96156022/147823191-57bc4d51-b565-4829-8875-644d125c5488.png)

Diagnostic Plots for log-transformed response variable:
 ![image](https://user-images.githubusercontent.com/96156022/147823201-4ec2c432-384c-4380-9c4f-51756984e8ed.png)

