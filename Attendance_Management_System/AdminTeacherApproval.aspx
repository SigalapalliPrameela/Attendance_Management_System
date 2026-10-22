<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminTeacherApproval.aspx.cs" Inherits="Attendance_Management_System.AdminTeacherApproval" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Teacher Approval - Student Attendance Management System</title>
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

        h1 {
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 28px;
            font-weight: 650;
        }

        h2 {
            margin: 0 0 16px;
            color: #315b82;
            font-size: 22px;
            font-weight: 600;
        }

        p {
            margin: 0 0 22px;
            color: #667386;
            font-size: 15px;
        }

        #lblMessage {
            display: inline-block;
            margin: 8px 0;
            color: #34465a;
            font-size: 14px;
            overflow-wrap: anywhere;
        }

        #gvTeachers {
            width: 100%;
            margin-top: 12px;
            border-collapse: collapse;
            border: 1px solid #e0e6ed;
            font-size: 14px;
        }

        #gvTeachers th {
            padding: 14px 16px;
            background-color: #edf2f7;
            color: #29435f;
            text-align: left;
            font-weight: 650;
            border-bottom: 2px solid #d7e0e9;
        }

        #gvTeachers td {
            padding: 13px 16px;
            border-bottom: 1px solid #e6ebf1;
            color: #39495b;
            vertical-align: middle;
        }

        #gvTeachers tr:last-child td {
            border-bottom: none;
        }

        #gvTeachers tr:hover td {
            background-color: #f7f9fc;
        }

        #gvTeachers input[type="submit"],
        #gvTeachers input[type="button"],
        #gvTeachers button {
            margin: 3px 4px 3px 0;
            padding: 8px 13px;
            border: none;
            border-radius: 5px;
            color: #ffffff;
            font-family: inherit;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        #gvTeachers input[id*="btnApprove"] {
            background-color: #357653;
        }

        #gvTeachers input[id*="btnApprove"]:hover {
            background-color: #285d40;
        }

        #gvTeachers input[id*="btnReject"] {
            background-color: #b54747;
        }

        #gvTeachers input[id*="btnReject"]:hover {
            background-color: #923737;
        }

        #gvTeachers input[type="submit"]:focus,
        #gvTeachers input[type="button"]:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 2px;
        }

        #lnkDashboard {
            display: inline-block;
            margin-top: 22px;
            color: #315f91;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        #lnkDashboard:hover {
            color: #1f4269;
            text-decoration: underline;
        }

        @media screen and (max-width: 768px) {
            body {
                padding: 15px 10px;
            }

            #form1 {
                padding: 22px 14px;
            }

            h1 {
                font-size: 24px;
            }

            h2 {
                font-size: 20px;
            }

            #gvTeachers {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <h1>Student Attendance Management System</h1>
            <h2>Admin - Teacher Approval</h2>

            <p>
                Review teacher registration requests and approve or reject them.
            </p>

            <asp:Label ID="lblMessage" runat="server"
                EnableViewState="false" />

            <br />
            <br />

            <asp:GridView ID="gvTeachers" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="UserId"
                EmptyDataText="There are no pending teacher requests."
                OnRowCommand="gvTeachers_RowCommand">

                <Columns>
                    <asp:BoundField DataField="FullName"
                        HeaderText="Full Name" />

                    <asp:BoundField DataField="Email"
                        HeaderText="Email" />

                    <asp:BoundField DataField="Username"
                        HeaderText="Username" />

                    <asp:BoundField DataField="CreatedAt"
                        HeaderText="Registration Date"
                        DataFormatString="{0:dd MMM yyyy HH:mm}" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnApprove" runat="server"
                                Text="Approve"
                                CommandName="ApproveTeacher"
                                CommandArgument='<%# Eval("UserId") %>'
                                CausesValidation="false"
                                OnClientClick="return confirm('Approve this teacher?');" />

                            <asp:Button ID="btnReject" runat="server"
                                Text="Reject"
                                CommandName="RejectTeacher"
                                CommandArgument='<%# Eval("UserId") %>'
                                CausesValidation="false"
                                OnClientClick="return confirm('Reject this teacher?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <br />

            <asp:HyperLink ID="lnkDashboard" runat="server"
                NavigateUrl="~/AdminDashboard.aspx"
                Text="Back to Admin Dashboard" />
        </div>
    </form>
</body>
</html>