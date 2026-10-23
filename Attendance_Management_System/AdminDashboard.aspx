<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="Attendance_Management_System.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - AMS</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px 16px;
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f4f6f9;
            color: #263445;
            line-height: 1.6;
        }

        #form1 {
            max-width: 1100px;
            margin: 0 auto;
            padding: 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
        }

        h2 {
            margin: 0 0 8px;
            color: #1f3b5b;
            font-size: 28px;
            font-weight: 650;
        }

        h3 {
            margin: 0 0 24px;
            color: #315b82;
            font-size: 22px;
            font-weight: 600;
        }

        h4 {
            margin: 0 0 12px;
            color: #29435f;
            font-size: 18px;
            font-weight: 600;
        }

        #lblWelcome,
        #lblDate,
        #lblRole {
            display: inline-block;
            margin-bottom: 10px;
            color: #526276;
            font-size: 15px;
        }

        #lblWelcome {
            color: #1f3b5b;
            font-size: 17px;
            font-weight: 600;
        }

        #lblRole {
            padding: 4px 12px;
            background-color: #edf2f7;
            border-radius: 5px;
            color: #315f91;
            font-size: 13px;
            font-weight: 600;
        }

        .admin-activities {
            margin-top: 20px;
            padding: 24px;
            background-color: #f8fafc;
            border: 1px solid #e1e6ed;
            border-radius: 8px;
        }

        .admin-activities p {
            margin: 0 0 20px;
            color: #667386;
            font-size: 15px;
        }

        #lblStatus {
            display: inline-block;
            margin: 8px 0;
            color: #34465a;
            font-size: 14px;
        }

        #lnkTeacherApproval {
            display: inline-block;
            padding: 11px 18px;
            background-color: #315f91;
            border: 1px solid #315f91;
            border-radius: 6px;
            color: #ffffff;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.2s, border-color 0.2s;
        }

        #lnkTeacherApproval:hover {
            background-color: #244b75;
            border-color: #244b75;
        }

        #lnkTeacherApproval:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        #btbLogout {
            display: inline-block;
            margin-top: 24px;
            padding: 10px 20px;
            background-color: #ffffff;
            border: 2px solid #cbd5e1;
            border-radius: 6px;
            color: #34465a;
            font-family: inherit;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            transition: background-color 0.2s, border-color 0.2s;
        }

        #btbLogout:hover {
            background-color: #edf2f7;
            border-color: #aebdce;
        }

        #btbLogout:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        @media screen and (max-width: 768px) {
            body {
                padding: 16px 10px;
            }

            #form1 {
                padding: 22px 16px;
            }

            h2 {
                font-size: 24px;
            }

            h3 {
                font-size: 20px;
            }

            .admin-activities {
                padding: 18px 14px;
            }

            #lnkTeacherApproval {
                max-width: 100%;
                line-height: 1.5;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <h2>Student Attendance Management System</h2>
        <h3>Admin Dashboard</h3>

        <asp:Label
            ID="lblWelcome"
            runat="server">
        </asp:Label>

        <br />

        <asp:Label
            ID="lblDate"
            runat="server">
        </asp:Label>

        <br />

        <asp:Label
            ID="lblRole"
            runat="server">
        </asp:Label>

        <br />
        <br />

        <div class="admin-activities">

            <h4>Admin Activities</h4>

            <p>
                You can manage attendance and review teacher
                registration requests from the Admin Dashboard.
            </p>

            <asp:Label
                ID="lblStatus"
                runat="server">
            </asp:Label>

            <br />
            <br />

            <asp:HyperLink
                ID="lnkTeacherApproval"
                runat="server"
                NavigateUrl="~/AdminTeacherApproval.aspx"
                Text="Review Teacher Registration Requests" />

        </div>

        <asp:Button
            ID="btbLogout"
            runat="server"
            Text="Logout"
            OnClick="btnLogout_Click" />

    </form>
</body>
</html>