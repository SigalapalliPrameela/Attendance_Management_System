<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherDashboard.aspx.cs" Inherits="Attendance_Management_System.TeacherDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Teacher Dashboard | AMS</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 30px 18px;
            background-color: #f4f6f9;
            color: #263445;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .teacher-dashboard {
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
        }

        .dashboard-header {
            margin-bottom: 26px;
            padding: 30px 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
        }

        .dashboard-header h1 {
            margin: 0 0 8px;
            color: #1f3b5b;
            font-size: 28px;
            font-weight: 650;
            line-height: 1.4;
        }

        .dashboard-header p {
            margin: 0;
            color: #667386;
            font-size: 14px;
            line-height: 1.6;
        }

        .welcome-card {
            margin-bottom: 24px;
            padding: 24px 28px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(25, 42, 70, 0.04);
        }

        .welcome-message {
            display: block;
            margin-bottom: 10px;
            color: #263445;
            font-size: 20px;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        .dashboard-date {
            display: block;
            margin-bottom: 10px;
            color: #667386;
            font-size: 14px;
        }

        .dashboard-role {
            display: inline-block;
            padding: 5px 11px;
            background-color: #edf2f7;
            border: 1px solid #d7e0e9;
            border-radius: 5px;
            color: #315f91;
            font-size: 12px;
            font-weight: 600;
        }

        .activities-section {
            padding: 28px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(25, 42, 70, 0.04);
        }

        .activities-section h2 {
            margin: 0 0 8px;
            color: #1f3b5b;
            font-size: 21px;
            font-weight: 600;
        }

        .section-description {
            margin: 0 0 22px;
            color: #667386;
            font-size: 14px;
            line-height: 1.6;
        }

        .activity-card {
            padding: 22px;
            background-color: #f8fafc;
            border: 1px solid #e1e6ed;
            border-radius: 8px;
        }

        .activity-card h3 {
            margin: 0 0 8px;
            color: #315b82;
            font-size: 17px;
            font-weight: 600;
        }

        .activity-card p {
            margin: 0 0 18px;
            color: #667386;
            font-size: 14px;
            line-height: 1.7;
        }

        .attendance-link {
            display: inline-block;
            padding: 10px 16px;
            background-color: #315f91;
            border: 1px solid #315f91;
            border-radius: 6px;
            color: #ffffff !important;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .attendance-link:hover {
            background-color: #244b75;
            border-color: #244b75;
        }

        .dashboard-status {
            display: block;
            margin-top: 22px;
            color: #667386;
            font-size: 14px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .dashboard-footer {
            display: flex;
            justify-content: flex-end;
            margin-top: 24px;
        }

        .logout-button {
            min-width: 110px;
            padding: 10px 18px;
            background-color: #ffffff;
            border: 1px solid #cbd5df;
            border-radius: 6px;
            color: #34465a;
            font-family: inherit;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, border-color 0.2s;
        }

        .logout-button:hover {
            background-color: #edf2f7;
            border-color: #aebdcd;
        }

        .attendance-link:focus,
        .logout-button:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        @media screen and (max-width: 600px) {
            body {
                padding: 18px 12px;
            }

            .dashboard-header {
                padding: 24px 20px;
            }

            .dashboard-header h1 {
                font-size: 23px;
            }

            .welcome-card,
            .activities-section {
                padding: 22px 18px;
            }

            .activity-card {
                padding: 18px;
            }

            .dashboard-footer {
                justify-content: stretch;
            }

            .logout-button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <main class="teacher-dashboard">
            <header class="dashboard-header">
                <h1>Student Attendance Management System</h1>
                <p>Dashboard</p>
            </header>

            <section class="welcome-card">
                <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-message"></asp:Label>
                <asp:Label ID="lblDate" runat="server" CssClass="dashboard-date"></asp:Label>
                <asp:Label ID="lblRole" runat="server" CssClass="dashboard-role"></asp:Label>
            </section>

            <section class="activities-section">
                <h2>Teacher Activities</h2>
                <p class="section-description">Access student records and manage attendance for your authorized activities.</p>

                <div class="activity-card">
                    <h3>Attendance Management</h3>
                    <p>View the student list by department and year of study, then select a student to record attendance.</p>
                    <asp:HyperLink ID="lnkAttendanceManagement" runat="server" NavigateUrl="~/StudentAttendanceList.aspx" Text="View Student List &#8594;" CssClass="attendance-link"></asp:HyperLink>
                </div>

                <asp:Label ID="lblStatus" runat="server" CssClass="dashboard-status"></asp:Label>
            </section>

            <footer class="dashboard-footer">
                <asp:Button ID="btbLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-button" />
            </footer>
        </main>
    </form>
</body>
</html>