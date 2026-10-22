<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MarkAttendance.aspx.cs" Inherits="Attendance_Management_System.MarkAttendance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Mark Attendance | AMS</title>
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

        .attendance-page {
            width: 100%;
            max-width: 760px;
            margin: 0 auto;
        }

        .attendance-header {
            margin-bottom: 24px;
        }

        .attendance-header h1 {
            margin: 0 0 8px;
            color: #1f3b5b;
            font-size: 28px;
            font-weight: 650;
            line-height: 1.4;
        }

        .attendance-header p {
            margin: 0;
            color: #667386;
            font-size: 14px;
            line-height: 1.6;
        }

        .attendance-card {
            padding: 30px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
        }

        .attendance-card h2 {
            margin: 0 0 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e8edf2;
            color: #315b82;
            font-size: 20px;
            font-weight: 600;
        }

        .student-details {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 28px;
        }

        .detail-item {
            min-width: 0;
            padding: 15px 16px;
            background-color: #f8fafc;
            border: 1px solid #e5eaf0;
            border-radius: 7px;
        }

        .detail-label {
            display: block;
            margin-bottom: 6px;
            color: #667386;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        .detail-value {
            display: block;
            min-height: 22px;
            color: #263445;
            font-size: 15px;
            font-weight: 600;
            overflow-wrap: anywhere;
        }

        .attendance-date {
            margin-bottom: 26px;
            padding: 15px 16px;
            background-color: #f0f5fa;
            border: 1px solid #dce7f1;
            border-radius: 7px;
        }

        .attendance-date .detail-value {
            color: #315f91;
        }

        .status-section {
            margin-bottom: 28px;
        }

        .status-heading {
            display: block;
            margin-bottom: 14px;
            color: #34465a;
            font-size: 14px;
            font-weight: 600;
        }

        .status-options {
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
        }

        .status-options table {
            border-collapse: separate;
            border-spacing: 0;
        }

        .status-options td {
            padding: 0 20px 0 0;
            color: #34465a;
            font-size: 14px;
        }

        .status-options input {
            margin-right: 7px;
            accent-color: #315f91;
            vertical-align: middle;
        }

        .attendance-submit {
            width: 100%;
            min-height: 45px;
            padding: 11px 18px;
            background-color: #315f91;
            border: 1px solid #315f91;
            border-radius: 6px;
            color: #ffffff;
            font-family: inherit;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s, border-color 0.2s, color 0.2s;
        }

        .attendance-submit:hover:not(:disabled) {
            background-color: #244b75;
            border-color: #244b75;
        }

        .attendance-submit:disabled,
        .attendance-submit[disabled] {
            background-color: #e5e7eb !important;
            border: 1px solid #cbd0d8 !important;
            color: #737b87 !important;
            cursor: not-allowed !important;
            opacity: 1;
            box-shadow: none;
        }

        .attendance-submit:focus,
        .back-link:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        .attendance-message {
            display: block;
            margin-top: 18px;
            font-size: 14px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .attendance-footer {
            margin-top: 24px;
        }

        .back-link {
            display: inline-block;
            color: #315f91;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media screen and (max-width: 560px) {
            body {
                padding: 20px 12px;
            }

            .attendance-header h1 {
                font-size: 23px;
            }

            .attendance-card {
                padding: 22px 18px;
            }

            .student-details {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .attendance-card h2 {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <main class="attendance-page">
            <header class="attendance-header">
                <h1>Student Attendance Management System</h1>
                <p>Record attendance for an individual student.</p>
            </header>

            <section class="attendance-card">
                <h2>Mark Individual Student Attendance</h2>

                <div class="student-details">
                    <div class="detail-item">
                        <asp:Label ID="lblStudentNameTitle" runat="server" Text="Student Name:" CssClass="detail-label"></asp:Label>
                        <asp:Label ID="lblStudentName" runat="server" CssClass="detail-value"></asp:Label>
                    </div>

                    <div class="detail-item">
                        <asp:Label ID="lblRollNumberTitle" runat="server" Text="Roll Number:" CssClass="detail-label"></asp:Label>
                        <asp:Label ID="lblRollNumber" runat="server" CssClass="detail-value"></asp:Label>
                    </div>

                    <div class="detail-item">
                        <asp:Label ID="lblDepartmentTitle" runat="server" Text="Department:" CssClass="detail-label"></asp:Label>
                        <asp:Label ID="lblDepartment" runat="server" CssClass="detail-value"></asp:Label>
                    </div>

                    <div class="detail-item">
                        <asp:Label ID="lblYearTitle" runat="server" Text="Year of Study:" CssClass="detail-label"></asp:Label>
                        <asp:Label ID="lblYear" runat="server" CssClass="detail-value"></asp:Label>
                    </div>
                </div>

                <div class="attendance-date">
                    <asp:Label ID="lblAttendanceTitle" runat="server" Text="Attendance Date:" CssClass="detail-label"></asp:Label>
                    <asp:Label ID="lblAttendanceDate" runat="server" CssClass="detail-value"></asp:Label>
                </div>

                <div class="status-section">
                    <asp:Label ID="lblStatusTitle" runat="server" Text="Select Attendance Status" CssClass="status-heading" AssociatedControlID="rblAttendanceStatus"></asp:Label>

                    <asp:RadioButtonList ID="rblAttendanceStatus" runat="server" RepeatDirection="Horizontal" CssClass="status-options">
                        <asp:ListItem Text="Present" Value="Present"></asp:ListItem>
                        <asp:ListItem Text="Absent" Value="Absent"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <asp:Button ID="btnSubmitAttendance" runat="server" Text="Submit Attendance" OnClick="btnSubmitAttendance_Click" CssClass="attendance-submit" />

                <asp:Label ID="lblMessage" runat="server" EnableViewState="false" CssClass="attendance-message"></asp:Label>
            </section>

            <footer class="attendance-footer">
                <asp:HyperLink ID="lnkBackToStudents" runat="server" NavigateUrl="~/StudentAttendanceList.aspx" Text="&#8592; Back to Students List" CssClass="back-link"></asp:HyperLink>
            </footer>
        </main>
    </form>
</body>
</html>