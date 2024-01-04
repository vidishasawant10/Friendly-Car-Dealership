DROP TABLE sale_custom_item;
DROP TABLE survey;
DROP TABLE sale;
DROP TABLE newcar_options;
DROP TABLE usedcar_feature;
DROP TABLE customization_menu;
DROP TABLE financing;
DROP TABLE customer;
DROP TABLE salesperson;
DROP TABLE newcar;
DROP TABLE options_menu;
DROP TABLE usedcar;
DROP TABLE insurance;
DROP TABLE registration;
DROP TABLE warrantee;
DROP TABLE ad;

CREATE TABLE zips (
  zip int NOT NULL AUTO_INCREMENT,
  city varchar(45),
  state char(2),
  CONSTRAINT zip_pk PRIMARY KEY (zip));

CREATE TABLE ad (
  adNumber int NOT NULL AUTO_INCREMENT,
  placedIn varchar(45) NOT NULL,
  initialDate date NOT NULL,
  totalCost decimal(10,2),
  frequency varchar(30),
  contactPerson varchar(45),
  phoneArea int,
  phoneNumber int,
  CONSTRAINT ad_pk PRIMARY KEY (adNumber));

CREATE TABLE customer (
  custId int NOT NULL AUTO_INCREMENT,
  firstName varchar(45) NOT NULL,
  lastName varchar(45) NOT NULL,
  street varchar(45), 
  zip int,
  phoneArea int,
  phoneNumber int,
  driveLicenseNum varchar(11),
  referredBy varchar(45),
  adSeen int NOT NULL,
  CONSTRAINT custId_pk PRIMARY KEY (custId),
  CONSTRAINT zip_fk FOREIGN KEY (zip) REFERENCES zips(zip),
  CONSTRAINT ad_fk FOREIGN KEY (adSeen) REFERENCES ad(adNumber));
  
CREATE TABLE salesperson (
  salespersonId int NOT NULL AUTO_INCREMENT,
  firstName varchar(45) NOT NULL,
  lastName varchar(45) NOT NULL,
  street varchar(45),
  zip int,
  homePhoneArea int,
  homePhoneNumber int,
  officePhoneArea int,
  officePhoneNumber int,
  cellPhoneArea int,
  cellPhoneNumber int,
  dateHired date,
  CONSTRAINT salespersonId_pk PRIMARY KEY (salespersonId), 
  CONSTRAINT zip1_fk FOREIGN KEY (zip) REFERENCES zips(zip));

CREATE TABLE newcar (
  newCarId int NOT NULL AUTO_INCREMENT,
  VIN varchar(30) NOT NULL,
  make varchar(45),
  model varchar(45),
  listPrice decimal(10,2),
  dateOfManufacture date,
  placeOfManufacture varchar(45),
  cylinders int,
  doors int,
  weight int,
  capacity int,
  color varchar(45),
  deliveryDate date,
  deliveryMiles int,
  CONSTRAINT newCarId_pk PRIMARY KEY (newCarId));

CREATE TABLE options_menu (
  carOption int NOT NULL AUTO_INCREMENT,
  price decimal(10,2),
  CONSTRAINT caroption_pk PRIMARY KEY (carOption));

CREATE TABLE newcar_options (
  newCarId int NOT NULL,
  carOption int NOT NULL,
  CONSTRAINT caroption_pk PRIMARY KEY (newCarId, carOption),
  CONSTRAINT newcarId_fk FOREIGN KEY (newCarId) REFERENCES newcar (newCarId),
  CONSTRAINT caroption_fk FOREIGN KEY (carOption) REFERENCES options_menu (carOption));

CREATE TABLE usedcar (
  usedCarId int NOT NULL AUTO_INCREMENT,
  VIN varchar(30) NOT NULL,
  make varchar(45),
  model varchar(45),
  cylinders int,
  doors int,
  weight int,
  capacity int,
  color varchar(45),
  modelYear int,
  mileage int,
  bookValue decimal(10,2),
  CONSTRAINT usedCarId_pk PRIMARY KEY (usedCarId));

CREATE TABLE usedcar_feature (
  usedCarId int NOT NULL,
  feature varchar(30) NOT NULL,
  CONSTRAINT usedcarfeature_pk PRIMARY KEY (usedCarId, feature));

CREATE TABLE insurance (
  insId int NOT NULL AUTO_INCREMENT,
  policy varchar(45) NOT NULL,
  company varchar(45) NOT NULL,
  street varchar(45),
  zip int,
  phoneArea int,
  phoneNumber int,
  issueDate date,
  expirationDate date,
  CONSTRAINT insurance_pk PRIMARY KEY (insId), 
  CONSTRAINT zip2_fk FOREIGN KEY (zip) REFERENCES zips(zip));

CREATE TABLE registration (
  regNumber int NOT NULL AUTO_INCREMENT,
  licensePlate varchar(45),
  licenseFee decimal(10,2),
  CONSTRAINT registration_pk PRIMARY KEY (regNumber));

CREATE TABLE customization_menu (
  customId int NOT NULL AUTO_INCREMENT,
  customItem varchar(45) NOT NULL,
  price decimal(10,2) DEFAULT NULL,
  CONSTRAINT custommenu_pk PRIMARY KEY (customId));

CREATE TABLE warrantee (
  warId int NOT NULL AUTO_INCREMENT,
  warType varchar(45) NOT NULL,
  cost decimal(10,2),
  period varchar(30),
  CONSTRAINT warrantee_pk PRIMARY KEY (warId));

CREATE TABLE financing (
  finId int NOT NULL AUTO_INCREMENT,
  policy varchar(45) NOT NULL,
  company varchar(45) NOT NULL,
  street varchar(45),
  zip int,
  phoneArea int,
  phoneNumber int,
  startDate date,
  amountFinanced decimal(10,2),
  rate varchar(10) DEFAULT '4% p.m',
  numberMonths int,
  CONSTRAINT financing_pk PRIMARY KEY (finId), 
  CONSTRAINT zip3_fk FOREIGN KEY (zip) REFERENCES zips(zip));

CREATE TABLE sale (
  invoiceNumber int NOT NULL AUTO_INCREMENT,
  saleDate date,
  salePrice decimal(10,2),
  tax decimal(10,2),
  tradeInAmount decimal(10,2) DEFAULT '0.00',
  amountPaid decimal(10,2),
  amountDue decimal(10,2),
  saleMiles int,
  customerId int NOT NULL,
  salespersonId int NOT NULL,
  newCarId int DEFAULT NULL,
  usedCarId int DEFAULT NULL,
  insuranceId int NOT NULL,
  financingId int DEFAULT NULL,
  tradeInVIN varchar(30) DEFAULT '0',
  registrationNumber int NOT NULL,
  warranteeId int NOT NULL,
  CONSTRAINT sale_pk PRIMARY KEY (invoiceNumber),
  CONSTRAINT custId_fk FOREIGN KEY (customerId) REFERENCES customer (custId),
  CONSTRAINT salespersonId_fk FOREIGN KEY (salespersonId) REFERENCES salesperson (salespersonId),
  CONSTRAINT newcar_fk FOREIGN KEY (newCarId) REFERENCES newcar (newCarId),
  CONSTRAINT usedcar_fk FOREIGN KEY (usedCarId) REFERENCES usedcar (usedCarId),
  CONSTRAINT insurance_fk FOREIGN KEY (insuranceId) REFERENCES insurance (insId),
  CONSTRAINT financing_fk FOREIGN KEY (financingId) REFERENCES financing (finId),
  CONSTRAINT registrationnumber_fk FOREIGN KEY (registrationNumber) REFERENCES registration (regNumber),
  CONSTRAINT warrantee_fk FOREIGN KEY (warranteeId) REFERENCES warrantee (warId));

CREATE TABLE sale_custom_item (
  invoiceNumber int NOT NULL,
  customId int NOT NULL,
  CONSTRAINT salecustom_pk PRIMARY KEY (invoiceNumber,customId),
  CONSTRAINT invoicenumber_fk FOREIGN KEY (invoiceNumber) REFERENCES sale (invoiceNumber),
  CONSTRAINT customitem_fk FOREIGN KEY (customId) REFERENCES customization_menu (customId));

CREATE TABLE survey (
  surveyNumber int NOT NULL AUTO_INCREMENT,
  dealershipRating int,
  salespersonRating int,
  carRating int,
  invoiceNumber int NOT NULL,
  CONSTRAINT survey_pk PRIMARY KEY (surveyNumber),
  CONSTRAINT invoice_fk FOREIGN KEY (invoiceNumber) REFERENCES sale (invoiceNumber));

CREATE INDEX newCarId_idx ON newcar_options (newCarId);
CREATE INDEX caroption_idx ON newcar_options (carOption);
CREATE INDEX custId_idx ON sale (customerId);
CREATE INDEX salespersonId_idx ON sale (salespersonId);
CREATE INDEX newcar_idx ON sale (newCarId);
CREATE INDEX usedcar_idx ON sale (usedCarId);
CREATE INDEX insId_idx ON sale (insuranceId);
CREATE INDEX finId_idx ON sale (financingId);
CREATE INDEX registnumber_idx ON sale (registrationNumber);
CREATE INDEX warrantee_idx ON sale (warranteeId);
CREATE INDEX customId_idx ON sale_custom_item (customId);
CREATE INDEX invoicenumber_idx ON sale_custom_item (invoiceNumber);
CREATE INDEX invoicenum_idx ON survey (invoiceNumber);
CREATE INDEX adSeen_idx ON customer (adSeen);
CREATE UNIQUE INDEX salespersonname_idx ON salesperson (firstName, lastName);
CREATE UNIQUE INDEX customerdrivelicense_idx ON customer (driveLicenseNum);
CREATE UNIQUE INDEX newcarvin_idx ON newcar (VIN);
CREATE UNIQUE INDEX usedcarvin_idx ON usedcar (VIN);
CREATE UNIQUE INDEX inspolicycomp_idx ON insurance (policy, company);
CREATE UNIQUE INDEX finpolicycomp_idx ON financing (policy, company);
CREATE UNIQUE INDEX custommenu_idx ON customization_menu (customItem);
CREATE UNIQUE INDEX warrantee_idx ON warrantee (warType);
CREATE UNIQUE INDEX ad_idx ON ad (placedIn, initialDate);

INSERT INTO zips (zip, city, state) 
VALUES 
(13905,'Lynn','MA'),
(13217,'Syracuse','NY'),
(14624,'Rochester','NY'),
(10155,'New York City','NY'),
(17405,'York','PA');

INSERT INTO ad (adNumber, placedIn, initialDate, totalCost, frequency, contactPerson, phoneArea, PhoneNumber) 
VALUES 
(DEFAULT,'Internet','2019-02-09',143.00,'3','Sheff Nern',462,4183703),
(DEFAULT,'Magazine','2019-10-12',196.00,'3','Rodney Luke',950,5379358),
(DEFAULT,'Newspaper','2019-03-18',275.00,'2','Gunther Sole',914,6011763),
(DEFAULT,'Radio','2019-02-15',264.00,'5','Anselma Connolly',224,4736611),
(DEFAULT,'TV','2019-06-21',208.00,'1','Dannel Matyushonok',495,6948514);

INSERT INTO customer (custId, firstName, lastName, street, zip, phoneArea, phoneNumber, driveLicenseNum, referredBy, adSeen) 
VALUES 
(DEFAULT,'Ari','Feavearyear','29468 Trailsway Hill',13905,565,1519997,'592-10-6337','Greg Tomas',5),
(DEFAULT,'Merrick','Ogger','1 Pond Alley',13217,684,4276587,'798-62-0623','Bill Miler',4),
(DEFAULT,'Pauletta','Stallwood','774 Larry Circle',14624,729,8809712,'686-23-0548','Carol Han',4),
(DEFAULT,'Marge','Bonhill','33041 Chinook Point',10155,983,2858761,'722-04-0644','Chun Kai',2),
(DEFAULT,'Rachael','Nourse','59254 Sage Center',17405,834,2586399,'886-52-1866','Garret Cart',2);

INSERT INTO customization_menu (customId, customItem, price) 
VALUES 
(DEFAULT,'gps system',156.00),
(DEFAULT,'alarm system',243.00),
(DEFAULT,'sun roof',465.00),
(DEFAULT,'leather seats',122.00),
(DEFAULT,'new color',321.00);

INSERT INTO financing (finId, policy, company, street, zip, phoneArea, phoneNumber, startDate, amountFinanced, rate, numberMonths) 
VALUES 
(DEFAULT,'FIN001','Citibank','655 Straubel Way',14624,914,4028607,'2019-01-05',15000.00,NULL,36),
(DEFAULT,'FIN002','HSBC','77119 Prairieview Way',14624,203,7563868,'2019-11-11',12000.00,NULL,36),
(DEFAULT,'FIN003','US Bank','9 Springview Drive',13217,974,9438954,'2019-07-10',10000.00,NULL,24),
(DEFAULT,'FIN004','Citibank','12 Summer Ridge Terrace', 17405,172,8915964,'2018-10-30',15000.00,NULL,48),
(DEFAULT,'FIN005','HSBC','261 Bobwhite Park',10155,914,1240079,'2019-06-15',13000.00,NULL,36);

INSERT INTO insurance (insId, policy, company, street, zip, phoneArea, phoneNumber, issueDate, expirationDate) 
VALUES 
(DEFAULT,'INS001','Geico','2243 Central Park Ave', 14624,203,2077847,'2019-01-04','2019-07-04'),
(DEFAULT,'INS002','Liberty','2243 Main Ave', 14624,203,2077847,'2019-10-09','2020-04-09'),
(DEFAULT,'INS003','Geico','2243 Central Park Ave',10155,914,2077847,'2019-08-24','2020-02-24'),
(DEFAULT,'INS004','Geico','2243 Central Park Ave',10155,914,2077847,'2019-08-27','2020-02-27'),
(DEFAULT,'INS005','Liberty','2651 Strang Blvd Floor One',17405,172,7850180,'2019-11-20','2020-05-20');

INSERT INTO newcar (newCarId, VIN, make, model, listPrice, dateOfManufacture, placeOfManufacture, cylinders, doors, weight, capacity, color, deliveryDate, deliveryMiles) 
VALUES 
(DEFAULT,'1C3CCBCG8DN043829','Land Rover','Discovery',47337.00,'2019-05-22','New York',6,5,3693,5,'Black','2019-06-01',102),
(DEFAULT,'1D7RB1CT7BS881175','Volkswagen','Golf',17264.00,'2019-08-10','New York',4,5,5868,5,'White','2019-12-02',129),
(DEFAULT,'1G4HH5E90AU691486','Volkswagen','Passat',22209.00,'2019-07-18','New York',4,5,3800,5,'Blue','2019-08-02',51),
(DEFAULT,'3C63D3HL7CG670654','Subaru','Crosstrek',20461.00,'2019-09-13','New York',4,5,4888,5,'Blue','2019-11-10',567),
(DEFAULT,'3VW517AT1EM034793','Ford','Edge',31292.00,'2019-08-05','New Jersey',6,5,4413,5,'Blue','2019-09-15',648);

INSERT INTO options_menu (carOption, price) 
VALUES 
(DEFAULT,1643.00),
(DEFAULT,945.00),
(DEFAULT,695.00),
(DEFAULT,539.00),
(DEFAULT,224.00);

INSERT INTO newcar_options (newCarId, carOption) 
VALUES 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

INSERT INTO registration (regNumber, licensePlate, licenseFee) 
VALUES 
(DEFAULT,'Y31FAC',102.00),
(DEFAULT,'N16FKN',81.00),
(DEFAULT,'F44FAE',81.00),
(DEFAULT,'H98FHO',110.00),
(DEFAULT,'K99FHB',85.00);

INSERT INTO usedcar (usedCarId, VIN, make, model, cylinders, doors, weight, capacity, color, modelYear, mileage, bookValue) 
VALUES 
(DEFAULT,'2HNYD28257H276330','Subaru','Impreza',4,5,4320,5,'Black',2015,9923,15000.00),
(DEFAULT,'3N1CN7AP4FL777122','Honda','CRV',4,5,3790,5,'Blue',2016,10612,17000.00),
(DEFAULT,'WA1C8AFP8DA597506','BMW','328i',4,5,4123,5,'Black',2017,13199,26000.00),
(DEFAULT,'WAUCVAFRXCA314714','Nissan','Rogue',4,5,4090,5,'Black',2018,21308,16000.00),
(DEFAULT,'WBAKG1C57BE375422','Volkswagen','Golf',4,5,3902,5,'Gray',2015,9407,13000.00),
(DEFAULT,'WDDHF2EB6DA278138','Subaru','Crosstrek',4,5,4145,5,'White',2016,3374,17000.00);

INSERT INTO usedcar_feature (usedCarId, feature) 
VALUES 
(1,'sunroof'),
(2,'gpsSystem'),
(3,'sunroof+gpsSystem'),
(4,'gpsSystem'),
(5,'sunroof');

INSERT INTO warrantee (warId, warType, cost, period) 
VALUES 
(DEFAULT,'Accessories Warranty',600.00,'2 years'),
(DEFAULT,'New Car Warranty',1000.00,'2 years'),
(DEFAULT,'New Car Warranty Extension',1700.00,'4 years'),
(DEFAULT,'Powertrain Warranty',1300.00,'2 years'),
(DEFAULT,'Used Car Warrantee',500.00,'90 days');

INSERT INTO salesperson (salespersonId, firstName, lastName, street, zip, homePhoneArea, homePhoneNumber, officePhoneArea, officePhoneNumber, cellPhoneArea, cellPhoneNumber, dateHired) 
VALUES 
(DEFAULT,'Pat','Cawtheray','5 Pankratz Park',14624,786,3542296,422,7436544,786,9632453,'2019-02-23'),
(DEFAULT,'Ari','Rembrant','3 Texas Plaza',10155,122,4076779,422,7436554,122,6435647,'2019-01-26'),
(DEFAULT,'Timotheus','Yeowell','03634 Talmadge Lane',10155,522,5740369,422,7436564,522,8646321,'2018-08-13'),
(DEFAULT,'Rosalyn','Kuhnhardt','62084 Dexter Point',10155,282,9200832,422,7436574,282,9654771,'2018-03-20'),
(DEFAULT,'Lyman','Bottomer','054 Amoth Avenue',14624,936,3733865,422,7436584,936,7129836,'2018-06-23');

INSERT INTO sale (invoiceNumber, saleDate, salePrice, tax, tradeInAmount, amountPaid, amountDue, saleMiles, customerId, salespersonId, newCarId, usedCarId, insuranceId, financingId, tradeInVIN, registrationNumber, warranteeId) 
VALUES 
(DEFAULT,'2019-07-28',47337.00,4733.00,0.00,47337.00,0.00,135,1,2,1,NULL,1,NULL,NULL,1,1),
(DEFAULT,'2019-08-24',17264.00,1726.00,0.00,17264.00,0.00,123,2,4,2,NULL,2,NULL,NULL,2,2),
(DEFAULT,'2019-12-14',20461.00,2046.00,0.00,20461.00,0.00,123,3,4,4,NULL,3,NULL,'WBAKG1C57BE375422',3,1),
(DEFAULT,'2019-04-21',31292.00,3129.00,0.00,21292.00,10000.00,123,4,3,5,NULL,4,3,NULL,4,2),
(DEFAULT,'2019-04-29',26000.00,2600.00,0.00,11000.00,15000.00,123,5,5,NULL,3,5,1,NULL,5,3);

INSERT INTO sale_custom_item (invoiceNumber, customId) 
VALUES 
(1,5),
(2,1),
(3,1),
(4,3),
(5,2);

INSERT INTO survey (surveyNumber, dealershipRating, salespersonRating, carRating, invoiceNumber) 
VALUES 
(DEFAULT,2,2,3,1),
(DEFAULT,2,3,3,2),
(DEFAULT,2,3,2,3),
(DEFAULT,1,2,2,4),
(DEFAULT,3,3,2,5);

SELECT
	make,
    model,
    listPrice
FROM newcar
WHERE listPrice=(select max(listPrice) from newcar);

SELECT
	c.firstName,
    c.lastName,
    c.street,
    z.city,
    z.state,
    z.zip
FROM customer c
JOIN zips z
	ON c.zip = z.zip
WHERE state='NY';

SELECT 
	invoiceNumber,
    saleDate,
    salePrice,
    newCarId,
    usedcarId
FROM sale
WHERE saleDate BETWEEN '2019-04-01' AND '2019-12-31';

SELECT
	make,
	model,
	modelYear,
    color,
    bookValue
FROM usedcar
WHERE make = 'Subaru';

SELECT
	DISTINCT company
FROM insurance;

CREATE TRIGGER formatting_values
BEFORE INSERT ON customer
FOR EACH ROW
SET 
NEW.firstName = CONCAT(UPPER(LEFT(new.firstName, 1)), SUBSTRING(new.firstName, 2)),
NEW.lastName = CONCAT(UPPER(LEFT(new.lastName, 1)), SUBSTRING(new.lastName, 2));

INSERT INTO customer (custId, firstName, lastName, street, zip, phoneArea, phoneNumber, driveLicenseNum, referredBy, adSeen) 
VALUES
(6, 'john', 'smith', '750 Rock Street', 14624, 203, 2876337, '896-22-1112', null, 4);

INSERT INTO customer (custId, firstName, lastName, street, zip, phoneArea, phoneNumber, driveLicenseNum, referredBy, adSeen) 
VALUES
(6, 'john', 'smith', '750 Rock Street', 14624, 203, 2876337, '896-22-1112', null, 4);

