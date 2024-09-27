select * from retail_sale

-- q1 write a sql query to find out all the coloumns for sale made on '2022-11-05'
select * from retail_sale where sale_date = '2022-11-05'

-- q2 write a sql query to retreive all the transaction where the category is 'clothing' and the quantity sold is more than 
    4 in the month of nov 2022
select * from retail_sale where category = 'clothing'
and to_char(sale_date,'yyyy-mm') = '2022-11'
and quantity >=4

--q3 write a sql query to find out total sales (total_sale) for each category
select category ,sum(total_sales) as total_sale_category from retail_sale group by category order by 2 desc
 
-- q4 write an sql query to find out average age of customers who purchased from the 'beauty' category
select avg(age) as avg_age from retail_sale where category ='beauty'

--q5 to find out all the transactions where total_sales is greater than 1000
select * from retail_sale where total_sales > 1000

--q6 find total number of transactions (transactions_id) made by each gender in each category
select count(transactions_id) as total_transactions ,gender, category from retail_sale group by gender, category

--q7 write the sql query to calculate the average sale for each month . find out the best selling month in each year
select year, month , avg_sale from (
select extract(year from sale_date) as year , extract(month from sale_date) as month,
AVG(total_sale) as avg_sale , rank() over (partition by extract(year from sale_date) order by AVG(total_sale)desc) as rank
from retail_sale
group by 1,2) as t1
where rank = 1

--Q8 find the top 5 customers based on the highest sales
select customer_id, sum(total_sales) as net_sales from retail_sale order by sum(total_sales)  desc
group by customer_id
limit 5

--q9 find the unique customers who purchased items from each category
select category, count(distinct customer_id) as cnt_unique_cs from retail_sale
group by category

--Q10 write a sql query to create each shift and number of orders (example morning<=12 , afternoon between 12 &17 ,evening >17)

with hourly_sales as
(select * , case when extract(hour from sale_time) <=12 then 'morning'
when extract(hour from sale_time) between 12 and 17 then 'afternoon'
else 'evening'  end as shift
from retail_sale)

select shift ,count(*) as total_orders
from hourly_sales
group by shift

-- end of project









