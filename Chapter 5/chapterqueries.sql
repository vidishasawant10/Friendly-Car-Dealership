CREATE TABLE customer (
  custId varchar(30) NOT NULL,
  firstName varchar(45) NOT NULL,
  lastName varchar(45) NOT NULL,
  street varchar(45),
  city varchar(45),
  state char(2),
  zip int,
  phoneArea int,
  phoneNumber int,
  driveLicenseNum varchar(11),
  referredBy varchar(45),
  adSeen varchar(45),
  CONSTRAINT custId_pk PRIMARY KEY (custId));
  
CREATE TABLE salesperson (
  salespersonId varchar(30) NOT NULL,
  firstName varchar(45) NOT NULL,
  lastName varchar(45) NOT NULL,
  street varchar(45),
  city varchar(45),
  state char(2),
  zip int,
  homePhoneArea int,
  homePhoneNumber int,
  officePhoneArea int,
  officePhoneNumber int,
  cellPhoneArea int,
  cellPhoneNumber int,
  dateHired date,
  CONSTRAINT salespersonId_pk PRIMARY KEY (salespersonId));

CREATE TABLE newcar (
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
  CONSTRAINT vinnew_pk PRIMARY KEY (VIN));

CREATE TABLE options_menu (
  carOption int NOT NULL,
  price decimal(10,2),
  CONSTRAINT caroption_pk PRIMARY KEY (carOption));

CREATE TABLE newcar_options (
  VIN varchar(30) NOT NULL,
  carOption int NOT NULL,
  CONSTRAINT caroption_pk PRIMARY KEY (VIN, carOption),
  CONSTRAINT vinnew_fk FOREIGN KEY (VIN) REFERENCES newcar (VIN),
  CONSTRAINT caroption_fk FOREIGN KEY (carOption) REFERENCES options_menu (carOption));

CREATE TABLE usedcar (
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
  CONSTRAINT vinused_pk PRIMARY KEY (VIN));

CREATE TABLE usedcar_feature (
  VIN varchar(30) NOT NULL,
  feature varchar(30) NOT NULL,
  CONSTRAINT usedcarfeature_pk PRIMARY KEY (VIN, feature));

CREATE TABLE insurance (
  policy varchar(45) NOT NULL,
  company varchar(45) NOT NULL,
  street varchar(45),
  city varchar(45),
  state char(2),
  zip int,
  phoneArea int,
  phoneNumber int,
  issueDate date,
  expirationDate date,
  CONSTRAINT insurance_pk PRIMARY KEY (policy, company));

CREATE TABLE registration (
  regNumber varchar(10) NOT NULL,
  licensePlate varchar(45),
  licenseFee decimal(10,2),
  CONSTRAINT registration_pk PRIMARY KEY (regNumber));

CREATE TABLE customization_menu (
  customItem int NOT NULL,
  price decimal(10,2) DEFAULT NULL,
  CONSTRAINT custommenu_pk PRIMARY KEY (customItem));

CREATE TABLE warrantee (
  warType varchar(45) NOT NULL,
  cost decimal(10,2),
  period varchar(30),
  CONSTRAINT warrantee_pk PRIMARY KEY (warType));

CREATE TABLE financing (
  policy varchar(45) NOT NULL,
  company varchar(45) NOT NULL,
  street varchar(45),
  city varchar(45),
  state char(2),
  zip int,
  phoneArea int,
  phoneNumber int,
  startDate date,
  amountFinanced decimal(10,2),
  rate varchar(10) DEFAULT '4% p.m',
  numberMonths int,
  CONSTRAINT financing_pk PRIMARY KEY (policy, company));

CREATE TABLE sale (
  invoiceNumber varchar(30) NOT NULL,
  saleDate date,
  salePrice decimal(10,2),
  tax decimal(10,2),
  registrationFee decimal(10,2),
  tradeInAmount decimal(10,2) DEFAULT '0.00',
  financedAmount decimal(10,2) DEFAULT '0.00',
  amountPaid decimal(10,2),
  amountDue decimal(10,2),
  salesPersonCommission decimal(10,2),
  saleMiles int,
  custId varchar(30) NOT NULL,
  salespersonId varchar(30) NOT NULL,
  newCarVIN varchar(30) DEFAULT NULL,
  usedCarVIN varchar(30) DEFAULT NULL,
  insurancePolicy varchar(45) NOT NULL,
  insuranceCompany varchar(45) NOT NULL,
  financingPolicy varchar(45) DEFAULT NULL,
  financingCompany varchar(45) DEFAULT NULL,
  tradeInVIN varchar(30) DEFAULT '0',
  registrationNumber varchar(10) NOT NULL,
  warranteeType varchar(45) NOT NULL,
  CONSTRAINT sale_pk PRIMARY KEY (invoiceNumber),
  CONSTRAINT custId_fk FOREIGN KEY (custId) REFERENCES customer (custId),
  CONSTRAINT salespersonId_fk FOREIGN KEY (salespersonId) REFERENCES salesperson (salespersonId),
  CONSTRAINT vinnewcar_fk FOREIGN KEY (newCarVIN) REFERENCES newcar (VIN),
  CONSTRAINT vinused_fk FOREIGN KEY (usedCarVIN) REFERENCES usedcar (VIN),
  CONSTRAINT insurancepolicycompany_fk FOREIGN KEY (insurancePolicy, insuranceCompany) REFERENCES insurance (policy, company),
  CONSTRAINT financingpolicycompany_fk FOREIGN KEY (financingPolicy, financingCompany) REFERENCES financing (policy, company),
  CONSTRAINT registrationnumber_fk FOREIGN KEY (registrationNumber) REFERENCES registration (regNumber),
  CONSTRAINT warranteetype_fk FOREIGN KEY (warranteeType) REFERENCES warrantee (warType));

CREATE TABLE sale_custom_item (
  invoiceNumber varchar(30) NOT NULL,
  customItem int NOT NULL,
  CONSTRAINT salecustom_pk PRIMARY KEY (invoiceNumber,customItem),
  CONSTRAINT invoicenumber_fk FOREIGN KEY (invoiceNumber) REFERENCES sale (invoiceNumber),
  CONSTRAINT customitem_fk FOREIGN KEY (customItem) REFERENCES customization_menu (customItem));

CREATE TABLE survey (
  surveyNumber varchar(30) NOT NULL,
  dealershipRating int,
  salespersonRating int,
  carRating int,
  invoiceNumber varchar(30) NOT NULL,
  CONSTRAINT survey_pk PRIMARY KEY (surveyNumber),
  CONSTRAINT invoice_fk FOREIGN KEY (invoiceNumber) REFERENCES sale (invoiceNumber));

CREATE TABLE ad (
  placedIn varchar(45) NOT NULL,
  initialDate date NOT NULL,
  totalCost decimal(10,2),
  frequency varchar(30),
  contactPerson varchar(45),
  phoneArea int,
  phoneNumber int,
  CONSTRAINT ad_pk PRIMARY KEY (placedIn, initialDate));

CREATE INDEX vinnew_idx ON newcar_options (VIN);
CREATE INDEX caroption_idx ON newcar_options (carOption);
CREATE INDEX custId_idx ON sale (custId);
CREATE INDEX salespersonId_idx ON sale (salespersonId);
CREATE INDEX vinnewcar_idx ON sale (newCarVIN);
CREATE INDEX vinusedcar_idx ON sale (usedCarVIN);
CREATE INDEX inspolicycompany_idx ON sale (insurancePolicy, insuranceCompany);
CREATE INDEX finpolicycompany_idx ON sale (financingPolicy, financingCompany);
CREATE INDEX registnumber_idx ON sale (registrationNumber);
CREATE INDEX warrantype_idx ON sale (warranteeType);
CREATE INDEX customitem_idx ON sale_custom_item (customItem);
CREATE INDEX invoicenumber_idx ON sale_custom_item (invoiceNumber);
CREATE INDEX invoicenum_idx ON survey (invoiceNumber);
CREATE UNIQUE INDEX salespersonname_idx ON salesperson (firstName, lastName);
CREATE UNIQUE INDEX customerdrivelicense_idx ON customer (driveLicenseNum);

INSERT INTO `ad` (`placedIn`,`initialDate`,`totalCost`,`frequency`,`contactPerson`,`phoneArea`,`PhoneNumber`) VALUES ('Internet','2019-02-09',143.00,'3','Sheff Nern',462,4183703);
INSERT INTO `ad` (`placedIn`,`initialDate`,`totalCost`,`frequency`,`contactPerson`,`phoneArea`,`PhoneNumber`) VALUES ('Magazine','2019-10-12',196.00,'3','Rodney Luke',950,5379358);
INSERT INTO `ad` (`placedIn`,`initialDate`,`totalCost`,`frequency`,`contactPerson`,`phoneArea`,`PhoneNumber`) VALUES ('Newspaper','2019-03-18',275.00,'2','Gunther Sole',914,6011763);
INSERT INTO `ad` (`placedIn`,`initialDate`,`totalCost`,`frequency`,`contactPerson`,`phoneArea`,`PhoneNumber`) VALUES ('Radio','2019-02-15',264.00,'5','Anselma Connolly',224,4736611);
INSERT INTO `ad` (`placedIn`,`initialDate`,`totalCost`,`frequency`,`contactPerson`,`phoneArea`,`PhoneNumber`) VALUES ('TV','2019-06-21',208.00,'1','Dannel Matyushonok',495,6948514);

INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C001','Ari','Feavearyear','29468 Trailsway Hill','Lynn','MA',13905,565,1519997,'592-10-6337','Greg Tomas','TV');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C002','Merrick','Ogger','1 Pond Alley','Syracuse','NY',13217,684,4276587,'798-62-0623','Bill Miler','Radio');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C003','Pauletta','Stallwood','774 Larry Circle','Rochester','NY',14624,729,8809712,'686-23-0548','Carol Han','Radio');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C004','Marge','Bonhill','33041 Chinook Point','New York City','NY',10155,983,2858761,'722-04-0644','Chun Kai','Magazine');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C005','Rachael','Nourse','59254 Sage Center','York','PA',17405,834,2586399,'886-52-1866','Garret Cart','Magazine');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C006','Jamey','Hazle','1 Hintze Center','Boston','MA',2109,917,3954388,'416-73-4732','Bob Mart','Internet');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C007','Husein','Millar','1566 Buhler Way','New York City','NY',10034,242,7171444,'728-85-3243','Bill Miler','Internet');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C008','Katina','Towl','510 Rigney Center','Rochester','NY',14604,572,1187227,'706-18-8139','Greg Tomas','Internet');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C009','Lesli','Haglinton','85638 Anhalt Drive','Trenton','NJ',8608,213,7327045,'326-87-4100','Merrick Ogger','Newspaper');
INSERT INTO `customer` (`custId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`driveLicenseNum`,`referredBy`,`adSeen`) VALUES ('C010','Cindie','Karran','59 Vera Court','Buffalo','NY',14210,945,6812154,'446-06-5201','Jamey Hazle','TV');

INSERT INTO `customization_menu` (`customItem`,`price`) VALUES (1,156.00);
INSERT INTO `customization_menu` (`customItem`,`price`) VALUES (2,243.00);
INSERT INTO `customization_menu` (`customItem`,`price`) VALUES (3,465.00);
INSERT INTO `customization_menu` (`customItem`,`price`) VALUES (4,122.00);
INSERT INTO `customization_menu` (`customItem`,`price`) VALUES (5,321.00);

INSERT INTO `financing` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`startDate`,`amountFinanced`,`rate`,`numberMonths`) VALUES ('FIN001','Citibank','655 Straubel Way','Bronx','NY',8695,286,4028607,'2019-01-05',15000.00,NULL,36);
INSERT INTO `financing` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`startDate`,`amountFinanced`,`rate`,`numberMonths`) VALUES ('FIN002','HSBC','77119 Prairieview Way','Brooklyn','NY',11220,659,7563868,'2019-11-11',12000.00,NULL,36);
INSERT INTO `financing` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`startDate`,`amountFinanced`,`rate`,`numberMonths`) VALUES ('FIN003','US Bank','9 Springview Drive','Hartford','CT',6152,405,9438954,'2019-07-10',10000.00,NULL,24);
INSERT INTO `financing` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`startDate`,`amountFinanced`,`rate`,`numberMonths`) VALUES ('FIN004','Citibank','12 Summer Ridge Terrace','Pittsburgh','PA',7112,172,8915964,'2018-10-30',15000.00,NULL,48);
INSERT INTO `financing` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`startDate`,`amountFinanced`,`rate`,`numberMonths`) VALUES ('FIN005','HSBC','261 Bobwhite Park','White Plains','NY',14276,303,1240079,'2019-06-15',13000.00,NULL,36);

INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('GEI0001','Geico','2243 Central Park Ave','Yonkers','NY',10710,800,2077847,'2019-01-04','2019-07-04');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('GEI0002','Geico','2243 Central Park Ave','Yonkers','NY',10710,800,2077847,'2019-10-09','2020-04-09');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('GEI0003','Geico','2243 Central Park Ave','Yonkers','NY',10710,800,2077847,'2019-08-24','2020-02-24');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('GEI0004','Geico','2243 Central Park Ave','Yonkers','NY',10710,800,2077847,'2019-08-27','2020-02-27');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('LIB0001','Liberty','2651 Strang Blvd Floor One','Yorktown Heights','NY',10598,914,7850180,'2019-11-20','2020-05-20');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('LIB0002','Liberty','2651 Strang Blvd Floor One','Yorktown Heights','NY',10598,914,7850180,'2019-11-28','2020-05-28');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('LIB0003','Liberty','2651 Strang Blvd Floor One','Yorktown Heights','NY',10598,914,7850180,'2019-06-29','2019-12-29');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('LIB0004','Liberty','2651 Strang Blvd Floor One','Yorktown Heights','NY',10598,914,7850180,'2019-03-23','2019-09-23');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('PRO0001','Progressive','1700 Bedford St','Stamford','CT',6905,203,3487900,'2019-04-30','2019-10-30');
INSERT INTO `insurance` (`policy`,`company`,`street`,`city`,`state`,`zip`,`phoneArea`,`phoneNumber`,`issueDate`,`expirationDate`) VALUES ('PRO0002','Progressive','1700 Bedford St','Stamford','CT',6905,203,3487900,'2019-04-24','2019-10-24');

INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('1C3CCBCG8DN043829','Land Rover','Discovery',47337.00,'2019-05-22','New York',6,5,3693,5,'Black','2019-06-01',102);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('1D7RB1CT7BS881175','Volkswagen','Golf',17264.00,'2019-08-10','New York',4,5,5868,5,'White','2019-12-02',129);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('1G4HH5E90AU691486','Volkswagen','Passat',22209.00,'2019-07-18','New York',4,5,3800,5,'Blue','2019-08-02',51);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('3C63D3HL7CG670654','Subaru','Crosstrek',20461.00,'2019-09-13','New York',4,5,4888,5,'Blue','2019-11-10',567);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('3VW517AT1EM034793','Ford','Edge',31292.00,'2019-08-05','New Jersey',6,5,4413,5,'Blue','2019-09-15',648);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('JM1BL1H40A1208372','Hyundai','Tucson',25693.00,'2019-06-07','New Jersey',4,5,4165,5,'Red','2019-09-04',272);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('KMHHT6KD2AU013402','Nissan','Altima',26564.00,'2019-03-23','New Jersey',4,5,4201,5,'Black','2019-05-05',652);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('SCBLC47JX7C665686','Mitsubishi','Pajero',28233.00,'2019-11-25','New York',4,5,3537,5,'Gray','2019-12-10',752);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('WA1DGAFP4FA448505','Honda','CRV',24134.00,'2019-05-11','Pennsylvania',4,5,4499,5,'Blue','2019-08-09',84);
INSERT INTO `newcar` (`VIN`,`make`,`model`,`listPrice`,`dateOfManufacture`,`placeOfManufacture`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`deliveryDate`,`deliveryMiles`) VALUES ('WAUHF98P98A343836','Chevrolet','Suburban',52021.00,'2019-04-10','New Jersey',8,5,5297,7,'Black','2019-07-10',18);

INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('1C3CCBCG8DN043829',1);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('1D7RB1CT7BS881175',2);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('1G4HH5E90AU691486',3);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('3C63D3HL7CG670654',4);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('3VW517AT1EM034793',5);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('JM1BL1H40A1208372',1);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('KMHHT6KD2AU013402',2);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('SCBLC47JX7C665686',3);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('WA1DGAFP4FA448505',4);
INSERT INTO `newcar_options` (`VIN`,`carOption`) VALUES ('WAUHF98P98A343836',5);

INSERT INTO `options_menu` (`carOption`,`price`) VALUES (1,1643.00);
INSERT INTO `options_menu` (`carOption`,`price`) VALUES (2,945.00);
INSERT INTO `options_menu` (`carOption`,`price`) VALUES (3,695.00);
INSERT INTO `options_menu` (`carOption`,`price`) VALUES (4,539.00);
INSERT INTO `options_menu` (`carOption`,`price`) VALUES (5,224.00);

INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG001','Y31FAC',102.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG002','N16FKN',81.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG003','F44FAE',81.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG004','H98FHO',110.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG005','K99FHB',85.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG006','B58EUT',103.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG007','ANX7402',88.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG008','DNA2167',97.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG009','GUP2065',105.00);
INSERT INTO `registration` (`regNumber`,`licensePlate`,`licenseFee`) VALUES ('REG010','8DM78E3',108.00);

INSERT INTO `sale` (`invoiceNumber`,`saleDate`,`salePrice`,`tax`,`registrationFee`,`tradeInAmount`,`financedAmount`,`amountPaid`,`amountDue`,`salesPersonCommission`,`saleMiles`,`custId`,`salespersonId`,`newCarVIN`,`usedCarVIN`,`insurancePolicy`,`insuranceCompany`,`financingPolicy`,`financingCompany`,`tradeInVIN`,`registrationNumber`,`warranteeType`) VALUES ('IN001','2019-07-28',47337.00,4733.00,300.00,0.00,0.00,47337.00,0.00,473.00,135,'C001','SP003','1C3CCBCG8DN043829',NULL,'GEI0001','Geico',NULL,NULL,NULL,'REG001','New Car Warranty Extension');
INSERT INTO `sale` (`invoiceNumber`,`saleDate`,`salePrice`,`tax`,`registrationFee`,`tradeInAmount`,`financedAmount`,`amountPaid`,`amountDue`,`salesPersonCommission`,`saleMiles`,`custId`,`salespersonId`,`newCarVIN`,`usedCarVIN`,`insurancePolicy`,`insuranceCompany`,`financingPolicy`,`financingCompany`,`tradeInVIN`,`registrationNumber`,`warranteeType`) VALUES ('IN002','2019-08-24',17264.00,1726.00,300.00,0.00,0.00,17264.00,0.00,172.00,123,'C002','SP002','1D7RB1CT7BS881175',NULL,'GEI0002','Geico',NULL,NULL,NULL,'REG002','New Car Warranty');
INSERT INTO `sale` (`invoiceNumber`,`saleDate`,`salePrice`,`tax`,`registrationFee`,`tradeInAmount`,`financedAmount`,`amountPaid`,`amountDue`,`salesPersonCommission`,`saleMiles`,`custId`,`salespersonId`,`newCarVIN`,`usedCarVIN`,`insurancePolicy`,`insuranceCompany`,`financingPolicy`,`financingCompany`,`tradeInVIN`,`registrationNumber`,`warranteeType`) VALUES ('IN003','2019-12-14',20461.00,2046.00,300.00,13000.00,0.00,7461.00,0.00,204.00,123,'C003','SP004','3C63D3HL7CG670654',NULL,'LIB0001','Liberty',NULL,NULL,'WBAKG1C57BE375422','REG003','New Car Warranty Extension');
INSERT INTO `sale` (`invoiceNumber`,`saleDate`,`salePrice`,`tax`,`registrationFee`,`tradeInAmount`,`financedAmount`,`amountPaid`,`amountDue`,`salesPersonCommission`,`saleMiles`,`custId`,`salespersonId`,`newCarVIN`,`usedCarVIN`,`insurancePolicy`,`insuranceCompany`,`financingPolicy`,`financingCompany`,`tradeInVIN`,`registrationNumber`,`warranteeType`) VALUES ('IN004','2019-04-21',31292.00,3129.00,300.00,0.00,10000.00,21292.00,10000.00,312.00,123,'C004','SP001','3VW517AT1EM034793',NULL,'LIB0002','Liberty',NULL,NULL,NULL,'REG004','New Car Warranty');
INSERT INTO `sale` (`invoiceNumber`,`saleDate`,`salePrice`,`tax`,`registrationFee`,`tradeInAmount`,`financedAmount`,`amountPaid`,`amountDue`,`salesPersonCommission`,`saleMiles`,`custId`,`salespersonId`,`newCarVIN`,`usedCarVIN`,`insurancePolicy`,`insuranceCompany`,`financingPolicy`,`financingCompany`,`tradeInVIN`,`registrationNumber`,`warranteeType`) VALUES ('IN005','2019-04-29',25693.00,2569.00,300.00,15000.00,0.00,10000.00,0.00,256.00,123,'C005','SP001','JM1BL1H40A1208372',NULL,'LIB0003','Liberty',NULL,NULL,'2HNYD28257H276330','REG005','New Car Warranty');

INSERT INTO `sale_custom_item` (`invoiceNumber`,`customItem`) VALUES ('IN001',5);
INSERT INTO `sale_custom_item` (`invoiceNumber`,`customItem`) VALUES ('IN002',1);
INSERT INTO `sale_custom_item` (`invoiceNumber`,`customItem`) VALUES ('IN003',1);
INSERT INTO `sale_custom_item` (`invoiceNumber`,`customItem`) VALUES ('IN004',3);
INSERT INTO `sale_custom_item` (`invoiceNumber`,`customItem`) VALUES ('IN005',2);

INSERT INTO `salesperson` (`salespersonId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`homePhoneArea`,`homePhoneNumber`,`officePhoneArea`,`officePhoneNumber`,`cellPhoneArea`,`cellPhoneNumber`,`dateHired`) VALUES ('SP001','Pat','Cawtheray','5 Pankratz Park','Rochester','NY',14639,786,3542296,422,7436544,786,9632453,'2019-02-23');
INSERT INTO `salesperson` (`salespersonId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`homePhoneArea`,`homePhoneNumber`,`officePhoneArea`,`officePhoneNumber`,`cellPhoneArea`,`cellPhoneNumber`,`dateHired`) VALUES ('SP002','Ari','Rembrant','3 Texas Plaza','Johnstown','PA',15906,122,4076779,422,7436554,122,6435647,'2019-01-26');
INSERT INTO `salesperson` (`salespersonId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`homePhoneArea`,`homePhoneNumber`,`officePhoneArea`,`officePhoneNumber`,`cellPhoneArea`,`cellPhoneNumber`,`dateHired`) VALUES ('SP003','Timotheus','Yeowell','03634 Talmadge Lane','New York City','NY',10150,522,5740369,422,7436564,522,8646321,'2018-08-13');
INSERT INTO `salesperson` (`salespersonId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`homePhoneArea`,`homePhoneNumber`,`officePhoneArea`,`officePhoneNumber`,`cellPhoneArea`,`cellPhoneNumber`,`dateHired`) VALUES ('SP004','Rosalyn','Kuhnhardt','62084 Dexter Point','New York City','NY',10115,282,9200832,422,7436574,282,9654771,'2018-03-20');
INSERT INTO `salesperson` (`salespersonId`,`firstName`,`lastName`,`street`,`city`,`state`,`zip`,`homePhoneArea`,`homePhoneNumber`,`officePhoneArea`,`officePhoneNumber`,`cellPhoneArea`,`cellPhoneNumber`,`dateHired`) VALUES ('SP005','Lyman','Bottomer','054 Amoth Avenue','Hartford','CT',6160,936,3733865,422,7436584,936,7129836,'2018-06-23');

INSERT INTO `survey` (`surveyNumber`,`dealershipRating`,`salespersonRating`,`carRating`,`invoiceNumber`) VALUES ('SUR001',2,2,3,'IN001');
INSERT INTO `survey` (`surveyNumber`,`dealershipRating`,`salespersonRating`,`carRating`,`invoiceNumber`) VALUES ('SUR002',2,3,3,'IN002');
INSERT INTO `survey` (`surveyNumber`,`dealershipRating`,`salespersonRating`,`carRating`,`invoiceNumber`) VALUES ('SUR003',2,3,2,'IN003');
INSERT INTO `survey` (`surveyNumber`,`dealershipRating`,`salespersonRating`,`carRating`,`invoiceNumber`) VALUES ('SUR004',1,2,2,'IN004');

INSERT INTO `usedcar` (`VIN`,`make`,`model`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`modelYear`,`mileage`,`bookValue`) VALUES ('2HNYD28257H276330','Subaru','Impreza',4,5,4320,5,'Black',2015,9923,15000.00);
INSERT INTO `usedcar` (`VIN`,`make`,`model`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`modelYear`,`mileage`,`bookValue`) VALUES ('3N1CN7AP4FL777122','Honda','CRV',4,5,3790,5,'Blue',2016,10612,17000.00);
INSERT INTO `usedcar` (`VIN`,`make`,`model`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`modelYear`,`mileage`,`bookValue`) VALUES ('WA1C8AFP8DA597506','BMW','328i',4,5,4123,5,'Black',2017,13199,26000.00);
INSERT INTO `usedcar` (`VIN`,`make`,`model`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`modelYear`,`mileage`,`bookValue`) VALUES ('WAUCVAFRXCA314714','Nissan','Rogue',4,5,4090,5,'Black',2018,21308,16000.00);
INSERT INTO `usedcar` (`VIN`,`make`,`model`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`modelYear`,`mileage`,`bookValue`) VALUES ('WBAKG1C57BE375422','Volkswagen','Golf',4,5,3902,5,'Gray',2015,9407,13000.00);
INSERT INTO `usedcar` (`VIN`,`make`,`model`,`cylinders`,`doors`,`weight`,`capacity`,`color`,`modelYear`,`mileage`,`bookValue`) VALUES ('WDDHF2EB6DA278138','Subaru','Crosstrek',4,5,4145,5,'White',2016,3374,17000.00);

INSERT INTO `usedcar_feature` (`VIN`,`feature`) VALUES ('2HNYD28257H276330','sunroof');
INSERT INTO `usedcar_feature` (`VIN`,`feature`) VALUES ('3N1CN7AP4FL777122','gpsSystem');
INSERT INTO `usedcar_feature` (`VIN`,`feature`) VALUES ('WA1C8AFP8DA597506','sunroof+gpsSystem');
INSERT INTO `usedcar_feature` (`VIN`,`feature`) VALUES ('WAUCVAFRXCA314714','gpsSystem');
INSERT INTO `usedcar_feature` (`VIN`,`feature`) VALUES ('WBAKG1C57BE375422','sunroof');
INSERT INTO `usedcar_feature` (`VIN`,`feature`) VALUES ('WDDHF2EB6DA278138','sunroof+gpsSystem');

INSERT INTO `warrantee
LIMIT 0, 1000` (`warType`,`cost`,`period`) VALUES ('Accessories Warranty',600.00,'2 years');
INSERT INTO `warrantee
LIMIT 0, 1000` (`warType`,`cost`,`period`) VALUES ('New Car Warranty',1000.00,'2 years');
INSERT INTO `warrantee
LIMIT 0, 1000` (`warType`,`cost`,`period`) VALUES ('New Car Warranty Extension',1700.00,'4 years');
INSERT INTO `warrantee
LIMIT 0, 1000` (`warType`,`cost`,`period`) VALUES ('Powertrain Warranty',1300.00,'2 years');
INSERT INTO `warrantee
LIMIT 0, 1000` (`warType`,`cost`,`period`) VALUES ('Used Car Warrantee',500.00,'90 days');

SELECT custID, firstName, lastName, city, state FROM customer
WHERE custID In (
SELECT custID FROM sale
WHERE salespersonId In (
SELECT salespersonId FROM salesperson
WHERE firstName LIKE ‘%Pat%’));

SELECT * FROM warrantee
WHERE warType In (
SELECT warranteeType FROM sale
WHERE newCarVIN In (
SELECT VIN FROM newcar
WHERE  make LIKE ‘%Land Rover%’));

SELECT * FROM registration
WHERE regNumber In (
SELECT registrationNumber FROM sale
WHERE tradeInVIN In (
SELECT VIN FROM UsedCar
WHERE model LIKE ‘%Subaru%’));

SELECT VIN, model FROM newcar
WHERE VIN In (
SELECT newCarVIN FROM sale
WHERE salePrice LIKE ‘%47337%’);

SELECT * FROM survey
WHERE invoiceNumber In (
SELECT invoiceNumber FROM sale
WHERE custId In (
SELECT custId FROM customer
WHERE firstName LIKE ‘%Marge%’));  

CREATE TRIGGER formatting_values
BEFORE INSERT ON customer
FOR EACH ROW
SET 
NEW.firstName = CONCAT(UPPER(LEFT(new.firstName, 1)), SUBSTRING(new.firstName, 2)),
NEW.lastName = CONCAT(UPPER(LEFT(new.lastName, 1)), SUBSTRING(new.lastName, 2)),
NEW.custId = CONCAT(UPPER(LEFT(new.custId, 1)), SUBSTRING(new.custId, 2)),
NEW.city = CONCAT(UPPER(LEFT(new.city, 1)), SUBSTRING(new.city, 2)),
NEW.state = UPPER(NEW.state);

INSERT INTO customer values ('c011', 'rodrigo', 'martins', '750 Summer Street', 'stamford', 'ct', null, null, null, null, null, null);
