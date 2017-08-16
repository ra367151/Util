﻿/*========================================================== 1. 创建数据库 ===========================================================*/
USE [master]
GO

--删除数据库
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'UtilTest'
GO
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'UtilTest')
Begin
DROP DATABASE [UtilTest]
End
GO

--创建数据库
CREATE DATABASE [UtilTest]
GO

/*========================================================== 2. 创建架构 ===========================================================*/
USE [UtilTest]
GO

/* 1. Sales */
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'Sales')
DROP SCHEMA [Sales]
GO
CREATE SCHEMA [Sales] AUTHORIZATION [dbo]
GO

/* 2. Productions */
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'Productions')
DROP SCHEMA [Productions]
GO
CREATE SCHEMA [Productions] AUTHORIZATION [dbo]
GO

/*========================================================== 3. 创建表 ===========================================================*/


if exists (select 1
            from  sysobjects
           where  id = object_id('Productions.Products')
            and   type = 'U')
   drop table Productions.Products
go

/*==============================================================*/
/* Table: Products                                              */
/*==============================================================*/
create table Productions.Products (
   ProductId            int                  not null,
   Code                 nvarchar(30)         not null,
   Name                 nvarchar(200)        not null,
   Extends              nvarchar(max)        null,
   Price                decimal(10,2)        null,
   IsDeleted            bit                  not null,
   Version              timestamp            null,
   constraint PK_PRODUCTS primary key (ProductId)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Productions.Products') and minor_id = 0)
begin 
   execute sp_dropextendedproperty 'MS_Description',  
   'schema', 'Productions', 'table', 'Products' 
 
end 


execute sp_addextendedproperty 'MS_Description',  
   '商品', 
   'schema', 'Productions', 'table', 'Products'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ProductId')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'ProductId'

end


execute sp_addextendedproperty 'MS_Description', 
   '商品编号',
   'schema', 'Productions', 'table', 'Products', 'column', 'ProductId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Code')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'Code'

end


execute sp_addextendedproperty 'MS_Description', 
   '商品编码',
   'schema', 'Productions', 'table', 'Products', 'column', 'Code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'Name'

end


execute sp_addextendedproperty 'MS_Description', 
   '商品名称',
   'schema', 'Productions', 'table', 'Products', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Extends')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'Extends'

end


execute sp_addextendedproperty 'MS_Description', 
   '扩展属性',
   'schema', 'Productions', 'table', 'Products', 'column', 'Extends'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Price')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'Price'

end


execute sp_addextendedproperty 'MS_Description', 
   '价格',
   'schema', 'Productions', 'table', 'Products', 'column', 'Price'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'IsDeleted')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'IsDeleted'

end


execute sp_addextendedproperty 'MS_Description', 
   '是否删除',
   'schema', 'Productions', 'table', 'Products', 'column', 'IsDeleted'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Productions.Products')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Version')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Productions', 'table', 'Products', 'column', 'Version'

end


execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'schema', 'Productions', 'table', 'Products', 'column', 'Version'
go






if exists (select 1
            from  sysobjects
           where  id = object_id('Sales.Orders')
            and   type = 'U')
   drop table Sales.Orders
go

/*==============================================================*/
/* Table: Orders                                                */
/*==============================================================*/
create table Sales.Orders (
   OrderId              uniqueidentifier     not null,
   Code                 nvarchar(30)         not null,
   Name                 nvarchar(200)        not null,
   Version              timestamp            null,
   constraint PK_ORDERS primary key (OrderId)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Sales.Orders') and minor_id = 0)
begin 
   execute sp_dropextendedproperty 'MS_Description',  
   'schema', 'Sales', 'table', 'Orders' 
 
end 


execute sp_addextendedproperty 'MS_Description',  
   '订单', 
   'schema', 'Sales', 'table', 'Orders'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.Orders')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrderId')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'Orders', 'column', 'OrderId'

end


execute sp_addextendedproperty 'MS_Description', 
   '订单编号',
   'schema', 'Sales', 'table', 'Orders', 'column', 'OrderId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.Orders')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Code')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'Orders', 'column', 'Code'

end


execute sp_addextendedproperty 'MS_Description', 
   '订单编码',
   'schema', 'Sales', 'table', 'Orders', 'column', 'Code'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.Orders')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Name')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'Orders', 'column', 'Name'

end


execute sp_addextendedproperty 'MS_Description', 
   '订单名称',
   'schema', 'Sales', 'table', 'Orders', 'column', 'Name'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.Orders')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Version')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'Orders', 'column', 'Version'

end


execute sp_addextendedproperty 'MS_Description', 
   '版本号',
   'schema', 'Sales', 'table', 'Orders', 'column', 'Version'
go




if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Sales.OrderItems') and o.name = 'FK_ORDERITE_REFERENCE_PRODUCTS')
alter table Sales.OrderItems
   drop constraint FK_ORDERITE_REFERENCE_PRODUCTS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Sales.OrderItems') and o.name = 'FK_ORDERITE_REFERENCE_ORDERS')
alter table Sales.OrderItems
   drop constraint FK_ORDERITE_REFERENCE_ORDERS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Sales.OrderItems')
            and   type = 'U')
   drop table Sales.OrderItems
go

/*==============================================================*/
/* Table: OrderItems                                            */
/*==============================================================*/
create table Sales.OrderItems (
   OrderItemId          uniqueidentifier     not null,
   OrderId              uniqueidentifier     not null,
   ProductId            int                  not null,
   ProductName          nvarchar(200)        not null,
   Quantity             int                  not null,
   Price                decimal(10,2)        not null,
   constraint PK_ORDERITEMS primary key (OrderItemId)
)
go

if exists (select 1 from  sys.extended_properties
           where major_id = object_id('Sales.OrderItems') and minor_id = 0)
begin 
   execute sp_dropextendedproperty 'MS_Description',  
   'schema', 'Sales', 'table', 'OrderItems' 
 
end 


execute sp_addextendedproperty 'MS_Description',  
   '订单明细', 
   'schema', 'Sales', 'table', 'OrderItems'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.OrderItems')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrderItemId')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'OrderItemId'

end


execute sp_addextendedproperty 'MS_Description', 
   '订单明细编号',
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'OrderItemId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.OrderItems')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'OrderId')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'OrderId'

end


execute sp_addextendedproperty 'MS_Description', 
   '订单编号',
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'OrderId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.OrderItems')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ProductId')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'ProductId'

end


execute sp_addextendedproperty 'MS_Description', 
   '商品编号',
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'ProductId'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.OrderItems')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'ProductName')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'ProductName'

end


execute sp_addextendedproperty 'MS_Description', 
   '商品名称',
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'ProductName'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.OrderItems')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Quantity')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'Quantity'

end


execute sp_addextendedproperty 'MS_Description', 
   '数量',
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'Quantity'
go

if exists(select 1 from sys.extended_properties p where
      p.major_id = object_id('Sales.OrderItems')
  and p.minor_id = (select c.column_id from sys.columns c where c.object_id = p.major_id and c.name = 'Price')
)
begin
   execute sp_dropextendedproperty 'MS_Description', 
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'Price'

end


execute sp_addextendedproperty 'MS_Description', 
   '单价',
   'schema', 'Sales', 'table', 'OrderItems', 'column', 'Price'
go

alter table Sales.OrderItems
   add constraint FK_ORDERITE_REFERENCE_PRODUCTS foreign key (ProductId)
      references Productions.Products (ProductId)
go

alter table Sales.OrderItems
   add constraint FK_ORDERITE_REFERENCE_ORDERS foreign key (OrderId)
      references Sales.Orders (OrderId)
go
