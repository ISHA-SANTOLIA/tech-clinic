select * from credit_card_transactions1

select count(*)
from Isha.INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='credit_card_transactions1'

--solve below questions
--1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends


with cte as 
(select city,sum(amount) as total_spends
from credit_card_transactions1
group by city), bte as 
(select sum(amount) as total_expense
from credit_card_transactions1)

select top 5 cte.*,(total_spends/total_expense)*100 as percentage
from cte inner join bte
on 1=1
order by total_spends desc

--2- write a query to print highest spend month and amount spent in that month for each card type

select * from credit_card_transactions1

with cte as 
(select card_type,datepart(year,transaction_date) as yr, datepart(month,transaction_date) as mth, sum(amount) as spend
from credit_card_transactions1
group by card_type,datepart(year,transaction_date), datepart(month,transaction_date) 
)
select * from ( select *, rank() over(partition by card_type order by spend desc) as rn from cte) as A
where rn=1


select DB_NAME() as CurrentDatabase;

Use Isha;

--3- write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte as 
(select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id ) as total_spends
from credit_card_transactions1)

select * from (select *, rank() over(partition by card_type order by total_spends ) as rn from cte where total_spends>=1000000)  as A
 where rn=1

 --4- write a query to find city which had lowest percentage spend for gold card type

 with cte as
 (select top 1 city,card_type,sum(amount)as spend 
 from credit_card_transactions1
 group by city,card_type
 having card_type='Gold'), bte as

 (select sum(amount) as total_spend
 from credit_card_transactions1)

 select cte.*,(spend/total_spend)*100 as percentage_spend
 from bte inner join cte on 1=1
 order by percentage_spend 
 
 --5 write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

 select * from credit_card_transactions1
 
 with cte as 
 (select city,exp_type,sum(amount) as expense
 from credit_card_transactions1
 group by city,exp_type)
 select city,min(case when rn_desc=1 then exp_type end) as highest_expense,max(case when rn_asc=1 then exp_type end) as lowest_expense
 from  (select *,rank() over (partition by city order by expense desc) as rn_desc, rank() over(partition by city order by expense asc) as rn_asc from cte) as A
 group by city

 --6- write a query to find percentage contribution of spends by females for each expense type

 select * from credit_card_transactions1


 select *,(spend_by_F/total_spend) as Percentage_spend_by_F
 from (
 select exp_type,sum(amount) as total_spend,sum(case when gender='F' then amount end)as spend_by_F
 from credit_card_transactions1
 group by exp_type)
 as A 
 order by Percentage_spend_by_F
 
 --7- which card and expense type combination saw highest month over month growth in Jan-2014

 select top 1*,(spend-prev_yr_spend) as mom_growth
 from (
 select *,lag(spend,1) over(partition by card_type,exp_type order by yt,mnth) as prev_yr_spend
 from (select card_type,exp_type,datepart(year,transaction_date) as yt, datepart(month,transaction_date) as mnth, sum(amount)as spend
 from credit_card_transactions1
 group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date))as A
 )
 as B
 where yt =2014 and mnth= 01
 order by mom_growth desc

--9- during weekends which city has highest total spend to total no of transactions ratio 

select* from credit_card_transactions1

  select top 1*,(total_spend/total_trans) as ratio
  from ( select city,sum(amount)as total_spend,count(transaction_id) as total_trans
  from credit_card_transactions1
  where datepart(weekday,transaction_date) in (1,7)
  group by city)
  as A
  order by ratio desc

--10- which city took least number of days to reach its 500th transaction after the first transaction in that city

--select city,datediff(day,max(case when rn=1 then transaction_date end),min(case when rn=500 then transaction_date end)) as no_of_days
--from (select *,rank() over (partition by city order by transaction_date) as rn 
--from credit_card_transactions1)
--as A
--group by city,transaction_date
















 












