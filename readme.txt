YouTube:
https://youtu.be/k0coFkRWeVU

GitHub:
git@github.com:gjetson/RocketDeliveryBackend.git

- What is SQL?
SQL stands for structured query language. It was devised in the 70's and is a rather primitive 
language which allows interaction with a relational database. It was adopted by Oracle early on 
and because of their dominance in the relational database market became the defacto standard. 
ANSI SQL remains the standard for querying a relational database to this day. 

- What is the main difference between SQLite and MySQL?
MySQL is a database server. It is a separate server app which is setup remotely. Apps interact with 
it via a known URL. SqLite is an embedded, serverless design. It runs in the same application space 
as the app which uses it.

- What are Primary and Foreign Key? Give an example for each.
A primary key is a column or a set of columns that uniquely distinguishes every row in a database table.
It must be unique and therefore cannot be null.

A foreign key is generally used to build a relationship between the two tables. It references the primary
key in the local table. It's purpose is to preserve the integrity between two separate instances of an entity.

- What are the different relationship types that can be found in a relational database? 
Give an example for each type.

>> one-to-one:
This is a relationship where each entity in one table is associated with exactly one entity in the linked table.
For this to work the foreign key in the linked table is also the primary key for that table. That way it is 
impossible to corrupt the data integrity. 

In our schema example, a one-to-one relationship is depicted between Users and Employees. But this relationship 
would have to be enforced by business logic since the Employee foreign key linked to Users is NOT the primary key 
for Employees so it will not be enforced by the database schema.


>> one-to-many:
In this relationship each entity in the table containing the primary key can be linked to many entities in the 
linked table containing the foreign key. This is a very common relationship to model.

In our schema Addresses has a one to many relationship with Employees. There are many similar examples in our schema.


>> many-to-many:
In this relationship there are many entities in one table linked to many entities in another table. The link is 
most commonly through a relationship with a third table. This third table serves as a "lookup table" which contains 
the foreign keys for the previously mentioned tables having the many-to-many relationship. By querying this lookup 
table you can join on the the related tables via the foreign keys and produce the many-to-many results.

In our schema example, there is a many-to-many relationship between Products and Orders as they relate to the 
Product_Orders table. By querying the Product_Orders table based on some criteria, you could join on the Products and 
Orders tables via their foreign key relationships and produce the manay-to-many data the satisfies the query criteria.
