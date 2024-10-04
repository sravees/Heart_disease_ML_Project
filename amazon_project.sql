use amazon;
select * from amazo;
#1.What is the count of distinct cities in the dataset?
select count(distinct city) as cities  from amazo;

#2.For each branch, what is the corresponding city?
select distinct branch,city from amazo;

#3.What is the count of distinct product lines in the dataset?
select count(distinct `Product line`) as distinct_productline
from  amazo;

#4.Which payment method occurs most frequently?
select Payment,count(Payment) as payment_method from amazo
group by Payment 
order by payment_method desc
limit 1;

#5.Which product line has the highest sales?
select `Product line`,count(Quantity)
as total_sales from amazo
group by `Product line`
order by total_sales desc
limit 1;

#6.How much revenue is generated each month?
select distinct monthname(Date) as month_name, sum(total) as monthly_sales from amazo
group by monthname(Date);

#7.In which month did the cost of goods sold reach its peak?
select distinct monthname(Date) as month_name, max(Cogs)
OVER(partition by monthname(Date)) as highest_cogs from amazo
order by highest_cogs desc
limit 1;


#8.Which product line generated the highest revenue?
select `Product line`, sum(total) as highest_revenue from amazo
group by `Product line`
order by highest_revenue desc
limit 1;

#9.In which city was the highest revenue recorded?
select City, sum(total) as highest_revenue from amazo
group by City
order by highest_revenue
limit 1;

#10.Which product line incurred the highest Value Added Tax?
select `Product line`,sum(`Tax 5%`)
as highest_value from amazo
group by `Product line`
order by highest_value 
limit 1;

#11.For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
select `Product line`,
case 
    when total > avg_total THEN 'Good'
    ELSE 'Bad'
    end as total_classification
    from (
    select 
        `Product line`,total,avg(total)
        over() as avg_total
        from amazo) as subquery_alias;
#12.Identify the branch that exceeded the average number of products sold?
with average_sales as (
    select avg(
`Product line`)
as 
    avg_num_products  from amazo
    )select branch
from amazo
cross join
average_sales
group by branch
having sum(`Product line`)>(select avg_num_products from average_sales);






#13.Which product line is most frequently associated with each gender?
select `Product line` ,gender ,count(*) as frequency from amazo
group by gender, `Product line`
having frequency = (
select max(sub.frequency)
from(select gender,`Product line`,count(*) as frequency from amazo
group by gender,`Product line`) as sub
where sub.gender=amazo.gender);

#14.Calculate the average rating for each product line?
select `Product line`, avg(rating) as avg_rating from amazo
group by `Product line`;

#15.Count the sales occurrences for each time of day on every weekday?
select dayname
(`Invoice ID`) as weekday,hour(`Invoice ID`) as hour_of_day,
count(*) as sales_occurance
from amazo
where dayofweek(`Invoice ID`) between 2 and 6
group by weekday,hour_of_day
order by weekday,hour_of_day;

#16.Identify the customer type contributing the highest revenue.
select `Customer type`,
sum(total) as highest_revenue from amazo
group by `Customer type`
order by highest_revenue desc
limit 1;

#17.Determine the city with the highest VAT percentage.
select city,COALESCE(sum(
`Tax 5%`)/NULLIF(sum(total),0)*100,null)

as highest_vatpercentage from amazo
group by city
order by highest_vatpercentage desc;



#18.Identify the customer type with the highest VAT payments?
select `Customer type`,sum(`Tax 5%`) 
as highest_vatpayments from amazo
group by `Customer type`
order by highest_vatpayments desc;

#19.What is the count of distinct customer types in the dataset?
select count(distinct 
`Customer type`) as distinct_customer_type
from amazo;
 
 #20.What is the count of distinct payment methods in the dataset?
select count(distinct payment) as payment_methods from amazo;

#21.Which customer type occurs most frequently?
select 
`Customer type`,count(*) as frequently from amazo
group by `Customer type`

order by frequently desc
limit 1;

#22.Identify the customer type with the highest purchase frequency?
select `Customer type`,count(*) as highest_frequency from amazo
group by `Customer type`
order by highest_frequency desc
limit 1;

#23.Determine the predominant gender among customers?
select gender,count(*) as gender_count from amazo
group by gender 
order by gender_count desc
limit 1;

#24.Examine the distribution of genders within each branch?
select branch,count(*) as each_branch from amazo 
group by branch
order by each_branch desc;

#25.Identify the time of day when customers provide the most ratings?
select hour(time) as hour_of_day, count(*) as rating_count
from amazo 
group by hour_of_day
order by rating_count desc;

#26.Determine the time of day with the highest customer ratings for each branch?
select branch, hour(time) as hour_of_day,max(rating) as highest_ratings from amazo
group by branch,hour_of_day 
order by branch,highest_ratings desc;

#27.Identify the day of the week with the highest average ratings?
select 
(`Date`),
avg(rating) as average_rating
from amazo
group by (`Date`)
order by average_rating desc
limit 1;


#28.Determine the day of the week with the highest average ratings for each branch?
select branch,(time) as day_of_week, avg(rating) as average_rating from amazo
group by branch,(time)
order by branch,average_rating desc; 



