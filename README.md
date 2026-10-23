# Student Attendance Management System

A web-based application developed using ASP.NET Web Forms, C#, .NET Framework 4.7.2, and Microsoft SQL Server to manage student attendance efficiently.

The system supports role-based access for administrators and teachers. Administrators manage the system and teacher registration requests, while approved teachers can access attendance-related features based on their authorized roles.

This README provides setup instructions, database configuration steps, initial admin creation, application run instructions, and troubleshooting guidance.

## Table of Contents

- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Technology Stack](#technology-stack)
- [Application Workflow](#application-workflow)
- [Prerequisites](#prerequisites)
- [Clone the Repository](#clone-the-repository)
- [Open the Project in Visual Studio](#open-the-project-in-visual-studio)
- [Configure the Database](#configure-the-database)
- [Configure the Connection String](#configure-the-connection-string)
- [Restore Packages and Build the Project](#restore-packages-and-build-the-project)
- [Run the Application](#run-the-application)
- [Create the Initial Admin Account](#create-the-initial-admin-account)
- [Register and Approve Teachers](#register-and-approve-teachers)

---

## 1. Project Overview

The Student Attendance Management System is designed to simplify attendance management through a web application connected to a SQL Server database.

It uses:
- ASP.NET Web Forms for the user interface
- C# for application logic
- SQL Server for storing and retrieving data
- Role-based access control for administrators and teachers

### User Roles

#### Admin
- Manages application administration
- Reviews teacher registration requests
- Approves or rejects teachers
- Accesses admin-only pages and operations

#### Teacher
- Registers through the teacher sign-up page
- Waits for admin approval
- Can log in only after approval
- Accesses attendance-related features only when authorized

The application requires an initial admin account before admin-related operations can be used.

---

## 2. Key Features

The project includes the following functionality:

- User authentication via login page
- Role-based access control for Admin and Teacher users
- Teacher registration system
- Admin approval/rejection of teacher requests
- Restriction of login for pending or rejected teachers
- Student and department data management
- Attendance tracking for authorized users
- SQL Server database integration
- Session-based tracking of authenticated users
- Initial admin setup process

> Note: The exact functionality depends on the implementation in the source code.

---

## 3. Technology Stack

| Technology | Purpose |
|-----------|---------|
| ASP.NET Web Forms | Builds the web interface |
| C# | Implements application logic and event handling |
| .NET Framework 4.7.2 | Provides the application runtime and libraries |
| Microsoft SQL Server | Stores application data |
| SQL Server Management Studio (SSMS) | Creates, queries, and manages the database |
| Visual Studio 2022 | Opens, builds, debugs, and runs the project |
| Git and GitHub | Manage and host the source code |

---

## 4. Application Workflow

### 4.1 Initial Admin Setup

When the application is installed on a new machine, the database may not contain an admin account.  
The initial admin must therefore be created before admin features can be used.

The setup process is:

1. Configure the database
2. Configure the application connection string
3. Run the application locally
4. Open the Admin setup page
5. Enter required admin details
6. Create the initial admin account
7. Sign in to the system

> The admin setup page checks whether an admin already exists and restricts the operation to local requests.

### 4.2 Teacher Registration and Approval

The teacher workflow is:

1. A teacher opens the sign-up page
2. The teacher enters registration details
3. The application records the request
4. The administrator reviews the request
5. The admin approves or rejects the request
6. An approved teacher can log in using valid credentials
7. A pending or rejected teacher cannot access protected teacher functionality

### 4.3 Login and Role-Based Access

After successful authentication, the system maintains session information for the logged-in user.

The user's role determines which pages and operations they are authorized to access.  
For example, a teacher must not be able to access an admin-only page by manually entering the URL.

---

## 5. Prerequisites

Install the following software before setting up the project:

### Required Software

1. Visual Studio 2022  
   Install Visual Studio with ASP.NET and web development support.

2. .NET Framework 4.7.2  
   Ensure the required .NET Framework development components are installed.

3. Microsoft SQL Server  
   Install and configure a SQL Server instance.

4. SQL Server Management Studio (SSMS)  
   Use SSMS to connect to SQL Server, execute scripts, and verify database objects.

5. Git (optional if downloading the ZIP)  
   Required if you plan to clone the repository using the command line.

### Before Proceeding

Make sure that:
- SQL Server is installed and running
- You know the SQL Server instance name
- You can connect to the instance using SSMS
- You have permission to create or use the application database
- The project files are available locally

---

## 6. Clone the Repository

You can obtain the project using either Git or GitHub’s ZIP download option.

### Option A: Clone Using Git

#### Step 1: Verify Git Installation
Open PowerShell or Command Prompt and run:

```bash
git --version
