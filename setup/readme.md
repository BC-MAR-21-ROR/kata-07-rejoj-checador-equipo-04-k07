# Technologies 
This project was made with **Ruby on Rails** framework and uses postgreSQL as DB.

## Dependences

Flexible authentication solution for Rails with Warden.

`gem 'devise'`

Plugin for generating administration style interfaces.

`gem 'activeadmin'`

Open source object-relational database system.

**postgreSQL**
 
# Installation
### **Need exec this commands for install this app**

**Install dependences with**
```bash
bundle install
yarn install
```
**Create database**
```bash
rails db:create
```
**Run Migrations**
```bash
rails db:migrate
```
**Seed database with data**
```bash
rails db:seed
```
It creates a default user in the database, so you can access with the following credentials:

`user: admin@example.com`

`password: password`

You can change the password or delete this user and create a new one.

If you wanto to save some time you can only run 'setup' command and the above commands create, migrate, and seed will be run.
```bash
rails db:setup
```

**Run the app**
```bash
rails s
```

## User Manual
You need go in this url [home](127.0.0.1:3000 "home")
![page of start](../img/inicio.png "page of start")

### Check in and Check out
write your code  for check in and check out 
![Pnel of check](../img/panel de check.png "Pnel of check")

### Login
For login  you need put user an password
![login](../img/login.png "login")

### Home
This is  a page of Home. In this page you whatch a menu in a nav var  with  options of navigate.

![Page of Home](../img/home.png "Page of Home")

### Absence Report
You can seach users for date or expor CSV

![absence report](../img/absence_report.png "seach absence report")

In this table you can see  the users

![table of absence report](../img/table_absence_report.png "table of absence report")

### Admin Users
In this page you see the admin users, the user show a  user in tablet and a menu of filter.
![admin users](../img/admin_users.png "admin users")
####  Add New User Admin
You can create a new  user with a email and password

![new admin users](../img/new_admin_users.png "new admin users")

###  Attendance Report
In this page you can see a attendance report and  for look with date and export CSV
![attendance report](../img/attendance_report.png "attendance report")

### Company Branches
In this page you can see that company branches and filter with menu of  search on right
![company branches](../img/company_branches.png "company branches")
#### New Company Branches
for add a new company branches,  you need a name and address
![new company branches](../img/new_company_branches.png "new company branches")

### employees
In this page you can see that employees and filter with menu of  search on right
![employees](../img/employees.png "employees")

In this page you can add a new Employee and you need emails, Employee number, Private number
![new employees](../img/new_employees.png "new employees")


this prollect is runing in heroku [Page](http://heroku  "Page")
