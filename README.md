# Student Attendance Management System

## 1. Prerequisites

Before running the project, the following software should be installed on your system:

- Visual Studio 2022 with ASP.NET and .NET Framework development support
- .NET Framework 4.7.2
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Git, along with basic knowledge of Git commands for managing version control and pushing the project to a GitHub repository


## 2. Setup Instructions

Follow these steps to download the project, configure the required software, and run the application on your local system.

### Step 1: Clone the Repository

Make sure Git is installed on your system. Open PowerShell or Command Prompt and check the installation:

```bash
git --version
```

Copy the repository's HTTPS URL from GitHub using **Code → HTTPS**, then run:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Replace `<YOUR_REPOSITORY_URL>` with your repository's HTTPS URL.

Navigate to the downloaded project folder:

```bash
cd <PROJECT_FOLDER>
```

Replace `<PROJECT_FOLDER>` with the name of the cloned folder.

Alternatively, select **Code → Download ZIP** on GitHub and extract the downloaded file.

### Step 2: Open the Project in Visual Studio

1. Open Visual Studio 2022.
2. Select **Open a project or solution**.
3. Browse to the downloaded project folder.
4. Open the solution file (`.slnx`).
5. Wait for Visual Studio to load the project.

### Step 3: Restore the Required Packages

1. Open the solution in Visual Studio.
2. Right-click the solution in Solution Explorer.
3. Select **Restore NuGet Packages**, if available.
4. Wait for the restoration to complete. Packages may also be restored automatically during the build.

### Step 4: Configure the SQL Server Database

The application uses SQL Server to store and retrieve data.

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Locate the SQL scripts provided in the repository.
4. Open and execute the scripts in the required order to create the database, tables, and initial data.
5. Verify that the required database objects and records have been created successfully.

**SQL Script Files:**

- `<Required_tables_creation.sql>` — Creates the required tables, if provided separately.
- `<Students_insertion.sql>` — Inserts initial or sample data, if provided separately.

### Step 5: Configure the Database Connection String

The application uses a connection string in `Web.config` to connect to SQL Server.

1. Locate the application's `Web.config` file.
2. Find the `<connectionStrings>` section.
3. Update the server name and database name according to your local SQL Server configuration.
4. Save the changes.

Example connection string using Windows Authentication:

```xml
<connectionStrings>
    <add name="StudentAttendanceConnection"
         connectionString="Server=YOUR_SERVER_NAME;Database=YOUR_DATABASE_NAME;Integrated Security=True;TrustServerCertificate=True;"
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

Replace `YOUR_SERVER_NAME` and `YOUR_DATABASE_NAME` with your actual values.

**Important:** The connection string name must match the name referenced in the application's C# code. If the repository contains a `Web.config.example` instead of `Web.config`, use it as a reference to create your local configuration file. Do not publish machine-specific connection details or credentials.

### Step 6: Build the Solution

1. In Visual Studio, select **Build → Build Solution** from the menu bar.
2. Wait for the build to finish.
3. Check the **Error List** window for compilation errors.
4. Resolve any errors before proceeding.

### Step 7: Set the Startup Project

1. In Solution Explorer, right-click the ASP.NET Web Forms project.
2. Select **Set as Startup Project**.

### Step 8: Run the Application

1. Ensure SQL Server is running and the database is configured correctly.
2. Click **Start** in Visual Studio or press **F5**.
3. The application should open in your default browser using Visual Studio's development server.
4. Log in using an account configured for the application.

If the application fails to run, check the Error List, Output window, and database connection settings.

### Step 9: Verify the Setup

After launching the application, verify that:

- The login page loads successfully.
- The application connects to the database.
- Student and department data can be retrieved.
- The available pages and functionality work as expected.

