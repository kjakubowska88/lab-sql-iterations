/** In this lab, we will continue working on the Sakila database of movie rentals.
Instructions
Write queries to answer the following questions:
 **/

-- 1 Write a query to find what is the total business done by each store.
select s.store_id ss Store_id, sum(p.amount) as Business
from payment as  p
join staff as st on p.staff_id = st.staff_id
join store as s on st.store_id = s.store_id
group by store_id;


-- 2 Convert the previous query into a stored procedure.
drop procedure if exists total_business;
delimiter //
create procedure total_business ()
begin    
SELECT s.store_id, sum(p.amount) 
from payment as  p
join staff as st on p.staff_id = st.staff_id
join store as s on st.store_id = s.store_id
group by store_id;
end
//
delimiter ;

call total_business();

-- 3 Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

drop procedure if exists total_business2;
delimiter //
create procedure total_business2 (in param1 int)
begin    
SELECT s.store_id, sum(p.amount) 
from payment as  p
join staff as st on p.staff_id = st.staff_id
join store as s on st.store_id = s.store_id
where s.store_id=param1 
group by store_id;
end
//
delimiter ;

call total_business2(2);

-- 4 Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). 
 -- Call the stored procedure and print the results.

drop procedure if exists total_business3;


delimiter //
create procedure total_business3 (in param1 int)

begin 
declare total_sales_value float default 0.0;   

SELECT sum(p.amount) into total_sales_value
from payment as  p
join staff as st on p.staff_id = st.staff_id
join store as s on st.store_id = s.store_id
where s.store_id= param1 
group by s.store_id;
select total_sales_value;
set total_sales_value = 0.0;
end;
//
delimiter ;

call total_business3(2);

-- 5 In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. 
 -- Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.
 
drop procedure if exists total_business4;

delimiter //
create procedure total_business4 (in param1 int)

begin 
declare total_sales_value float default 0.0;   

SELECT sum(p.amount) into total_sales_value
from payment as  p
join staff as st on p.staff_id = st.staff_id
join store as s on st.store_id = s.store_id
where s.store_id= param1 
group by s.store_id;

select total_sales_value, 
case 
when total_sales_value > 30000 then 'green_flag'
else 'red_flag' END 
as flag;

end;
//
delimiter ;

call total_business4(2);