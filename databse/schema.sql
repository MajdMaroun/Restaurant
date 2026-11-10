-- =============================================
-- Restaurant Database Schema
-- =============================================

-- 1. Admins
CREATE TABLE [dbo].[Admins]
(
    [AdminID]  INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [Username] VARCHAR(50) NOT NULL UNIQUE,
    [Password] VARCHAR(255) NOT NULL
);

-- 2. Customers
CREATE TABLE [dbo].[Customers]
(
    [CustomerID] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [FirstName]  VARCHAR(50) NOT NULL,
    [LastName]   VARCHAR(50) NOT NULL,
    [Email]      VARCHAR(100) NOT NULL UNIQUE,
    [Phone]      VARCHAR(20),
    [Address]    VARCHAR(255),
    [Password]   VARCHAR(255) NOT NULL
);

-- 3. MenuCategories
CREATE TABLE [dbo].[MenuCategories]
(
    [CategoryID]          INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [Name]                VARCHAR(50) NOT NULL,
    [Description]         VARCHAR(255)
);

-- 4. MenuItems
CREATE TABLE [dbo].[MenuItems]
(
    [ItemID]      INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [CategoryID]  INT NOT NULL,
    [Name]        VARCHAR(100) NOT NULL,
    [Description] VARCHAR(500),
    [Price]       DECIMAL(10,2) NOT NULL,
    [IsAvailable] BIT DEFAULT 1,
    FOREIGN KEY (CategoryID) REFERENCES MenuCategories(CategoryID)
);

-- 5. Cart
CREATE TABLE [dbo].[Cart]
(
    [CartID]     INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [CustomerID] INT NOT NULL,
    [CreatedAt]  DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 6. CartItems
CREATE TABLE [dbo].[CartItems]
(
    [CartItemID] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [CartID]     INT NOT NULL,
    [ItemID]     INT NOT NULL,
    [Quantity]   INT NOT NULL DEFAULT 1,
    FOREIGN KEY (CartID)  REFERENCES Cart(CartID),
    FOREIGN KEY (ItemID)  REFERENCES MenuItems(ItemID)
);

-- 7. Orders
CREATE TABLE [dbo].[Orders]
(
    [OrderID]    INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [CustomerID] INT NOT NULL,
    [OrderDate]  DATETIME DEFAULT GETDATE(),
    [TotalPrice] DECIMAL(10,2) NOT NULL,
    [Status]     VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 8. OrderItems
CREATE TABLE [dbo].[OrderItems]
(
    [OrderItemID] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [OrderID]     INT NOT NULL,
    [ItemID]      INT NOT NULL,
    [Quantity]    INT NOT NULL,
    [UnitPrice]   DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ItemID)  REFERENCES MenuItems(ItemID)
);