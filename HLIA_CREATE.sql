DROP DATABASE IF EXISTS travel_agency;
CREATE DATABASE travel_agency;
USE travel_agency;


CREATE TABLE branch(
br_code INT(11) NOT NULL AUTO_INCREMENT,
br_street VARCHAR(30),
br_num INT(4),
br_city VARCHAR(30),
PRIMARY KEY (br_code)
);


CREATE TABLE phones(
ph_br_code INT(11) NOT NULL AUTO_INCREMENT,
ph_number CHAR(10) NOT NULL,
PRIMARY KEY (ph_number),
FOREIGN KEY (ph_br_code) REFERENCES branch(br_code)
ON DELETE CASCADE ON UPDATE CASCADE
);





CREATE TABLE worker(
wrk_AT CHAR(10) NOT NULL,
wrk_name VARCHAR(20) DEFAULT 'UNKNOWN',
wrk_lname VARCHAR(20) DEFAULT 'UNKNOWN',
wrk_salary FLOAT(7,2) NOT NULL,
wrk_br_code INT(11) NOT NULL,
PRIMARY KEY (wrk_AT),
FOREIGN KEY (wrk_br_code) REFERENCES branch(br_code)
ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE admin(
adm_AT char(10) NOT NULL,
adm_type ENUM('LOGISTICS','ADMINISTRATIVE','ACCOUNTING') NOT NULL,
adm_diploma VARCHAR(200),
PRIMARY KEY (adm_AT),
FOREIGN KEY (adm_AT) REFERENCES worker(wrk_AT)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE manages(
mng_adm_AT CHAR(10) NOT NULL,
mng_br_code INT(11) NOT NULL,
PRIMARY KEY (mng_adm_AT, mng_br_code),
FOREIGN KEY (mng_adm_AT) REFERENCES admin(adm_AT)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (mng_br_code) REFERENCES branch(br_code)
ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE guide(
gui_AT CHAR(10) NOT NULL,
gui_cv TEXT,
PRIMARY KEY (gui_AT),
FOREIGN KEY (gui_AT) REFERENCES worker(wrk_AT)
ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE languages(
lng_gui_AT CHAR(10) not null,
lng_language VARCHAR(30) NOT NULL,
PRIMARY KEY (lng_gui_AT),
FOREIGN KEY (lng_gui_AT) REFERENCES guide(gui_AT)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE driver(
drv_AT CHAR(10) NOT NULL,
drv_licence ENUM('A','B','C','D') NOT NULL,
drv_route ENUM('LOCAL','ABROAD') NOT NULL,
drv_experience TINYINT(4),
PRIMARY KEY (drv_AT),
FOREIGN KEY (drv_AT) REFERENCES worker(wrk_AT)
ON DELETE CASCADE ON UPDATE CASCADE
);




CREATE TABLE trip(
tr_id INT(11) NOT NULL AUTO_INCREMENT,
tr_departure DATETIME NOT NULL,
tr_return DATETIME NOT NULL,
tr_maxseats TINYINT(4),
tr_cost FLOAT(7,2),
tr_br_code INT(11) NOT NULL,
tr_gui_AT CHAR(10) NOT NULL,
tr_drv_AT CHAR(10) NOT NULL,
PRIMARY KEY (tr_id),
FOREIGN KEY (tr_br_code) REFERENCES branch(br_code)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (tr_gui_AT) REFERENCES guide(gui_AT)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (tr_drv_AT) REFERENCES driver(drv_AT)
ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE event(
ev_tr_id INT(11) NOT NULL,
ev_start DATETIME NOT NULL,
ev_end DATETIME,
ev_descr TEXT,
PRIMARY KEY (ev_tr_id,ev_start),
FOREIGN KEY (ev_tr_id) REFERENCES trip(tr_id)
ON DELETE CASCADE ON UPDATE CASCADE
);





CREATE TABLE reservation(
res_tr_id INT(11) NOT NULL,
res_seatnum TINYINT(4) NOT NULL,
res_name VARCHAR(20),
res_lname VARCHAR(20) NOT NULL,
res_isadult ENUM('ADULT','MINOR'),
PRIMARY KEY (res_tr_id,res_seatnum),
FOREIGN KEY (res_tr_id) REFERENCES trip(tr_id)
ON DELETE CASCADE ON UPDATE CASCADE
);




CREATE TABLE destination(
dst_id INT(11) NOT NULL,
dst_name VARCHAR(50) NOT NULL,
dst_descr TEXT,
dst_rtype ENUM('LOCAL','ABROAD'),
dst_language VARCHAR(30) DEFAULT 'UNKNOWN',
dst_location INT(11) NOT NULL,
PRIMARY KEY (dst_id),
FOREIGN KEY (dst_location) REFERENCES destination(dst_id)
ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE travel_to(
to_tr_id INT(11) NOT NULL,
to_dst_id INT(11) NOT NULL,
to_arrival DATETIME,
to_departure DATETIME,
PRIMARY KEY (to_tr_id,to_dst_id),
FOREIGN KEY (to_tr_id) REFERENCES trip(tr_id)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (to_dst_id) REFERENCES destination(dst_id)
ON DELETE CASCADE ON UPDATE CASCADE
);

USE travel_agency;


INSERT INTO branch VALUES
(1, 'Roseberry Rd', 1, 'London'),
(NULL, 'Craven St', 3, 'London'),
(NULL, 'Canal Reach', 4, 'London'),
(NULL, 'Woodstock Road', 7, 'London'),
(NULL, 'Hillfield Ave', 9, 'London'),
(NULL, 'Middle St', 2, 'Galway'),
(NULL, 'Oaklands', 5,'Galway'),
(NULL, 'Old Abbey St', 6, 'Dublin'),
(NULL, 'Fleming Rd', 10, 'Dublin'),
(NULL, 'Willsbrook Rd', 11, 'Dublin'),
(NULL, 'Charleston Rd', 15, 'Dublin'),
(NULL, 'Park St', 12, 'Leeds'),
(NULL, 'St Marks Rd', 13, 'Leeds'),
(NULL, 'Brooklands Ave', 8, 'Leeds'),
(NULL, 'Greenhills Rd', 14, 'Dublin');




INSERT INTO phones VALUES
(1, '0205673984'),
(2, '0204561378'),
(3, '0203157896'),
(4, '0201345260'),
(5, '0203012004'),
(6, '0910998645'),
(7, '0912406589'),
(8, '3535420304'),
(9, '3533256010'),
(10, '3533352015'),
(11, '3530331456'),
(12, '0113045620'),
(13, '0113012503'),
(14, '0113022158'),
(15, '3536648201');





INSERT INTO worker VALUES
('0258963145', 'James', 'Smith', 40000.00, 5),
('4561897358', 'Lilly', 'James', 40000.00, 2),
('1024567823', 'Colin', 'Farel', 40000.00, 8),
('2486751320', 'Margaret', 'Smith', 30000.00, 3),
('6485731250', 'Karen', 'Galin', 30000.00, 9),
('5784961325', 'Jacob', 'Turner', 30000.00, 1),
('4124102563', 'Rory', 'Swans', 30000.00, 4),
('2015201536', 'William', 'Coalman', 30000.00, 6),
('1020145368', 'Olivia', 'Carpender', 30000.00, 7),
('3245601852', 'Mathew', 'Saleson', 25000.00, 9),
('5478998667', 'Jennifer', 'Thomson', 25000.00, 10),
('4415203654', 'Hugh', 'Grand', 25000.00, 11),
('1110205348', 'Phil', 'Collins',25000.00, 12),
('5478548947', 'Sophia', 'Walters', 25000.00, 13),
('6648912573', 'Phoebe', 'Bridge', 30000.00,14),
('2548961350', 'Walter', 'Turner', 30000.00,15);




INSERT INTO admin VALUES
('0258963145', 'LOGISTICS', 'LOGISTICS'),
('4561897358', 'ADMINISTRATIVE', 'Businessabministrasion'),
('1024567823', 'ACCOUNTING', 'ACCOUNTING');




INSERT INTO manages VALUES
('0258963145', 5),
('4561897358', 2),
('1024567823', 8);



INSERT INTO guide VALUES
('2486751320', NULL),
('6485731250', NULL),
('5784961325', NULL),
('4124102563', NULL),
('2015201536', NULL),
('1020145368', NULL),
('6648912573', NULL),
('2548961350', NULL);




INSERT INTO languages VALUES
('2486751320', 'english,german'),
('6485731250', 'english,french'),
('5784961325', 'english,mandarin'),
('4124102563', 'english,italian'),
('2015201536', 'english,spanish'),
('1020145368', 'english,japanese'),
('6648912573', 'english,hindi'),
('2548961350', 'english');



INSERT INTO driver VALUES
('3245601852', 'A', 'LOCAL', 3),
('5478998667', 'B', 'ABROAD', 5),
('4415203654', 'A', 'LOCAL', 10),
('1110205348', 'C', 'ABROAD', 15),
('5478548947', 'D', 'LOCAL', 5);



INSERT INTO trip VALUES
(100, '2022-12-11', '2022-12-19', 2, 01000.00, 2, '2486751320', '3245601852'),
(NULL, '2022-12-20', '2023-1-5', 4, 01500.00, 8, '6485731250', '5478998667'),
(NULL, '2023-1-3', '2023-1-6', 2, 00200.00, 9, '5784961325', '4415203654'),
(NULL, '2023-2-3', '2023-2-8', 1, 00500.00, 1, '4124102563', '1110205348'),
(NULL, '2023-5-10', '2023-5-30', 3, 02000.00, 12, '2015201536', '5478548947'),
(NULL, '2023-6-15', '2023-6-20', 1, 00600.00, 15, '1020145368', '3245601852'),
(NULL, '2023-3-10', '2023-3-16', 5, 02500.00, 5, '6648912573', '5478998667'),
(NULL, '2022-12-14', '2023-1-5', 2, 03000.00, 11, '2548961350', '5478548947'),
(NULL, '2022-12-20', '2023-1-5', 3, 01500.00, 15, '6485731250', '5478998667'),
(NULL, '2023-7-2', '2023-7-18', 1, 01500.00, 13, '2015201536', '5478998667'),
(NULL, '2022-12-23', '2023-1-6', 2, 01500.00, 6, '6648912573', '3245601852'),
(NULL, '2022-12-22', '2023-1-6', 2, 01600.00, 8, '2486751320', '4415203654'),
(NULL, '2022-12-22', '2023-1-6', 2, 01600.00, 8, '2486751320', '4415203654'),
(NULL, '2022-12-19', '2023-1-4', 2, 01600.00, 8, '5784961325', '1110205348'),
(NULL, '2022-1-6', '2023-1-15', 2, 00600.00, 11, '2548961350', '1110205348');



INSERT INTO event VALUES
(100, '2022-12-12 12:00', '2022-12-12 17:00', 'sleigh riding'),
(109, '2023-7-2 08:00', NULL, 'serfing lesons'),
(101, '2022-12-25', NULL, 'reindeer petting'),
(101, '2022-12-12 12:00', '2022-12-12 17:00', 'sleigh riding'),
(107,'2022-12-25', NULL, 'reindeer petting'),
(108,'2022-12-25', NULL, 'reindeer petting'),
(110,'2022-12-25', NULL, 'reindeer petting'),
(111, '2022-12-25', NULL, 'reindeer petting'),
(112,'2022-12-25', NULL, 'reindeer petting'),
(105, '2023-5-11', NULL, 'serfing with high tide'),
(104, '2023-5-11', NULL, 'serfing with high tide');




INSERT INTO reservation VALUES
(100, 1, 'Phil', 'Jacobs', 'ADULT'),
(101, 4, 'Philomina', 'Cunk', 'ADULT'),
(102, 2, 'Robert', 'Stulls', 'ADULT'),
(103, 9, 'Barkley', 'Turner', 'MINOR'),
(104, 13, 'Olivia', 'Bridges', 'ADULT'),
(105, 16, 'Will', 'Dower', 'ADULT'),
(106, 15, 'Kate', 'Middletin', 'ADULT'),
(107, 20, 'Elijah', 'Wright', 'ADULT'),
(108, 30, 'Stuart', 'Little', 'ADULT'),
(109, 11, 'Jack', 'Marrowbone', 'MINOR'),
(110, 3, 'Mike', 'Stuarts', 'ADULT'),
(111, 27, 'Rachel', 'Adams', 'ADULT'),
(112, 25, 'Jess', 'Walters', 'ADULT'),
(113, 19, 'Ron', 'Waters', 'ADULT'),
(114, 40, 'Harry', 'Horseman', 'ADULT');



INSERT INTO destination VALUES
(1, 'Finland', 'Santas Village, Northern lights in winter', 'ABROAD', 'Finnish', 1),
(2, 'Switzerland', 'Winter Destination for cheese lovers', 'ABROAD', 'Swiss', 2),
(3, 'Spain', 'Summer surfing destination', 'ABROAD', 'Spanish', 3),
(4, 'England', 'Capital of the UK', 'LOCAL', 'ENGLISH', 4),
(5, 'Ireland', 'Capital of Ireland', 'ABROAD', 'ENGLISH', 5);





INSERT INTO travel_to VALUES
(100, 1, NULL, NULL),
(101, 1, NULL, NULL),
(102, 4, NULL, NULL),
(103, 5, NULL, NULL),
(104, 3, NULL, NULL),
(105, 3, NULL,NULL),
(106, 2, NULL, NULL),
(107, 1, NULL, NULL),
(108, 1, NULL, NULL),
(109, 3, NULL, NULL),
(110, 1, NULL, NULL),
(111, 1, NULL, NULL),
(112, 1, NULL, NULL),
(113, 4, NULL, NULL),
(114, 5, NULL, NULL);

select * from telephone;

