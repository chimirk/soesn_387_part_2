# Assignment 3 - SOEN 387
<br />

## Team Members

Student Name | Student ID
------------ | ----------
Pierrick Catalo | 40087503
Israt Noor Kazi | 40029299
Mircea Chirca | 40004027

## Application Description
<!-- Our poll system is an application that allows logged users to take the role of poll manager and create, run, release, close or delete a poll. A poll manager can manage only their polls. Users do not need to log in to vote. If the user votes for the first time and does not have a pin, the application will automatically create one for them. To vote as a new voter for a poll, the user enters the poll id. If the voter wishes to update their vote, they must enter the poll id with their PIN voter for that poll. Once a poll is closed, it can only be viewed by the owner. In addition, the application allows user management operations such as new user registration, resetting the password in case the old password was forgotten and changing the password right from poll manager screen. For security purposes, users that registered for their first time as well as users who forgotten their passwords will perform a two-step verification process. In particular, an email containing a verification link will be send to these users. In case the user never accesses the verification link, their account will be temporarily disabled. -->
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
Register as a new user. A verification link will be send to the email provided during registration.
Click the link and finish registration. Now you are able to access the poll system as a poll manager. 

### Troubleshooting

---
####  After downloading or cloning the project, it may not compile due to the following error(s):
**Error**: package com.pollmanager does not exist <br />
**Fix**: Import `business_layer_part2.jar` as a library in your project located at `PollWebsite/src/main/webapp/WEB-INF/lib/business_layer_part2.jar`.

####  Connection Problem with the Database:
**Note**: Make sure that the database username is `root` and the password field is empty.

