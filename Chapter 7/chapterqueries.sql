CREATE VIEW customerview AS 
	SELECT 
		c.custId, 
		c.firstName, 
        c.lastName, 
        c.street, 
        z.city,
        z.state,
        c.zip, 
        c.phoneArea, 
        c.phoneNumber
	FROM customer as c
    JOIN zips as z
		ON c.zip = z.zip;

SELECT * FROM customerview;

CREATE USER 'U_001' IDENTIFIED BY '12345';
GRANT SELECT ON CustomerView TO 'U_001';

CREATE USER 'U_002' IDENTIFIED BY '12345';
CREATE USER 'U_003' IDENTIFIED BY '12345';
CREATE USER 'U_004' IDENTIFIED BY '12345';
CREATE USER 'U_005' IDENTIFIED BY '12345';

GRANT SELECT ON sale TO 'U_002';
GRANT ALL PRIVILEGES ON financing TO 'U_003';
GRANT SELECT, UPDATE, INSERT, DELETE ON newcar TO 'U_004' WITH GRANT OPTION;
GRANT UPDATE ON salesperson TO 'U_005';

SET @username := user();
CREATE TABLE newcar_price_audit (
	dateofChange	DATE,
    userChanged		VARCHAR(50),
	IDofNewCar		INT(6),
	oldPrice		DECIMAL(10,2),
	newPrice		DECIMAL(10,2));

DELIMITER %
CREATE TRIGGER NewCarPriceAuditTrail
	BEFORE UPDATE ON newcar
	FOR EACH ROW
    BEGIN
		INSERT INTO newcar_price_audit VALUES (
			NOW(),
            @username,
			OLD.newCarId,
			OLD.listPrice, 
			NEW.listPrice);
	END%
DELIMITER ;

SELECT * FROM newcar WHERE newCarId = 3;
SELECT * FROM newcar_price_audit;
UPDATE car_dealership.newcar SET listPrice = '24300.00' WHERE (newCarId = 3);
SELECT * FROM newcar_price_audit;

SELECT * FROM newcar WHERE newCarId = 3;
SELECT * FROM newcar_price_audit;

UPDATE car_dealership.newcar SET listPrice = '24300.00' WHERE (newCarId = 3);
SELECT * FROM newcar WHERE newCarId = 3;
SELECT * FROM newcar_price_audit;
