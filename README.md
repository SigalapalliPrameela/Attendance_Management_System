# Student Attendance Management System

A web-based application developed using **ASP.NET Web Forms, C#, .NET Framework 4.7.2, and Microsoft SQL Server** to manage student attendance.

The application supports role-based access for administrators and teachers. The Admin manages the system and teacher registration requests, while approved teachers can access the attendance-related functionality permitted by their roles.

This README provides instructions for downloading the project, configuring the database, creating the initial Admin account, running the application, and troubleshooting common setup problems.

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

> **Note:** The exact functionality available to each role depends on the implementation in the source code.

---

## 3. Technology Stack

| Technology | Purpose |
|---|---|
| ASP.NET Web Forms | Builds the web interface. |
| C# | Implements application logic and event handling. |
| .NET Framework 4.7.2 | Provides the application runtime and framework libraries. |
| Microsoft SQL Server | Stores application data. |
| SQL Server Management Studio (SSMS) | Creates, queries, and manages the database. |
| Visual Studio 2022 | Opens, builds, debugs, and runs the project. |
| Git and GitHub | Manage and host the source code. |

---

## 4. Application Workflow

### 4.1 Initial Admin Setup

When the application is installed on a new machine, its database might not contain an Admin account.

The initial Admin must therefore be created before Admin-specific features can be used.

The project includes an `AdminSetUp.aspx` page intended for this initial setup.

The setup process is:

1. Configure the database.
2. Configure the application's database connection string.
3. Run the application locally.
4. Open the Admin setup page.
5. Enter the required Admin details.
6. Create the initial Admin account.
7. Navigate to the login page and sign in.

The setup page checks whether an Admin already exists and restricts the setup operation to local requests. Follow the instructions in Section 12 before attempting to create the initial Admin.

### 4.2 Teacher Registration and Approval

The teacher workflow is:

1. A teacher opens the sign-up page.
2. The teacher enters the required registration details.
3. The application records the registration request.
4. The teacher waits for the Admin to review the request.
5. The Admin approves or rejects the registration.
6. An approved teacher can log in using valid credentials.
7. A teacher whose registration is pending or rejected cannot access protected teacher functionality.

The application should enforce these restrictions on the server, not merely hide buttons or display messages in the interface.

### 4.3 Login and Role-Based Access

After successful authentication, the application maintains session information for the logged-in user.

The user's role determines which protected pages and operations they are authorized to access.

For example, a Teacher must not be able to access an Admin-only page simply by entering its URL in the browser.

---

## 5. Prerequisites

Install the following software before setting up the project.

### Required Software

**1. Visual Studio 2022**

Install Visual Studio with the appropriate ASP.NET and web development support.

Ensure that the required .NET Framework development components are available.

**2. .NET Framework 4.7.2**

The application targets .NET Framework 4.7.2.

Ensure that the required targeting or developer pack is installed if Visual Studio cannot build the project.

**3. Microsoft SQL Server**

Install and configure a SQL Server instance.

The project needs a database in which its tables and application data can be stored.

**4. SQL Server Management Studio (SSMS)**

Use SSMS to connect to SQL Server, execute the supplied SQL scripts, and verify database objects.

**5. Git (optional if downloading the ZIP)**

Git is required if you intend to clone the repository using the command line.

Alternatively, you can download the repository as a ZIP file from GitHub.

### Before Proceeding

Make sure that:

- SQL Server is installed and running.
- You know the name of your SQL Server instance.
- You can connect to that instance using SSMS.
- You have permission to create or use the application database.
- The project files are available locally.

---

## 6. Clone the Repository

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

`Code → HTTPS → Copy URL`

**Step 3: Clone the repository.**

Run the following command, replacing the placeholder with the copied repository URL:

```bash
git clone <YOUR_REPOSITORY_URL>
```

For example, the command format is:

```bash
git clone https://github.com/USERNAME/REPOSITORY.git
```

The example above is a placeholder format. Use the actual URL of this project.

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

## 7. Open the Project in Visual Studio

1. Launch Visual Studio 2022.
2. Select **Open a project or solution**.
3. Browse to the downloaded or cloned project directory.
4. Locate the solution file, which uses the `.slnx` extension in this project.
5. Open the solution.
6. Wait for Visual Studio to load the project and its dependencies.

If Visual Studio reports that a required framework or development component is missing, install the required component before continuing.

### Locate the Web Application Project

In Solution Explorer, identify the ASP.NET Web Forms project.

You should be able to locate the application's pages, C# code-behind files, and configuration files.

Examples include:

- `Login.aspx`
- `AdminSetUp.aspx`
- `Web.config`

The exact contents of the project depend on the repository version.

---

## 8. Configure the Database

The application uses Microsoft SQL Server to store and retrieve data.

The repository contains a `Sql_Code` folder for database scripts.

### Step 1: Open SSMS

1. Launch SQL Server Management Studio.
2. Connect to your SQL Server instance.
3. Select the appropriate authentication method.
4. Verify that the connection succeeds.

### Step 2: Locate the SQL Scripts

Open the `Sql_Code` folder in the cloned repository.

The following filenames were documented for this project:

- `Required_tables_creation.sql`
- `Students_insertion.sql`

Check the actual contents of the folder because the scripts available in the current repository determine the exact setup procedure.

### Step 3: Execute the Scripts

1. Open the relevant SQL script in SSMS.
2. Review the database name and other configuration statements.
3. Confirm that the script targets the intended database.
4. Execute the scripts in the order required by their contents.
5. Review the Messages and Results tabs for errors.

The table-creation script should be executed before a data-insertion script that depends on those tables.

If a separate database-creation script exists, execute it first.

**Important:** Do not assume that executing a table-creation script automatically creates the database. Check the script to determine whether it creates the database itself or expects an existing database.

### Step 4: Verify the Database

In SSMS:

1. Expand the Databases node.
2. Locate the database used by the application.
3. Expand its Tables node.
4. Verify that the required tables exist.
5. Check that the expected initial student and department data are present, if the supplied scripts include that data.

If the scripts use a database name different from the one in your connection string, reconcile the names before running the application.

---

## 9. Configure the Connection String

The application connects to SQL Server using a connection string in `Web.config`.

The connection string name expected by the application is:

`StudentAttendanceConnection`

### Step 1: Locate Web.config

Find the `Web.config` file belonging to the ASP.NET Web Forms application project.

Do not confuse it with a configuration file belonging to another project or folder.

### Step 2: Update the Connection String

A connection string using Windows Authentication has the following format:

```xml
<connectionStrings>
    <add name="StudentAttendanceConnection"
         connectionString="Server=YOUR_SERVER_NAME;Database=YOUR_DATABASE_NAME;Integrated Security=True;TrustServerCertificate=True;"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

Replace:

- `YOUR_SERVER_NAME` with your actual SQL Server instance name.
- `YOUR_DATABASE_NAME` with the actual application database name.

For example, a named SQL Server Express instance may use a server name in the format:

`YOUR_COMPUTER_NAME\SQLEXPRESS`

This is only an example. Use the server or instance name that works in your own SSMS connection.

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
- If the repository provides a `Web.config.example` rather than a complete local `Web.config`, use the example as a reference and create the required local configuration.
- Do not commit personal machine configuration, passwords, or other secrets to GitHub.

---

## 10. Restore Packages and Build the Project

### Step 1: Restore NuGet Packages

In Visual Studio:

1. Open the solution.
2. If available, right-click the solution in Solution Explorer.
3. Select **Restore NuGet Packages**.
4. Wait for package restoration to complete.

Depending on the project's configuration, packages may also be restored automatically during the build.

If package restoration fails, verify your internet connection, NuGet configuration, and the package sources required by the project.

### Step 2: Build the Solution

1. Select **Build → Build Solution**.
2. Wait for the build to finish.
3. Open the Error List window.
4. Resolve any build errors before proceeding.

Warnings and errors are different. Review the details rather than assuming every warning prevents the application from running.

### Step 3: Set the Startup Project

In Solution Explorer:

1. Locate the ASP.NET Web Forms project.
2. Right-click it.
3. Select **Set as Startup Project**, if it is not already the startup project.

---

## 11. Run the Application

1. Ensure that SQL Server is running.
2. Confirm that the database and connection string are configured correctly.
3. Ensure that the solution builds successfully.
4. Set the ASP.NET Web Forms project as the startup project.
5. Click **Start** in Visual Studio or press `F5`.
6. Wait for the application to open in your browser.

Visual Studio normally runs the application using its configured development web server.

The first page displayed depends on the project's startup configuration.

If the application opens the login page, proceed to the initial Admin setup instructions below if no Admin account exists.

**Do not assume that a new database already contains an Admin account.** Follow Section 12 to initialize the application.

---

## 12. Create the Initial Admin Account

This step is required when the configured database does not already contain an Admin account.

The project includes an `AdminSetUp.aspx` page for initial Admin creation.

### Step 1: Run the Application Locally

Start the application from Visual Studio using `F5`.

The initial Admin setup operation is restricted to local requests in the application, so perform this step while running the application locally.

### Step 2: Open the Admin Setup Page

Navigate to the Admin setup page using the application's local base URL.

For example, if the application is running at:

`https://localhost:PORT/`

the setup page would typically be reached at:

`https://localhost:PORT/AdminSetUp.aspx`

Replace `PORT` with the actual port displayed in your browser.

If the application uses a virtual directory or a different URL structure, adjust the path accordingly.

### Step 3: Create the Admin

1. Open the setup page.
2. Enter the required Admin details.
3. Provide the PIN or other credentials requested by the form.
4. Submit the form.
5. Confirm that the application reports successful creation.

Use credentials that you can remember and keep them private.

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

## 13. Register and Approve Teachers

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

The exact status messages and available actions depend on the current implementation.

---

## 14. Verify the Installation

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


