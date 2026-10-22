# Student Attendance Management System

## 1. Prerequisites

Before running the project, the following software should be installed on your system:

- Visual Studio 2022 with ASP.NET and .NET Framework development support
- .NET Framework 4.7.2
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Git, along with basic knowledge of Git commands for managing version control and pushing the project to a GitHub repository

## 2. Setup Instructions

1. Open Visual Studio Community to start the project.
2. Create a new project using the ASP.NET Web Application (.NET Framework) template and select Web Forms as the project type.
3. Name the project appropriately and click Create so that the project opens.
4. Create the required pages (`.aspx`) and their corresponding backend C# files (`.aspx.cs`) using clear and understandable names.
5. Open SSMS and create the required tables for the application, then add the student data that will be used later for retrieval from the database.
6. Configure the database connection string in the application's `Web.config` file. This allows the application to connect to the appropriate SQL Server instance and database.
7. After completing each page or making code changes, select Build → Build Solution from the Visual Studio menu bar to check for compilation errors and ensure the project builds successfully.
8. Set the web application as the startup project so it can be run from Visual Studio.
9. After completing the setup, run the application using the Start button or press F5 to verify that it works as expected.

## 3. Database Configuration

The application uses Microsoft SQL Server to store student details, department information, user accounts, and attendance records.

1. Open SQL Server Management Studio and connect to your SQL Server instance.
2. Create the database required by the application.
3. Execute the database creation and table creation queries used by the project.
4. Open the application's `Web.config` file and update the connection string with your SQL Server instance name and database name.
5. Save the changes and verify that the application can connect to the database.

Example connection string using Windows Authentication:

```config
Server=SERVER_NAME;Database=DATABASE_NAME;Integrated Security=True;TrustServerCertificate=True;
```

Replace `SERVER_NAME` and `DATABASE_NAME` with the values configured on your system.

## 4. Steps to Run the Application

1. Open the project solution in Visual Studio Community.
2. Make sure SQL Server is running and the database connection string is correct.
3. Build the solution using Build → Build Solution.
4. Set the web application project as the startup project.
5. Press F5 or click Start in Visual Studio.
6. The application will open in the browser using the Visual Studio development server.
7. Log in using the appropriate account configured for the application.
