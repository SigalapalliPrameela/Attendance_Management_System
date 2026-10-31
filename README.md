# Student Attendance Management System

A web-based application developed using **ASP.NET Web Forms, C#, .NET Framework 4.7.2, and Microsoft SQL Server** to manage student attendance.

The application supports role-based access for administrators and teachers. The Admin manages the system and teacher registration requests, while approved teachers can access the attendance-related functionality permitted by their roles.

This README provides instructions for downloading the project, configuring the database, creating the initial Admin account, running the application.

---

## 1. Project Overview

The Student Attendance Management System is designed to simplify attendance management through a web application connected to a SQL Server database.

The application uses ASP.NET Web Forms for the user interface, C# for application logic, and SQL Server for storing and retrieving application data.

Access to application functionality depends on the user's role and, for teachers, their registration approval status.

### User Roles

**Admin**

- Manages the application's administrative functionality.
- Reviews teacher registration requests.
- Approves or rejects teacher registrations.
- Accesses the Admin-specific pages and functionality.

**Teacher**

- Registers through the teacher sign-up page.
- Must wait for Admin approval before accessing protected teacher functionality.
- Can log in after approval, provided the supplied credentials are valid.
- Can use the attendance-related functionality permitted by the application.

The application requires an initial Admin account before Admin-specific operations can be performed.

---

## 2. Key Features

The application includes the following functionality:

- User authentication through a login page.
- Role-based access control for Admin and Teacher users.
- Teacher registration.
- Admin approval or rejection of teacher registration requests.
- Restrictions on login for teachers whose registrations are pending or rejected.
- Student and department data management or retrieval, according to the implemented functionality.
- Attendance-related functionality for authorized users.
- SQL Server database integration.
- Session-based tracking of authenticated users.
- An initial Admin setup mechanism.


---
---

## 3.Prerequisites

Before setting up the application, make sure the following software is installed on your system.

| Software | Purpose |
|---|---|
| Visual Studio 2022 | To open, build, and run the ASP.NET Web Forms application |
| .NET Framework 4.7.2 | Target framework required by the application (Ensure that the required targeting or developer pack is installed if Visual Studio cannot build the project.
)|
| Microsoft SQL Server | To store the application data |
| SQL Server Management Studio (SSMS) | To view and manage the SQL Server database |
| Git | To clone the project repository |

### Required Visual Studio Components

While installing Visual Studio 2022, make sure that the required ASP.NET and .NET Framework development components are available.

### Before You Begin

Verify the following:

- SQL Server is installed and running.
- You can connect to your SQL Server instance using SSMS.
- You have permission to create or modify the application database.
- Visual Studio supports .NET Framework 4.7.2.
- Git is installed if you plan to clone the repository using Git.

> **Note:** The project uses Entity Framework 6 Code First Migrations to create and manage the database schema. Therefore, the database tables do not need to be created manually using SSMS.

---

## 4. Clone the Repository

You can obtain the project using either Git or GitHub's ZIP download option.

### Option A: Clone Using Git

**Step 1: Verify Git installation.**

Open PowerShell or Command Prompt and execute:

```bash
git --version
```

If Git is installed, the command displays its version.

**Step 2: Copy the repository URL.**

Open the project's GitHub repository and select:

`Code(Green Button) → HTTPS → Copy URL`

**Step 3: Clone the repository.**

Run the following command, replacing the placeholder with the copied repository URL:

```bash
git clone <COPIED_REPOSITORY_URL>
```

For example, the command format is:

```bash
git clone https://github.com/USERNAME/REPOSITORY.git
```

**Step 4: Enter the cloned folder.**

```bash
cd <CLONED_FOLDER_NAME>
```

Replace the placeholder with the folder name created by Git.

### Option B: Download as ZIP

1. Open the project's GitHub repository.
2. Select `Code → Download ZIP`.
3. Wait for the download to complete.
4. Extract the ZIP file to a convenient location.
5. Open the extracted project folder.

**Important:** Keep the entire project structure intact. Do not move individual `.aspx`, `.cs`, configuration, or project files into unrelated folders.

---

## 5. Open the Project in Visual Studio

1. Launch Visual Studio 2022.
2. Select **Open a project or solution**.
3. Browse to the downloaded or cloned project directory.
4. Locate the solution file, which uses the `.slnx` extension in this project.
5. Open the solution.
6. Wait for Visual Studio to load the project and its dependencies.

If Visual Studio reports that a required framework or development component is missing, install the required component before continuing using Visual Studio Installer.

### Locate the Web Application Project

In Solution Explorer, identify the ASP.NET Web Forms project.

You should be able to locate the application's pages, C# code-behind files, and configuration files.

Examples include:

- `Login.aspx`
- `AdminSetUp.aspx`
- `Web.config`

---
### Build the Project

After opening the solution:

1. From the Visual Studio menu, select **Build → Build Solution**.
2. Make sure the build completes successfully before continuing with the database configuration.

> **Note:** If any NuGet packages are missing, restore them before building the project.

---

## 6. Configure the Database Connection

The application uses **Microsoft SQL Server** as its database.

Before creating the database tables, update the connection string in the `Web.config` file according to your SQL Server instance.

### Step 1: Open `Web.config`

In Visual Studio, open the `Web.config` file located in the project.

Find the following section:

```xml
<connectionStrings>
  <add name="StudentAttendanceConnection"
       connectionString="Data Source=YOUR_SERVER_INSTANCE;Initial Catalog=YOUR_DATABASE_NAME;Integrated Security=True;TrustServerCertificate=True"
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

### Step 2: Update the SQL Server Instance Name

Replace `YOUR_SERVER_INSTANCE` and `YOUR_DATABASE_NAME` with the SQL Server instance name  and Database Name on your system.

For example:

```text
Data Source=DESKTOP_NAME\SQLEXPRESS
```

You can find your SQL Server instance name when connecting to SQL Server through **SQL Server Management Studio (SSMS)** at the left panel where you will see a Object Explorer and Database name by finding which database you are intended to use.

### Important

- Keep the connection string name as `StudentAttendanceConnection`.
- The project uses **Windows Authentication** through `Integrated Security=True`.
- Do not use another developer's server name directly. Each developer should use their own SQL Server instance name.

### Step 3: Understand the Connection String

| Setting | Purpose |
|---|---|
| `Server` | Specifies the SQL Server instance. |
| `Database` | Specifies the database used by the application. |
| `Integrated Security=True` | Uses Windows Authentication for the database connection. |
| `TrustServerCertificate=True` | Trusts the server certificate without validating its certificate chain. |
| `providerName` | Specifies the .NET SQL Server data provider. |

When using Windows Authentication, the Windows identity under which the application connects must have the required database permissions.

### Important Configuration Notes

- The connection string name must remain `StudentAttendanceConnection` unless the corresponding C# code is updated.
- Use the correct database name and SQL Server instance.
- Do not create a second `<connectionStrings>` section if one already exists.
- The repository provides a `Web.config.example` rather than a complete local `Web.config`, use the example as a reference and create the required local configuration.
- Do not commit personal machine configuration, passwords, or other secrets to GitHub.

---

---

## 7. Create the Database Using Entity Framework Migrations

The database schema for this project is managed using **Entity Framework 6 Code First Migrations**.
If Entity Framework package is not installed then **GoTo Tools → Nuget Package Manager → Manage Nuget Package for Solution → Then Browse "EntityFramework"(make sure that it is EF6 not EFCore)**

The project already contains the model classes, `AttendanceDbContext`, and migration files required to create the database tables.

### Step 1: Open the Package Manager Console

In Visual Studio, go to:

**Tools → NuGet Package Manager → Package Manager Console**

### Step 2: Select the Correct Project

Make sure the **Default Project** in the Package Manager Console is set to the Attendance Management System project.

### Step 3: Create or Update the Database

Run the following command:

```powershell
Update-Database
```
### Expected Output

After running the command successfully, you will see output similar to:

```text
PM> Update-Database
Applying explicit migrations...
Running Seed method.
```

This indicates that Entity Framework has successfully applied the migrations and executed the Seed method.

Entity Framework will use the existing migrations in the project to create the database schema.

The following tables will be created:

- `Users`
- `Departments`
- `Students`
- `Attendance`

### Verify the Database

After the command completes successfully:

1. Open **SQL Server Management Studio (SSMS)**.
2. Connect to your SQL Server instance.
3. Locate  `Your_Database` database.
4. Expand **Tables** to verify that the application tables were created successfully.

> **Important:** Do not manually create these tables using SQL scripts. The database schema is managed through Entity Framework Code First Migrations.

## 8. Verify Sample Data

The project already includes sample data in the database configuration. When you run:

```powershell
Update-Database
```
Expand:

```text
Databases
└── StudentAttendanceDB
    └── Tables
```
You will see the Data in Students and Departments Tables.

## 9. Run the Application and Set Up the Admin Account

After completing the database setup, run the application in Visual Studio.

1. Open the project in **Visual Studio**.
2. Right-Click On AdminSetUp.aspx and Select **Set As Start Page**
3. Press **`Ctrl + F5`** or click **Start** to run the application.
4. The application will open in your web browser.

### Set Up the Default Admin Account

The application requires one default Admin account.

1. Navigate to the **Admin Setup** page.
2. Enter the required Admin details.
3. Create the Admin account.


> **Note:** The Admin Setup page is intended for initial setup only. Once an Admin account has been created, additional Admin accounts cannot be created through this page.So keep the pin and credentials private and make sure you remember them.

After creating the Admin account, you can log in using the Admin credentials and access the Admin Dashboard.

### Step 4: Sign In

1. Open the login page.
2. Enter the credentials configured during initial Admin creation.
3. Sign in.
4. Verify that the Admin-specific functionality is accessible.

### Important Notes

- An Admin account is stored in the configured database, not automatically created merely by cloning the repository.
- If the database already contains an Admin, the setup page may disable the creation operation.
- The setup mechanism is intended for initial configuration, not routine creation of additional Admin accounts.
- The setup page's local-request restriction should not be treated as sufficient protection for a production deployment.
- Before deploying the application to a shared server, review the initial Admin provisioning process and ensure that unauthorized users cannot create or replace an Admin account.
- Never publish your real Admin PIN or password in this README.

---

## 10. Register and Approve Teachers

Once the initial Admin account has been created, the teacher registration workflow can be tested.

### Step 1: Register a Teacher

1. Open the application's sign-up page.
2. Enter the required registration information.
3. Submit the form.
4. Confirm that the registration request is recorded successfully.

### Step 2: Wait for Admin Approval

A newly registered teacher may have a pending status until the Admin reviews the request.

A pending teacher should not be able to access protected teacher functionality.

### Step 3: Approve or Reject the Request

1. Sign in using the Admin account.
2. Open the relevant teacher-management or approval page.
3. Review the registration request.
4. Approve or reject the request using the available functionality.

### Step 4: Test Teacher Login

For an approved teacher:

1. Return to the login page.
2. Enter the teacher's credentials.
3. Verify that login succeeds.
4. Confirm that the teacher can access the pages permitted by their role.

For a pending or rejected teacher, verify that the application denies access as intended.

After completing these steps, the application is ready to use.
---
### Navigation Flow

The basic application flow is:

```text
Admin Setup
    ↓
Admin Login
    ↓
Admin Dashboard
    ↓
Review and Approve Teachers

Teacher Signup
    ↓
Pending Approval
    ↓
Admin Approval
    ↓
Teacher Login
    ↓
Teacher Dashboard
    ↓
View Students
    ↓
Mark Attendance
```

## 11. Verify the Installation

After completing the setup, verify the following:

-  The application builds without errors.
-  The database connection works correctly.
-  The login page opens successfully.
-  The initial Admin account can log in.
-  The Admin dashboard opens after login.
-  Teacher registration works.
-  Admin can approve or reject teacher registrations.
-  Teacher access follows the approval status.
-  Unauthorized users cannot access protected pages.

---


