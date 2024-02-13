-- 01 --
select distinct dr.name, dr.rating, pas.name, pas.rating
from Driver dr
    join Orders ord on dr.id = ord.driver_id
    join Passenger pas on pas.id = ord.passenger_id
where dr.rating > pas.rating;
