

-- flight meal
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (1,5,'L',700);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (2,5,'L',701);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (3,5,'L',702);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (4,5,'D',703);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (5,5,'D',704);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (6,5,'D',705);

INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (7,6,'B',706);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (8,6,'B',707);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (9,6,'L',708);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (10,6,'L',709);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (11,6,'L',710);


INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (37,1,'L',716);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (24,1,'L',717);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (25,1,'L',718);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (26,1,'L',719);

INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (27,2,'B',720);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (28,2,'B',721);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (38,2,'B',722);

INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (29,3,'D',723);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (30,3,'D',724);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (31,3,'D',725);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (32,3,'D',726);

INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (33,4,'D',723);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (34,4,'D',724);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (35,4,'D',725);
INSERT INTO flight_meal (id,flight_id, meal_type, meal_id) VALUES (36,4,'D',726);


INSERT INTO FLIGHTINFO(id,flight_number,origin_location,destination_location,departure_time,arrival_time,carrier,aircraft_type)
values
(1,'183','YUL','YVR',to_timestamp('10-20-2014 13:25', 'mm-dd-yyyy hh24:mi'),to_timestamp('10-20-2014 16:01', 'mm-dd-yyyy hh24:mi'),'Air Canada','32E1');

INSERT INTO FLIGHTINFO(id,flight_number,origin_location,destination_location,departure_time,arrival_time,carrier,aircraft_type)
values
(2,'111','YUL','YVR',to_timestamp('10-20-2014 7:55', 'mm-dd-yyyy hh24:mi'),to_timestamp('10-20-2014 10:31', 'mm-dd-yyyy hh24:mi'),'Air Canada','32P1');

INSERT INTO FLIGHTINFO(id,flight_number,origin_location,destination_location,departure_time,arrival_time,carrier,aircraft_type)
values
(3,'1133','YUL','YVR',to_timestamp('10-20-2014 16:00', 'mm-dd-yyyy hh24:mi'),to_timestamp('10-20-2014 18:36', 'mm-dd-yyyy hh24:mi'),'Air Canada','32E1');

INSERT INTO FLIGHTINFO(id,flight_number,origin_location,destination_location,departure_time,arrival_time,carrier,aircraft_type)
values
(4,'195','YUL','YVR',to_timestamp('10-20-2014 18:25', 'mm-dd-yyyy hh24:mi'),to_timestamp('10-20-2014 20:50', 'mm-dd-yyyy hh24:mi'),'Air Canada','32E1');

INSERT INTO FLIGHTINFO(id,flight_number,origin_location,destination_location,departure_time,arrival_time,carrier,aircraft_type)
values
(5,'A123','YUL','YVR',to_timestamp('10-20-2014 13:25', 'mm-dd-yyyy hh24:mi'),to_timestamp('10-20-2014 16:01', 'mm-dd-yyyy hh24:mi'),'Air Canada','32E1');

insert into blc_address (address_id,address_line1,address_line2,city,state_prov_region,country,postal_code,is_active,is_business,is_default)
values(0,'','','','IL','US','',true,false,true);


