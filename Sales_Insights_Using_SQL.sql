#### Easy Quiries

#1. See all shipments
select * from shipments;
select Product, s.Date , Amount , Boxes From shipments s;

#2. All shipments by SP02
select * from shipments s
where s.`Sales Person` = 'SP02';

#3. All shipments by SP02 to G3
select * from shipments s
where s. `Sales Person` = 'SP02' and s. Geo = 'G3' 
order by s.Amount desc;

#4. All shipments in January 2023
select * from shipments_new s 
where s.Date between '2023-01-01' and '2023-01-31';

select * from shipments_new s
where extract(year_month from s.Date) = 202301;

#5. All shipments by SP02, SP03, SP12, SP15
select * from shipments_new s 
where s.`Sales Person` = 'SP02' 
	or s.`Sales Person` = 'SP03'
	or s.`Sales Person` = 'SP12'
	or s.`Sales Person` = 'SP15';

select * from shipments_new s
where s.`Sales Person` in ('SP02' , 'SP03' , 'SP12','SP15');

#6. Products that have the word “choco” in them
select * from products 
where product like '%choco%';

#7. Sales persons whose name begins with S
select * from people
where `Sales Person` like 'S%';



#### Intermediate Queries

#8. Sales per box of chocolates in February 2023
select s.Date, s.Amount, s.Boxes, round(s.Amount / s.Boxes,1) as 'Amount per Box' from shipments_new s
where Extract(year_month from s.Date) = '202302';

#9. All shipment data for Subbarao
select * from people
where `Sales Person` like 'Subb%';
select * from shipments_new
where `Sales Person` = 'SP11';

select p.`Sales Person`,s.`Sales Person`,s.Date, s.Amount,s.Boxes from shipments_new s 
join people p on s.`Sales Person` = p.`SP ID`
where p.`Sales Person` like 'Subba%';

#10. All shipment data for Subbarao by month
select extract(year_month from s.Date) as 'Time', sum(s.Amount) as 'Total Amount',sum(s.Boxes) as 'Total Boxes' from shipments_new s 
join people p on p.`SP ID`= s.`Sales Person` 
where p.`Sales Person` like 'Subba%'
group by extract(year_month from s.Date) ;



#### Hard Queries

#11. What is the maximum amount in each month?
select year(s.Date) as 'Year', month(s.Date) as 'Month' , max(s.Amount) as 'Max Amount' from shipments_new s
group by year(s.Date) , month(s.Date)
order by year,month;

#12. How many shipments were made by each country in March 2023?
select g.Geo as 'Country', count(*) as 'Total Shipments' from shipments_new s
join geo g on g.GeoID = s.Geo
where month(s.Date) = 3 and year(s.Date) = 2023
group by g.Geo;

#13. All shipment data for Subbarao to USA
select p.`Sales Person`, s.Product, s.Date, s.Amount, s.Boxes from shipments_new s 
join geo g join people p on g.GeoID = s.Geo and s.`Sales Person` = p.`sp id`
where g.Geo = 'USA' and p.`Sales Person` like 'Subba%';




