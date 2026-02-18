#1 	Here is the proper question formed from the image:
	#Create a query that adds an “Amount Category” column to the sales table and classifies each shipment as:**
	# **‘Under 1000’** if amount ≤ 1000
	# **‘Under 5000’** if amount is between 1000 and 5000
	# **‘Under 10000’** if amount is between 5000 and 10000
select SaleDate , Amount, 
		case 	when amount < 1000 then 'Under 1k'
				when amount < 5000 then 'Under 5k'
                when amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount Catogory'
from sales;

#2	Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales
where amount > 2000 and boxes < 100;

#3	Which product sells more boxes? Milk Bars or Eclairs?
select pr.Product, sum(Boxes) as 'Total_Boxes'
from sales s
join products pr on s.pid = pr.pid
where pr.Product in ('Milk Bars', 'Eclairs')
group by pr.product ;

#4	Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?2
select pr.product , sum(boxes) as 'Total_Amount'
from sales s
join products pr on s.pid = pr.pid 
where pr.product in ('Milk Bars', 'Eclairs')
and s.saledate between '2022-02-01' and '2022-02-07'
group by pr.Product;

#5	Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select * from sales s
where s.customers < 100 and s.boxes < 100
order by s.customers desc;

select *,
case when weekday(s.saleDate)=2 then 'Wednesday Shipment'
else 'Other Day'
end as 'Wednesday Shipment'
from sales s 
where customers < 100 and boxes < 100;

select * from sales;
select * from people;

#6	What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?
select distinct p.Salesperson
from sales s 
join people p on p.spid = s.spid
where s.saledate between '2022-01-01' and '2022-01-07';

#7	Which salespersons did not make any shipments in the first 7 days of January 2022?
select p.salesperson
from people p
where p.spid not in 
(select distinct s.spid from sales s where s.saledate between '2022-01-01' and '2022-01-07');

#8	How many times we shipped more than 1,000 boxes in each month?
select year(saledate) 'Year' , month(saledate) 'Month' , count(*) 'Times we shipped 1k boxes'
from sales
where boxes>1000
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

#9	Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select year(s.saledate) 'Year' , month(s.saledate) 'Month' , if(sum(s.boxes) > 1 ,'Yes', 'No') 'Status'
from sales s
join products pr on pr.pid = s.pid
join geo g on g.geoid = s.geoid
where pr.product = 'After Nines' and g.geo = 'New Zealand'
group by year(s.saledate) , month(s.saledate)
order by year(s.saledate) , month(s.saledate);

#10	India or Australia? Who buys more chocolate boxes on a monthly basis?
select year(saledate) 'Year' , month(saledate) 'Month', 
	sum(case when g.geo = 'india'= 1 then boxes else 0 end) 'India Boxes' ,
    sum(case when g.geo = 'australia'=1 then boxes else 0 end) 'Australia Boxes'
from sales s
join geo g on g.geoid = s.geoid
group by year(s.saledate) , month(s.saledate)
order by year(s.saledate) , month(s.saledate);    

