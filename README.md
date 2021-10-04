# Pricing Strategy Airbnb based on Negative Reviews

Do higher prices of Airbnb accommodations result in a higher relative number of negative reviews for the specific accommodation?


## Motivation

The success of online marketplaces depends not only on how easily buyers can find the right sellers for them, but also on the level of trust there is prevalent. Feedback systems can help in establishing this trust ([Tadelis, 2016](https://www.annualreviews.org/doi/abs/10.1146/annurev-economics-080315-015325)). For the design of feedback systems, it is important to understand how reviews are generated and whether these can be influenced by agents ([Carnehl et al., 2021](http://www.kevintran.eu/files/airbnb_ratings_paper.pdf)). This research will focus on how prices may influence the relative amount of negative reviews for Airbnb accommodations. In line with [Carnehl et al. (2021)](http://www.kevintran.eu/files/airbnb_ratings_paper.pdf), it is expected that higher prices may result in a higher relative amount of negative reviews. This can be explained by the fact that higher prices lead to higher expectations for consumers which in turn may result in them being easier dissatisfied. 

Concretely, this study investigates the relationship between price and negative reviews. In this way, it can be studied whether:
- Charging a higher price is a risk in terms of setting the expectations too high, resulting in more negative reviews or;
- Charging a higher price does not lead to more negative reviews, as expectations are likely to be met. 
Eventually, there is also a possibility that there is no significant correlation between these two variables. 

With the results of this analysis, Airbnb hosts can decide upon which price to charge for their accommodation with the results of this study in mind. Carefully setting the price of an accommodation can prevent dissatisfied customers and possible accompanying negative consequences.

## Data

For this project, available Airbnb data is used from [Inside Airbnb](http://insideairbnb.com/get-the-data.html). Both datasets which were used are about Airbnb listings and reviews in Amsterdam, North Holland, The Netherlands. 

<img src="https://60days.nl/wp-content/uploads/2016/12/airbnb-amsterdam.jpg" width="450">

## Method and results

The method used to indicate the amount of negative reviews per accommodation is a sentiment analysis. Sentiment analysis is used to identify how sentiments are used in text and if they indicate a positive or negative opinion toward the subject (A). We will use this to classify whether a review is positive, negative or neutral. 

To expand the sentiment analysis, we will also make use of a text analysis. By using a text analysis we will identify 10 topics amongst all reviews generated. With this we can see what topic is defined in the review and then see whether there are positive, negative or neutral reviews associated with this topic.

(First, introduce and motivate your chosen method, and explain how it contributes to solving the research question/business problem.

Second, summarize your results concisely. Make use of subheaders where appropriate.)

## Repository overview

Provide an overview of the directory structure and files.

## Running instructions

Explain to potential users how to run/replicate your workflow. Touch upon, if necessary, the required input data, which (secret) credentials are required (and how to obtain them), which software tools are needed to run the workflow (including links to the installation instructions), and how to run the workflow. Make use of subheaders where appropriate.

## More resources

Point interested users to any related literature and/or documentation.

## About

This study is conducted for the [Data Preparation and Workflow Management](https://dprep.hannesdatta.com/) course of the TISEM department of Tilburg University. This course is part of the master Marketing Analytics program. The study is conducted by team 4 with the following members: [Noa Beekmans](https://github.com/noa-beekmans), [Pien Korteweg](https://github.com/eakorteweg), [Rashel Mol](https://github.com/Rashel-Mol), [Astrid Raaijmakers](https://github.com/AstridR97), [Amber Vermeer](https://github.com/AmberVermeer). Professor [Hannes Datta](https://github.com/hannesdatta) supervised the study and provided feedback.
