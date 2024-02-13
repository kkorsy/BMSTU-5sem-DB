-- фамилии, имена водителей и пассажиров, которые вчера ездили на фольксвагене 1986 года
select dr.name, dr.surname, pas.name, pas.surname
from Driver dr join Orders ord on dr.id = ord.driver_id
			   join Passenger pas on ord.passenger_id = pas.id
where ord.car_num in (select car.num
					  from Car
					  where brand = 'Volkswagen' and release_year = 2018)
