# Assignment 2 - SOEN 387
<br />

## Team Members

Student Name | Student ID
------------ | ----------
Pierrick Catalo | 40087503
Israt Noor Kazi | 40029299
Mircea Chirca | 40004027

## Tools Used
* `IntelliJ IDEA`
* `Apache Tomcat`
* `Java 8 JDK`
* `MySQL Workbench` (optional)

## Pogramming Languages 
Backend: `Java` <br />
Frontend: `JSP` <br />
Database: `MySQL`<br />

## Setup Process
* Install all the tools mention above
* In your `MySQL Workbench`, import and run `create_database_and_tables.sql`
* Using your IDE, open project `soen_387_part_2`
* Setup Tomcat server
* Build and run the project

## For Demo
You can use the following details to log as a poll manager: <br/>
Username: `111111` <br/>
Password: `password`

### Troubleshooting

---
####  After downloading or cloning the project, it may not compile due to the following error(s):
**Error**: package com.pollmanager does not exist <br />
**Fix**: Import `PollBusinessLayer.jar` as a library in your project located at `PollWebsite/src/main/webapp/WEB-INF/lib/PollBusinessLayer.jar`.

####  Connection Problem with the Database:
**Note**: Make sure that the database username is `root` and the password field is empty.

