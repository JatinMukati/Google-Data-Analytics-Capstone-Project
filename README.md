# Cyclistic Case Study - Google Data Analytics Capstone Project

## 1. Introduction
This case study was conducted for the Google Data Analytics Certification Capstone Project: Case Study 1, "Cyclistic." It is my first data analytics case study, involving a fictional bike share company based in Chicago, USA. The company aims to analyze different user behaviors and improve marketing strategies based on user data. By understanding how users engage with Cyclistic’s services, the management hopes to devise new strategies to convert casual riders into annual members, increasing profitability. 

Following the steps outlined in the Google Data Analytics program (ask, prepare, process, analyze, share, and act), I will address the business questions, leaving the "act" phase for executive decision-making.

## 2. Scenario
Cyclistic operates over 5,800 bicycles, available across 600 docking stations in Chicago. Bikes can be borrowed and returned at any docking station. Cyclistic's management has identified that annual members are more profitable than casual riders. Lily Moreno, the Director of Marketing, wants to implement a new strategy to convert casual riders into annual members. The marketing analytics team has been tasked with analyzing one year’s worth of user data to identify trends in bike usage.

### Key Questions:
- How do annual members and casual riders differ?
- Why would casual riders consider buying a membership?
- How can Cyclistic use digital media to encourage casual riders to become members?

This study analyzes historical trip data to address these questions.

## 3. Phase 1: Ask

### 3.1 Business Objective
Increase profitability by converting casual riders into annual members through targeted marketing campaigns.

### 3.2 Business Task
The task is to analyze user data and answer the following questions:
- How do annual members and casual riders differ in their bike usage?
- What would motivate a casual rider to buy an annual membership?
- How can Cyclistic use digital media to influence casual riders?

### 3.3 Stakeholders
- **Lily Moreno**: Director of Marketing at Cyclistic
- **Cyclistic Marketing Analytics Team**: Responsible for analyzing and reporting data insights.
- **Cyclistic Executive Team**: Makes decisions on the final marketing strategy.

## 4. Phase 2: Prepare

### 4.1 Data Source
The data was sourced from Motivate, a company that collects bike-sharing usage data for the City of Chicago. [Link to data](https://www.divvybikes.com/system-data) (public data).

### 4.2 Data Organization
The dataset consists of monthly CSV files. Each file contains columns such as ride id, bike type, start time, end time, start station, end station, start location, end location, and whether the rider is a member or not.

### 4.3 Data Credibility
The data is directly collected by Motivate, making it comprehensive, consistent, and reliable for the intended analysis. The data includes all rides taken during the time period.

### 4.4 Licensing, Privacy, Security, and Accessibility
The dataset has been anonymized, removing personally identifiable information to protect user privacy. This limits certain analyses, such as determining whether casual riders are repeat users.

### 4.5 Data Suitability
The data is sufficient to answer the business questions regarding behavioral differences between casual riders and annual members.

### 4.6 Data Challenges
There were a few challenges with the data, including:
- **Duplicate records**
- **Missing data** (start or end station names)
- **Anomalies** in ride duration (very short or very long rides)
- **Trips starting or ending at administrative/testing stations**

I used SQL to clean and process the data, addressing these issues.

## 5. Phase 3: Process

### 5.1 Tools
For this analysis, I used - 
- SQL: Used for efficient handling of large datasets, data cleaning, and transformation.
- Excel: Assisted in some preliminary analyses and handling smaller datasets.
- Tableau: Used for visualizing trends and differences in user behavior.

### 5.2 Data Review and Cleaning
The initial review of the 12 CSV files included:
- Checking for missing values
- Removing duplicate records
- Addressing anomalies (e.g., invalid ride durations)

After cleaning, the final dataset contained 56,55,382 rows across 18 columns, matching the expected number of records.

You can find the SQL code used for data cleaning and analysis here: [SQL Code](https://github.com/JatinMukati/Google-Data-Analytics-Capstone-Project/blob/main/Google%20Data%20Analytics%20Capstone%20Project.sql)

## 6. Phase 4: Analyze

### Analysis Summary:
- **Members** accounted for 64% of total rides, with casual riders making up the remaining 36%.
- The **average ride length** for casual riders was 21.5 minutes, compared to 12.5 minutes for members.
- **Classic bikes** were the most popular for members, while casual riders slightly preferred **electric bikes**. **Docked bikes** were the least popular among casual riders.
- The most popular time to ride for both user types was in the **afternoon (12 pm - 5 pm)**, with **5 pm** being the peak hour.
- **Saturday** was the busiest day for both members and casual riders. Casual riders showed significant increases in ridership during the weekends, especially on Saturdays.
- **Summer** (June - August) was the busiest season, with ridership peaking in **July**. The least busy months were in the **winter** (December - February), with **January** seeing the fewest rides.
  
### Key Stats:
- **Total Rides**: 5.66 million
- **Average Ride Length**: 15.7 minutes
- **Busiest Weekday**: Saturday
- **Busiest Season**: Summer
- **Busiest Time**: Afternoon
- **Most Popular Bike**: Classic bike

## 7. Phase 5: Share
You can view the complete analysis and visualizations on my [Tableau Dashboard](https://public.tableau.com/app/profile/jatin.mukati/viz/GoogleDataAnalyticsCapstoneProjectJM/Dashboard).

## 8. Conclusion
The analysis highlights key differences between casual riders and annual members. By focusing on peak riding times and popular bike types, Cyclistic can target casual riders with digital media campaigns during high-usage periods. Offering promotions or incentives during summer and weekends could also help convert casual riders into members. Further, enhancing the experience for electric and docked bike users may be another strategy to explore.


