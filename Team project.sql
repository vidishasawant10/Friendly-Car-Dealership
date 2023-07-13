CREATE TABLE CuZip(
    zip NUMBER NOT NULL
    city VARCHAR2(15) NULL
    state CHAR(15) NULL
    PRIMARY KEY (zip)
);

INSERT INTO CuZip VALUES(10036,'NYC','NY');
INSERT INTO CuZip VALUES(10126,'NYC','NY');
INSERT INTO CuZip VALUES(10246,'NYC','NY');
INSERT INTO CuZip VALUES(10456,'NYC','NY');
INSERT INTO CuZip VALUES(10636,'NYC','NY');


CREATE TABLE CarCustomer(
    custId VARCHAR2(15) NOT NULL,
    firstName VARCHAR2(15) NOT NULL,
    lastName VARCHAR2(15) NOT NULL,
    street VARCHAR2(45) NULL,
    zip NUMBER NULL,
    areaCode NUMBER NULL, 
    phoneNumber VARCHAR2(12) NULL,
    driversLicNo VARCHAR2(12) NULL, 
    referredBy VARCHAR2(15) NULL,
    adSeen VARCHAR2(10) NULL,
    PRIMARY KEY (custId),
    UNIQUE (driversLicNo));
    CONSTRAINT zip_fk FOREIGN KEY (zip) REFERENCES CuZip(zip),
);

INSERT INTO CarCustomer VALUES('NY2221','Vicktoria','Grillo','32street',10036,213,2132442123,'DL1233212','Billy','CarAd');
INSERT INTO CarCustomer VALUES('NH123','Billy','Stark','31street',10126,213,2132342133,'DL12234212','Will','CarAd');
INSERT INTO CarCustomer VALUES('NJ2321','Siamon','Rollens','22street',10246,112,1123442123,'D234233212','Billy','CarAd');
INSERT INTO CarCustomer VALUES('NY324123','Will','Hens','45street',10456,213,2134324623,'DL1233242312','Will','CarAd');
INSERT INTO CarCustomer VALUES('NH4234','Steven','Cook','42street',10636,332,3322234523,'DL1234322','Will','CarAd');

CREATE TABLE CarAd(
  placedIn VARCHAR2(10) NOT NULL,
  initialDate DATE NOT NULL,
  totalCost NUMBER,
  frequency NUMBER,
  contactPerson VARCHAR2(15),
  areaCode NUMBER(12) ,
  phoneNumber NUMBER(12),
  CONSTRAINT Pk_palcedate PRIMARY KEY (placedIn, initialDate));


INSERT INTO CarAd VALUES('NY',TO_DATE('2022/01/01','yyyy/mm/dd'),1000,12,'Vicktoria',10036,2132442123);
INSERT INTO CarAd VALUES('NJ',TO_DATE('2022/02/23','yyyy/mm/dd'),1200,12,'Simon',13336,21323442123);
INSERT INTO CarAd VALUES('CA',TO_DATE('2022/01/25','yyyy/mm/dd'),1500,12,'Will',10236,3221432123);
INSERT INTO CarAd VALUES('NY',TO_DATE('2022/03/01','yyyy/mm/dd'),1800,12,'Billy',11036,1232143212);
INSERT INTO CarAd VALUES('NY',TO_DATE('2022/02/22','yyyy/mm/dd'),1700,12,'Sam',10236,421342123);

CREATE TABLE CarNewCar (
        VIN VARCHAR2(45) NOT NULL,
        make VARCHAR2(45) NULL,
        model VARCHAR2(45) NOT NULL,
        listPrice NUMBER NULL,
        dateManufactured DATE NULL,
        placeManufactured VARCHAR2(45) NULL,
        color VARCHAR2(20) NULL,
        delDate DATE NULL,
        delMiles NUMBER NULL,
        PRIMARY KEY (VIN),
        CONSTRAINT model_fk FOREIGN KEY (model) REFERENCES CarModel(model)
);
INSERT INTO CarNewCar VALUES('4Y1SL65848Z411439','ford','figo',20000,TO_DATE('2020/01/01','yyyy/mm/dd'),'NYC','white',TO_DATE('2020/05/01','yyyy/mm/dd'),0,'white');    
INSERT INTO CarNewCar VALUES('4Y1SL65848Z411438','Honda','city',30000,TO_DATE('2021/01/01','yyyy/mm/dd'),'NJ','black',TO_DATE('2021/05/01','yyyy/mm/dd'),0,'black');
INSERT INTO CarNewCar VALUES('4Y1SL65848Z411437','Audi','A4',40000,TO_DATE('2020/02/01','yyyy/mm/dd'),'CA','black',TO_DATE('2020/05/01','yyyy/mm/dd'),0,'black');
INSERT INTO CarNewCar VALUES('4Y1SL65848Z411436','Audi','A3',45000,TO_DATE('2020/03/21','yyyy/mm/dd'),'NJ','white',TO_DATE('2020/05/01','yyyy/mm/dd'),0,'white');
INSERT INTO CarNewCar VALUES('4Y1SL65848Z411435','ford','feasta',24000,TO_DATE('2021/05/21','yyyy/mm/dd'),'NYC','blue',TO_DATE('2021/06/11','yyyy/mm/dd'),0,'blue');


CREATE TABLE CarModel(
    model VARCHAR2(45) NOT NULL,
    cylinders NUMBER NULL,
    doors NUMBER NULL,
    weight NUMBER NULL,
    capacity NUMBER NULL,
    PRIMARY KEY(model)
);

INSERT INTO CarModel VALUES ('figo',4,2,100,4);
INSERT INTO CarModel VALUES ('city',4,2,100,4);
INSERT INTO CarModel VALUES ('A4',4,2,100,4);
INSERT INTO CarModel VALUES ('A3',4,2,100,4);
INSERT INTO CarModel VALUES ('feasta',4,2,100,4);

CREATE TABLE CarOptionsMenu(
    carOption VARCHAR2(10) NOT NULL,
    price NUMBER NULL,
    PRIMARY KEY (carOption),
);

INSERT INTO CarOptionsMenu VALUES('City',23000)
INSERT INTO CarOptionsMenu VALUES('CityPro',29000);
INSERT INTO CarOptionsMenu VALUES('CityLight',21000);
INSERT INTO CarOptionsMenu VALUES('Duo',43000);
INSERT INTO CarOptionsMenu VALUES('XUV',33000);


CREATE TABLE CarNewCar_Options (
    VIN VARCHAR2(20) NOT NULL,
    carOption VARCHAR2(20) NULL,
    PRIMARY KEY (VIN),
    CONSTRAINT carOption_fk FOREIGN KEY (carOption) REFERENCES CarOptionsMenu(carOption)
);

INSERT INTO CarNewCar_Options VALUES('4Y1SL65848Z411439','City');
INSERT INTO CarNewCar_Options VALUES('4Y1SL65848Z411438','CityPro');
INSERT INTO CarNewCar_Options VALUES('4Y1SL65848Z411437','CityLight');
INSERT INTO CarNewCar_Options VALUES('4Y1SL65848Z411436','Duo');
INSERT INTO CarNewCar_Options VALUES('4Y1SL65848Z411435','XUV');

CREATE TABLE CarCustomizationMenu (
    customItem VARCHAR2(15) NOT NULL,
    price NUMBER NULL,
    PRIMARY KEY (customItem)
);

INSERT INTO  CarCustomizationMenu VALUES('color',1500);
INSERT INTO  CarCustomizationMenu VALUES('door',3000);
INSERT INTO  CarCustomizationMenu VALUES('light',1500);
INSERT INTO  CarCustomizationMenu VALUES('handel',1000);
INSERT INTO  CarCustomizationMenu VALUES('mirror',500);

CREATE TABLE CarSalesPerson(
  empId VARCHAR2(15) NOT NULL,
  firstName VARCHAR2(15) NULL,
  lastName VARCHAR2(15) NULL,
  street VARCHAR2(15) NULL,
  zip CHAR(15) NOT NULL,
  homeAreaCode CHAR(15) NULL,
  homePhoneNumber NUMBER NULL,
  officeAreaCode CHAR(15) NULL,
  officePhoneNumber NUMBER NULL,
  cellAreaCode CHAR(15) NULL,
  cellPhoneNumber NUMBER NULL,
  dateHired DATE NULL,
  PRIMARY KEY (empId)
  CONSTRAINT salzip_fk FOREIGN KEY (zip) REFERENCES SalesPZip(zip)
);

INSERT INTO CarSalesPerson VALUES('em001','Vicktoria','Grillo','32street',10036,'','','','','+1',3213212321,TO_DATE('2021/06/11','yyyy/mm/dd'));
INSERT INTO CarSalesPerson VALUES('em002','Brayan','Kung','21peterson',10032,'','','','','+1',2341234321,TO_DATE('2021/02/11','yyyy/mm/dd'));
INSERT INTO CarSalesPerson VALUES('em003','Tom','Cruise','4street',10033,'','','','','+1',32132321343,TO_DATE('2021/03/23','yyyy/mm/dd'));
INSERT INTO CarSalesPerson VALUES('em004','Chandler','Bing','24street',40036,'','','','','+1',3213212342,TO_DATE('2021/04/22','yyyy/mm/dd'));
INSERT INTO CarSalesPerson VALUES('em005','Sheldon','Cooper','22street',50036,'','','','','+1',321322432,TO_DATE('2021/07/21','yyyy/mm/dd'));

CREATE TABLE SalesPZip(
  zip CHAR(15) NOT NULL,  
  city CHAR(15) NULL,
  state CHAR(15) NULL,
);

INSERT INTO SalesPZip(10036,'NYC','NY');
INSERT INTO SalesPZip(10032,'NYC','NY');
INSERT INTO SalesPZip(10033,'NYC','NY');
INSERT INTO SalesPZip(40036,'NYC','NY');
INSERT INTO SalesPZip(50036,'NYC','NY');


CREATE TABLE CarRegistration(
  registrationNo VARCHAR2(15) NOT NULL,
  plateNo VARCHAR2(15) NULL,
  fee NUMBER NULL,
  PRIMARY KEY (registrationNo)
);

INSERT INTO  CarRegistration VALUES('1232RC','LTO1234',100);
INSERT INTO  CarRegistration VALUES('1233RC','LTO1235',100);
INSERT INTO  CarRegistration VALUES('1234RC','LTO1236',100);
INSERT INTO  CarRegistration VALUES('1235RC','LTO1237',100);
INSERT INTO  CarRegistration VALUES('1236RC','LTO1238',100);


CREATE TABLE InsuranceCompanyName(
    companyName VARCHAR2(30) NOT NULL,
    street VARCHAR2(45) NULL,
    zip NUMBER NOT NULL,
    areaCode NUMBER NULL,
    phoneNumber VARCHAR2(12) NULL,
    PRIMARY KEY (companyName),
    CONSTRAINT Inzip_fk FOREIGN KEY (zip) REFERENCES In_Zip(zip)
);

INSERT INTO CarInsurance VALUES('Reliance','Spruce',10036,+1,2154466257);
INSERT INTO CarInsurance VALUES('TataMotors','Manhattan ave',10036,+1,2154466245);
INSERT INTO CarInsurance VALUES('Reliance','Beach Street',10036,+1,2154466241);
INSERT INTO CarInsurance VALUES('HD1L','Carlton ave',10036,+1,2154466789);
INSERT INTO CarInsurance VALUES('Wills','9th street',10036,+1,2154466547);


CREATE TABLE InsurancePolicy(
    insPolicyNo VARCHAR2(15) NOT NULL,
    companyName VARCHAR2(30) NOT NULL,
    startDate DATE NULL,
    endDate DATE NULL,
    PRIMARY KEY (insPolicyNo),
    CONSTRAINT companyName_fk FOREIGN KEY (companyName) REFERENCES InsuranceCompanyName(companyName)
);

INSERT INTO InsurancePolicy('4Y1SL65439-A1','Reliance',TO_DATE('2021/01/01','yyyy/mm/dd'),TO_DATE('2022/01/01','yyyy/mm/dd'));
INSERT INTO InsurancePolicy('4Y1SL65839-A2','TataMotors',TO_DATE('2021/11/11','yyyy/mm/dd'),TO_DATE('2022/11/11','yyyy/mm/dd'));
INSERT INTO InsurancePolicy('4Y1SL65Z49-A3','Reliance',TO_DATE('2021/02/05','yyyy/mm/dd'),TO_DATE('2022/02/05','yyyy/mm/dd'));
INSERT INTO InsurancePolicy('4Y1SL65849-A4','HD1L',TO_DATE('2021/10/06','yyyy/mm/dd'),TO_DATE('2022/10/06','yyyy/mm/dd'));
INSERT INTO InsurancePolicy('4Y1SL65839-A5','Wills',TO_DATE('2021/08/22','yyyy/mm/dd'),TO_DATE('2022/08/22','yyyy/mm/dd'));

CREATE TABLE In_Zip(
    zip NUMBER NOT NULL,
    state VARCHAR2(15) NULL,
    city VARCHAR2(15) NULL,
    PRIMARY KEY (zip)
);

INSERT INTO In_Zip('NYC','NY');
INSERT INTO In_Zip('NYC','NY');
INSERT INTO In_Zip('NYC','NY');
INSERT INTO In_Zip('NYC','NY');
INSERT INTO In_Zip('NYC','NY');

CREATE TABLE FinanceCompany(
    companyName VARCHAR2(30) NOT NULL,
    street VARCHAR2(45) NULL,
    zip NUMBER NOT NULL,
    PRIMARY KEY (companyName),
    CONSTRAINT Fizip_fk FOREIGN KEY (zip) REFERENCES FinanceZip(zip)
);

INSERT INTO FinanceCompany VALUES('Reliance','Spruce','NYC','NY',10036,+1,2154466257,TO_DATE('2021/01/01','yyyy/mm/dd'),20000,10,60);
INSERT INTO FinanceCompany VALUES('TataMotors','Manhattan ave','NYC','NY',10036,+1,2154466245,TO_DATE('2021/11/11','yyyy/mm/dd'),15500,15,50);
INSERT INTO FinanceCompany VALUES('Reliance','Beach Street','NYC','NY',10036,+1,2154466241,TO_DATE('2021/02/05','yyyy/mm/dd'),25000,8,30);
INSERT INTO FinanceCompany VALUES('HD1L','Carlton ave','NYC','NY',10036,+1,2154466789,TO_DATE('2021/10/06','yyyy/mm/dd'),16000,7.5,25);
INSERT INTO FinanceCompany VALUES('Wills','9th street','NYC','NY',10036,+1,2154466547,TO_DATE('2021/08/22','yyyy/mm/dd'),17000,11,18);

CREATE TABLE FinanceZip(
    zip NUMBER NOT NULL,
    city VARCHAR2(15) NULL,
    state VARCHAR2(15) NULL,
    PRIMARY KEY (zip),
);

INSERT INTO FinanceZip VALUES ();
INSERT INTO FinanceZip VALUES ();
INSERT INTO FinanceZip VALUES ();
INSERT INTO FinanceZip VALUES ();
INSERT INTO FinanceZip VALUES ();

CREATE TABLE FinancedCar(
    finPolicyNo VARCHAR2(20) NOT NULL,
    companyName VARCHAR2(30) NOT NULL,
    amountFinanced NUMBER NOT NULL,
    PRIMARY KEY(finPolicyNo),
    CONSTRAINT FicompanyName_fk FOREIGN KEY (companyName) REFERENCES FinanceCompany(companyName),
    CONSTRAINT amountFinanced_fk FOREIGN KEY(amountFinanced) REFERENCES FinancedAmount(amountFinanced)
);

INSERT INTO FinancedCar VALUES('4Y1SL65848Z411440-F1','Reliance',20000);
INSERT INTO FinancedCar VALUES('4Y1SL65848Z411444-F2','TataMotors',15500);
INSERT INTO FinancedCar VALUES('4Y1SL65848Z411446-F3','Reliance',25000);
INSERT INTO FinancedCar VALUES('4Y1SL65848Z411485-F4','HD1L',16000);
INSERT INTO FinancedCar VALUES('4Y1SL65848Z411496-F5','Wills',17000);

CREATE TABLE FinancedAmount(
    amountFinanced NUMBER NOT NULL,
    rate NUMBER NULL,
    numberMonths NUMBER NULL,
    startDate DATE NULL,
    PRIMARY KEY (amountFinanced)
);

INSERT INTO FinancedAmount VALUES();
INSERT INTO FinancedAmount VALUES();
INSERT INTO FinancedAmount VALUES();
INSERT INTO FinancedAmount VALUES();
INSERT INTO FinancedAmount VALUES();

CREATE TABLE CarWarranty (
  warType VARCHAR2(15) NOT NULL,
  cost NUMBER NULL,
  period NUMBER NULL,
  PRIMARY KEY (warType)
);
INSERT INTO CarWarranty VALUES('BtoB',2000,1.5);
INSERT INTO CarWarranty VALUES('Rust',3000,3);
INSERT INTO CarWarranty VALUES('Powertrain',2500,2);

CREATE TABLE CarUsedCarVIN (
  VIN VARCHAR2(20) NOT NULL,
  make VARCHAR2(20) NULL,
  model VARCHAR2(20) NOT NULL,
  color VARCHAR2(20) NULL,
  modelYear NUMBER NULL,
  mileage NUMBER NULL,
  bookValue NUMBER NULL,
  PRIMARY KEY (VIN),
  CONSTRAINT usemodel_fk FOREIGN KEY (model) REFERENCES CarUsedCarSpec(model)
);

INSERT INTO CarUsedCarVIN Values('4Y1SL65848Z411449','ford','figo','white',2021,1500,15000);
INSERT INTO CarUsedCarVIN Values('4Y1SL65848Z411448','Honda','city','black', 2015, 1000, 10000);
INSERT INTO CarUsedCarVIN Values('4Y1SL65848Z411447','Audi','A4','black', 2016,1000,16000);
INSERT INTO CarUsedCarVIN Values('4Y1SL65848Z411446','Audi','A3','white',2013,800,13000);
INSERT INTO CarUsedCarVIN Values('4Y1SL65848Z411445','ford','feasta','blue',2017,1100,15000);

CREATE TABLE CarUsedCarSpec(
  model VARCHAR2(20) NOT NULL,
  cylinders VARCHAR2(20) NULL,
  doors NUMBER NULL,
  weight NUMBER NULL,
  capacity NUMBER NULL,
  PRIMARY KEY (model)
);
   

INSERT INTO CarUsedCarSpec VALUES('figo',4,2,1000,4);
INSERT INTO CarUsedCarSpec VALUES('city',4,2,1500,4);
INSERT INTO CarUsedCarSpec VALUES('A4',8,4,2600,8);
INSERT INTO CarUsedCarSpec VALUES('A3',4,2,1000,4);
INSERT INTO CarUsedCarSpec VALUES('feasta',4,2,1700,4);


CREATE TABLE CarUsedCarFeatures (
  VIN VARCHAR2(20) NOT NULL,
  feature VARCHAR2(45) NOT NULL,
  CONSTRAINT PK_CarUsedCarFeatures PRIMARY KEY  (Vin, feature)
  CONSTRAINT VIN_fk FOREIGN KEY (VIN) REFERENCES CarUsedCarVIN(VIN)
);

INSERT INTO CarUsedCarFeatures VALUES('4Y1SL65848Z411449','color');
INSERT INTO CarUsedCarFeatures VALUES('4Y1SL65848Z411448','door');
INSERT INTO CarUsedCarFeatures VALUES('4Y1SL65848Z411447','light');
INSERT INTO CarUsedCarFeatures VALUES('4Y1SL65848Z411446','handle');
INSERT INTO CarUsedCarFeatures VALUES('4Y1SL65848Z411445','mirror');

CREATE TABLE CarSale(
  invoiceNo VARCHAR2(20) NOT NULL,
  saleDate DATE NULL,
  salePrice NUMBER NULL,
  tax NUMBER NULL,
  registrationFee NUMBER NULL,
  tradeinAmount NUMBER NULL,
  amountPaid NUMBER NULL,
  amountDue NUMBER NULL,
  commission NUMBER NULL,
  saleMiles NUMBER NULL,
  custId VARCHAR2(20) NOT NULL,
  empId VARCHAR2(20) NOT NULL,
  newCarVIN VARCHAR2(20) NOT NULL,
  usedCarVIN VARCHAR2(20) NOT NULL,
  insPolNo VARCHAR2(15) NOT NULL,
  insCoName VARCHAR2(15) NOT NULL,
  finPolNo VARCHAR2(20) NOT NULL,

  finCoName VARCHAR2(20) NOT NULL,
  tradeInVIN VARCHAR2(20) NULL,
  registrationNo VARCHAR2(20) NOT NULL,
  warType VARCHAR2(20) NOT NULL,
  PRIMARY KEY (invoiceNo),
  CONSTRAINT custId_fk FOREIGN KEY (custId) REFERENCES CarCustomer(custId),
  CONSTRAINT empId_fk FOREIGN KEY (empId) REFERENCES CarSalesPerson(empId),
  CONSTRAINT insPolNo_fk FOREIGN KEY (insPolNo, insComName) REFERENCES CarInsurance(insPolicyNo, companyName),
  CONSTRAINT finPolNo_fk FOREIGN KEY (finPolNo, finCoName) REFERENCES CarFinancing(finPolicyNo, companyName),
  CONSTRAINT registrationNo_fk FOREIGN KEY (registrationNo) REFERENCES CarRegistration(registrationNo),
  CONSTRAINT warType_fk FOREIGN KEY (warType) REFERENCES CarWarranty(warType)
);

INSERT INTO CarSale VALUES ('C-671',TO_DATE('2021/01/01','yyyy/mm/dd'),40000,5000,100,200,25000,15000,100,0,'NY2221','em001',
'4Y1SL65848Z411439','N/A','4Y1SL65439-A1','Reliance','4Y1SL65848Z411440-F1','Reliance','N/A','1232RC','BtoB');
INSERT INTO CarSale VALUES('C-672',TO_DATE('2021/02/01','yyyy/mm/dd'),50000,5000,100,200,25000,25000,100,0,'NH123','em002',
'4Y1SL65848Z411438','N/A','4Y1SL65839-A2','TataMotors','4Y1SL65848Z411444-F2','TataMotors','N/A','1233RC','BtoB');
INSERT INTO CarSale VALUES('C-673',TO_DATE('2021/03/01','yyyy/mm/dd'),30000,5000,100,200,15000,15000,100,0,'NJ2321','em003',
'4Y1SL65848Z411437','N/A','4Y1SL65439-A1','Reliance','4Y1SL65848Z411440-F1','Reliance','N/A','1234RC','BtoB');
INSERT INTO CarSale VALUES('C-674',TO_DATE('2021/02/11','yyyy/mm/dd'),40000,5000,100,200,25000,20000,100,0,'NY324123','em004',
'4Y1SL65848Z411436','N/A','4Y1SL65839-A2','TataMotors','4Y1SL65848Z411444-F2','TataMotors','N/A','1235RC','BtoB');
INSERT INTO CarSale VALUES('C-675',TO_DATE('2021/11/11','yyyy/mm/dd'),50000,5000,100,200,25000,25000,100,0,'NH4234','em005',
'4Y1SL65848Z411435','N/A','4Y1SL65439-A1','Reliance','4Y1SL65848Z411440-F1','Reliance','N/A','1236RC','BtoB');



CREATE TABLE CarSale_CustomItem(
  invoiceNo VARCHAR2(20) NOT NULL,
  customItem VARCHAR2(20) NOT NULL,
  CONSTRAINT CarSale_CustomItem PRIMARY KEY  (invoiceNo, customItem),
  CONSTRAINT insPolNo1_fk FOREIGN KEY (invoiceNo) REFERENCES CarSale(invoiceNo),
  CONSTRAINT customItem_fk FOREIGN KEY (customItem) REFERENCES CarCustomizationMenu(customItem));


INSERT INTO CarSale_CustomItem VALUES('C-671','AUDIO SYSTEM');
INSERT INTO CarSale_CustomItem VALUES('C-672','Bluetooth');
INSERT INTO CarSale_CustomItem VALUES('C-673','SUNROOF');
INSERT INTO CarSale_CustomItem VALUES('C-674','Seat cover');
INSERT INTO CarSale_CustomItem VALUES('C-675','Gear pad');

CREATE TABLE CarSurvey(
    surveyNumber NUMBER NOT NULL,
    dealershipRating NUMBER NULL,
    carRating NUMBER NULL,
    salesPersonRating NUMBER NULL,
    invoiceNo VARCHAR2(20) NOT NULL,
    PRIMARY KEY (surveyNumber)
);

INSERT INTO CustomerSurvey VALUES(451,8,9,9,'C-671');
INSERT INTO CustomerSurvey VALUES(452,7,8,8,'C-672');
INSERT INTO CustomerSurvey VALUES(453,8,8,8,'C-673');
INSERT INTO CustomerSurvey VALUES(454,8,8,7,'C-674');
INSERT INTO CustomerSurvey VALUES(455,7,8,9,'C-675');



drop user user CASCADE;