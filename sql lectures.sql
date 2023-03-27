show tables;
desc sales;
select * from sales;
select SaleDate, Amount, Customers from sales;
select SaleDate, Amount, Boxes, Amount/boxes as 'Amount per box' from sales;
select * from sales where Amount > 10000; 
select * from sales where Amount > 10000 order by Amount desc;
select * from sales where GeoID= 'G1' order by PID, Amount desc;
select * from sales where amount > 10000 and SaleDate >= '2022-01-01';

select SaleDate, Amount from sales
where Amount > 10000 and year(SaleDate) = 2022;

Select * from sales
where boxes > 0 and boxes <= 50;

select * from sales
where boxes between 0 and 50;

#Using the weekday function
select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of week' from sales
where weekday(SaleDate) = 4;

# using another table - people
select * from People;

select * from People
where Team = 'Delish' or Team = 'Jucies';
select * from People
where Team in ('Delish' or'Jucies');

#like operator
select * from people
where Salesperson like 'B%';

select * from people
where Salesperson like '%B%';
# adding labels with condition- case
select SaleDate, Amount,
	case when Amount < 1000 then 'under 1K'
		when Amount < 5000 then 'under 5k'
        when Amount < 10000 then 'under 10k'
	else '10k or more'
end as 'Amount category'
from sales;
    # Join tables
select s.SaleDate, s.Amount, p.Salesperson, s.SPID, p.SPID
from sales s  
join people p on p.SPID = s.SPID;

select s.SaleDate, s.Amount, pr.Product
from sales s  
left join products pr on pr.PID = s.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s  
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID;

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s  
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500
and p.Team = 'Delish';

select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s  
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where s.Amount < 500
and p.Team =''  ; # or is null if null is in table


select s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
from sales s  
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
join geo g on g.GeoID = s.GeoID
where s.Amount < 500
and p.Team =''   # or is null if null is in table
and g.Geo in ('New Zealand', 'India')
order by SaleDate;

#Group by

select g.Geo, sum(Amount), avg(Amount), sum(Amount) from sales s
join geo g on s.GeoID = g.GeoID
group by g.Geo
order by Geo;

Select pr.Category, p.Team, sum(boxes), sum(Amount)
from sales s
join people p on p.SPID = s.SPID
join products pr on pr.PID = s.PID
where p.Team <> ''
group by pr.Category, p.Team
order by pr.Category, p.Team;

select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID = s.PID
group by pr.Product
order by sum(s.Amount) desc;

# Limit operation

select pr.Product, sum(s.Amount) as 'Total Amount'
from sales s
join products pr on pr.PID = s.PID
group by pr.Product
order by sum(s.Amount) desc
limit 10; # to see 10 records