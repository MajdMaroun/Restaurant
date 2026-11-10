UPDATE Customers SET Password = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' WHERE Email = 'John@gmail.com';
UPDATE Customers SET Password = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' WHERE Email = 'Alice@gmail.com';
UPDATE Customers SET Password = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' WHERE Email = 'Bob@gmail.com';
UPDATE Admins SET Password = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' WHERE Username = 'admin';


ALTER TABLE Customers ADD FailedAttempts INT DEFAULT 0;
ALTER TABLE Customers ADD IsLocked BIT DEFAULT 0;

UPDATE Customers SET FailedAttempts = 0, IsLocked = 0 WHERE FailedAttempts IS NULL;

ALTER TABLE Customers ADD LockedUntil DATETIME NULL;

ALTER TABLE Orders ADD DeliveryType    VARCHAR(20) DEFAULT 'Delivery';
ALTER TABLE Orders ADD DeliveryAddress VARCHAR(255) NULL;

ALTER TABLE Orders ADD Notes VARCHAR(500) NULL;