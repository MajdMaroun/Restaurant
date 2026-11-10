-- =============================================
-- Seed Data
-- =============================================

-- Admins
INSERT INTO Admins (Username, Password) VALUES
('admin', '1234');

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, Password) VALUES
('John', 'Doe', 'John@gmail.com', '+961 70 111 111', 'Tripoli, Lebanon', '1234'),
('Alice', 'Smith', 'Alice@gmail.com', '+961 70 222 222', 'Beirut, Lebanon', '1234'),
('Bob', 'Johnson', 'Bob@gmail.com', '+961 76 882 546', 'Zgharta, Koura', '1234');

-- MenuCategories
INSERT INTO MenuCategories (Name, Description) VALUES
('Sandwiches', 'Fresh sandwiches prepared with quality ingredients'),
('Subs', 'Tasty hot and cold subs filled with premium flavors'),
('Burgers', 'Juicy burgers loaded with cheese and fresh ingredients'),
('Appetizers', 'Starters and sides to complement your meal'),
('Beverages', 'Cold drinks and fresh juices');

-- MenuItems
INSERT INTO MenuItems (CategoryID, Name, Description, Price, IsAvailable) VALUES
-- Sandwiches (CategoryID = 1)
(1, 'Tawook', 'Grilled chicken sandwich with garlic sauce', 6.00, 1),
(1, 'Tawook & Cheese', 'Grilled chicken sandwich with cheese', 7.00, 1),
(1, 'Tawook Special', 'Grilled chicken with special house sauce', 8.00, 1),
(1, 'Kafta', 'Spiced ground meat sandwich', 7.00, 1),
(1, 'Sujuk', 'Spicy sausage sandwich', 8.00, 1),
-- Subs (CategoryID = 2)
(2, 'Submarine', 'Classic submarine sandwich', 7.00, 1),
(2, 'Fajita', 'Chicken fajita sub with peppers', 8.00, 1),
(2, 'Chicken Sub', 'Grilled chicken sub', 8.00, 1),
(2, 'Chicken Francisco', 'Special chicken francisco sub', 8.00, 1),
-- Burgers (CategoryID = 3)
(3, 'Classic Burger', 'Beef patty with lettuce and tomato', 7.00, 1),
(3, 'Cheese Burger', 'Beef patty with melted cheddar', 8.00, 1),
(3, 'Double Burger', 'Two beef patties stacked high', 10.00, 1),
(3, 'Spicy Burger', 'Beef patty with spicy sauce', 9.00, 1),
(3, 'Mushroom Burger', 'Beef patty with sauteed mushrooms', 9.00, 1),
-- Appetizers (CategoryID = 4)
(4, 'Mozzarella Sticks', 'Crispy fried mozzarella sticks', 4.00, 1),
(4, 'Cheddar Balls', 'Crispy fried cheddar cheese balls', 4.00, 1),
(4, 'Jalapeno Bites', 'Spicy jalapeno stuffed bites', 4.00, 1),
-- Beverages (CategoryID = 5)
(5, 'Pepsi', 'Can of Pepsi', 1.00, 1),
(5, '7UP', 'Can of 7UP', 1.00, 1),
(5, 'Sparkling Water', 'Sparkling water bottle', 1.00, 1),
(5, 'Water', 'Still water bottle', 0.50, 1),
(5, 'Orange Juice', 'Fresh squeezed orange juice', 1.00, 1);