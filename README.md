 Student Attendance Management System

1. Prerequisites
Before running the project, the following software should be installed on our system:
Visual Studio 2022 with ASP.NET and .NET Framework development support.
.NET Framework 4.7.2.
Microsoft SQL Server.
SQL Server Management Studio (SSMS).
Git, along with basic knowledge of Git commands for managing version control and pushing the project to a GitHub repository.
2. Setup Instructions
Open VS Community to start our project.
Create a new project using the ASP.NET Web Application (.NET Framework) template and select Web Forms as the project type.
Name it with a relevant project name and click Create.(So that our project opens)
Now create required pages UI(.aspx) files and their corresponding  backend C# code (.aspx.cs) files by naming them with understandable file names.
Open SSMS and create required tables for the application and add Student Data which we will use afterwards to retrieve from the database.
Configure the database connection string in the application's Web.config file. This allows the application to connect to the appropriate SQL Server instance and database.
After completing each page or making code changes, select Build → Build Solution from the Visual Studio menu bar to check for compilation errors and ensure that the project builds successfully.
Set the web application as the startup project so that it can be run from Visual Studio.
After completing the setup, run the application using the Start button or press F5 to verify that it works as expected.
3. Database Configuration
The application uses Microsoft SQL Server to store student details, department information, user accounts, and attendance records.
Open SQL Server Management Studio and connect to your SQL Server instance.
Create the database required by the application.
Execute the database creation and table creation queries used by the project.
Open the application's Web.config file and update the connection string with your SQL Server instance name and database name.
Save the changes and verify that the application can connect to the database.
Example connection string using Windows Authentication:
Server=SERVER_NAME;Database=DATABASE_NAME;Integrated Security=True;TrustServerCertificate=True;
Replacing SERVER_NAME and DATABASE_NAME with the values configured on our system.
4. Steps to Run the Application
Open the project solution in VS Community.
Make sure SQL Server is running and the database connection string is correct.
Build the solution using Build → Build Solution.
Set the web application project as the startup project.
Press F5 or click Start in Visual Studio.
The application will open in the browser using the Visual Studio development server.
Log in using the appropriate account configured for the application.
