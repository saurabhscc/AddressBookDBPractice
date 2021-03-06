/* UC1-Creating the database for address book services*/
create database addressBook_services

/* UC2 Create table for the perform the CRUD operations */
use addressBook_services
 create table addressBook_Table
(firstName varchar(50) not null,
 lastName varchar(50) not null,
 address varchar(50) not null,
 city varchar(50) not null,
 state varchar(50) not null,
 zip bigint not null,
 phoneNumber bigint not null,
 emailId varchar(50) not null);
 select * from addressBook_Table;

  /* UC3-Inserting data into the table*/
  Insert into addressBook_Table (firstName, lastName, address, city, state, zip, phoneNumber, emailId)
 values
 ('DJ', 'Arjun', 'Ramtek', 'Mumbai', 'MH', '111111', '1111111110', 'dj@gmail.com'),
 ('Raj', 'Sharma', 'Vasantkunj', 'Delhi', 'Delhi', '222222',' 2222222220', 'Raj@gmail.com'),
 ('Shubham', 'Sawant', 'Pahadganj', 'Kanpur', 'UP', '333333', '3333333330', 'shubham@gmail.com'),
 ('Raj', 'Kumar', 'Ramnagar', 'Hisar', 'Haryana', '444444', '4444444440', 'rajk@gmail.com');

 select * from addressBook_Table

 /*UC4- Updating the row contact detail from the address book table finding by the contact name  */

  Update addressBook_Table set address ='Yashwardhan' 
 where firstName = 'DJ' and lastName = 'Arjun';
 
   /* UC5- Delete the row entry from the address book table where name matches */

 select * from addressBook_Table
 delete from addressBook_Table where firstName ='Raj' and lastName = 'Kumar'

 /* UC6- Display the contact from the address book table matching the city OR state*/

 select * from addressBook_Table
  where state = 'UP' or city = 'Mumbai';

   /* UC7- Display the count of contacts by city and state*/

 select city,count (*) as 'Number of Contacts'
 from addressBook_Table 
 group by city
 select state,count (*) as 'Number of Contacts'
  from addressBook_Table 
  group by state

   /* UC8- Sorting alphabetically in ascending order by the name and belonging to a city say Mumbai*/
   select * from addressBook_Table
  /*insert more data*/
  Insert into addressBook_Table (firstName, lastName, address, city, state, zip, phoneNumber, emailId)
 values
 ('RJ', 'Arun', 'Worli', 'Mumbai', 'MH', '100111', '1111111100', 'rj@gmail.com'),
 ('Raj', 'shamani', 'Bandra', 'Mumbai', 'MH', '111110',' 2222222200', 'rs@gmail.com'),
 ('Vivek', 'Agrawal', 'Ghatkopar', 'Mumbai', 'MH', '111100', '3333333300', 'vivek@gmail.com'),
 ('Vinit', 'Kumar', 'Varsoa', 'Mumbai', 'MH', '111000', '4444444400', 'vinit@gmail.com');
  select * from addressBook_Table
 where city = 'Mumbai'
 order by firstName

  /*UC9- Adding the columns for address book name and type of address book in addressbook table */
  select * from addressBook_Table

 alter table addressBook_Table
 add addressBookType varchar(30), addressBookName varchar(40);
 /* Update the address book to add records in the recent added fields*/
 update addressBook_Table set addressBookType = 'Friends' where city ='Mumbai';
  /* Update the address book to add records in the recent added fields*/
 update addressBook_Table set addressBookName = 'SaurabhRecords';
 /* Update the address book to add records in the recent added fields*/
 update addressBook_Table set addressBookType = 'Family' where lastName ='Sawant';
 /* Update the address book to add records in the recent added fields*/
 update addressBook_Table set addressBookType = 'Profession' where addressBookType is null

 /* UC10-Getting the contact count grouping by the contact type */
 select * from addressBook_Table
  /* Renaming the addressBookType columns to contactType in the address book table */
 EXEC sp_rename 'addressBook_Table.addressBookType', 'contactType', 'COLUMN';
 /* Getting the contact count grouping by the contact type */
 select contactType, COUNT(*) as 'Number Of Contacts'
from addressBook_Table group by contactType;

/*UC11-Add Contact Name For MUltiple Contact Type */
/* Adding a contact to multiple contact Type require duplication of contact
if we do not use Normalcy or Entity-Relationship Concept leading to data redundancy */

select * from addressBook_Table
insert into addressBook_Table (firstName, lastName, address, city, state, phoneNumber, zip, emailId, contactType, addressBookName)
values
('RJ', 'Arun', 'Worli', 'Mumbai', 'MH','1111111100', '100111',  'rj@gmail.com', 'Family', 'SaurabhRecords');
/* Displaying the data redundancy through a query */
 select * from addressBook_Table
 where firstName ='RJ' and lastName = 'Arun';

 use addressBook_services
 /* Create Mentor table with primary id */
CREATE TABLE contacts(
Id int identity(1,1) primary key,
firstName varchar(50) not null,
lastName varchar(50) not null,
zip bigint not null,
phoneNumber bigint not null,
emailId varchar(50) not null,        
)
/* Create addressDetail table with foreign id */
CREATE TABLE addressDetail(
Id int identity(1,1) primary key,
address varchar(50) not null,
city varchar(50) not null,
state varchar(50) not null,
contactsId int FOREIGN KEY REFERENCES contacts(Id)
)
/* Create addressBook table with foreign id */
 CREATE TABLE addressBook(
 Id int identity(1,1) primary key, 
 addressBookName varchar(40),
 contactsId int FOREIGN KEY REFERENCES contacts(Id)
 )
/* Create contactType table with foreign id */
CREATE TABLE contactType(
 Id int identity(1,1) primary key, 
 contactType varchar(30),
 contactsId int FOREIGN KEY REFERENCES contacts(Id)
 )                                
