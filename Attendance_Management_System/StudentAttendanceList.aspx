<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentAttendanceList.aspx.cs" Inherits="Attendance_Management_System.StudentAttendanceList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Attendance List - AMS</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        /* General page styling */
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

        /* Main content container */
        #form1 {
            max-width: 1100px;
            margin: 0 auto;
            padding: 30px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
        }

        /* Page headings */
        h2 {
            margin: 0 0 8px;
            color: #1f3b5b;
            font-size: 27px;
            font-weight: 650;
        }

        h3 {
            margin: 0 0 12px;
            color: #315b82;
            font-size: 21px;
            font-weight: 600;
        }

        p {
            margin: 0 0 22px;
            color: #667386;
            font-size: 15px;
        }

        /* Department and year labels */
        #lblDepartment,
        #lblYear {
            display: inline-block;
            margin-bottom: 7px;
            color: #34465a;
            font-size: 14px;
            font-weight: 600;
        }

        /* Dropdown lists */
        select {
            width: 100%;
            max-width: 320px;
            min-height: 42px;
            padding: 9px 12px;
            border: 1px solid #ccd5e0;
            border-radius: 6px;
            background-color: #ffffff;
            color: #263445;
            font-family: inherit;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        select:focus {
            border-color: #356da8;
            box-shadow: 0 0 0 3px rgba(53, 109, 168, 0.12);
        }

        /* General button styling */
        input[type="submit"],
        input[type="button"],
        button {
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            background-color: #315f91;
            color: #ffffff;
            font-family: inherit;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        input[type="submit"]:hover,
        input[type="button"]:hover,
        button:hover {
            background-color: #244b75;
        }

        input[type="submit"]:focus,
        input[type="button"]:focus,
        button:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 2px;
        }

        /* View Students button */
        #btnViewStudents {
            margin-top: 4px;
        }

        /* Status and validation message */
        #lblMessage {
            display: inline-block;
            margin-top: 8px;
            color: #34465a;
            font-size: 14px;
        }

        /* Student table */
        #gvStudents {
            width: 100%;
            margin-top: 12px;
            border-collapse: collapse;
            border: 1px solid #e0e6ed;
            font-size: 14px;
        }

        #gvStudents th {
            padding: 14px 16px;
            background-color: #edf2f7;
            color: #29435f;
            text-align: left;
            font-weight: 650;
            border-bottom: 2px solid #d7e0e9;
        }

        #gvStudents td {
            padding: 13px 16px;
            border-bottom: 1px solid #e6ebf1;
            color: #39495b;
            vertical-align: middle;
        }

        #gvStudents tr:last-child td {
            border-bottom: none;
        }

        #gvStudents tr:hover td {
            background-color: #f7f9fc;
        }

        /* Mark Attendance button inside the table */
        #gvStudents input[type="submit"],
        #gvStudents input[type="button"],
        #gvStudents button {
            padding: 8px 12px;
            background-color: #357653;
            font-size: 13px;
            white-space: nowrap;
        }

        #gvStudents input[type="submit"]:hover,
        #gvStudents input[type="button"]:hover,
        #gvStudents button:hover {
            background-color: #285d40;
        }

        /* Dashboard navigation */
        #lnkBackDashboard {
            display: inline-block;
            margin-top: 18px;
            color: #315f91;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        #lnkBackDashboard:hover {
            color: #1f4269;
            text-decoration: underline;
        }

        /* Responsive layout for smaller screens */
        @media screen and (max-width: 768px) {
            body {
                padding: 15px 10px;
            }

            #form1 {
                padding: 20px 14px;
            }

            h2 {
                font-size: 23px;
            }

            h3 {
                font-size: 19px;
            }

            #gvStudents {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            select {
                max-width: 100%;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <h2>Student Attendance Management System</h2>
        <h3>Student Attendance List</h3>

        <p>Select a department and year to view corresponding students.</p>

        <asp:Label
            ID="lblDepartment"
            runat="server"
            AssociatedControlID="ddlDepartment"
            Text="Department:">
        </asp:Label>

        <br />

        <asp:DropDownList
            ID="ddlDepartment"
            runat="server">
        </asp:DropDownList>

        <br />
        <br />

        <asp:Label
            ID="lblYear"
            runat="server"
            AssociatedControlID="ddlYear"
            Text="Year Of Study:">
        </asp:Label>

        <br />

        <asp:DropDownList ID="ddlYear" runat="server">
            <asp:ListItem Text="Select Year" Value=""></asp:ListItem>
            <asp:ListItem Text="First Year" Value="1"></asp:ListItem>
            <asp:ListItem Text="Second Year" Value="2"></asp:ListItem>
            <asp:ListItem Text="Third Year" Value="3"></asp:ListItem>
            <asp:ListItem Text="Fourth Year" Value="4"></asp:ListItem>
        </asp:DropDownList>

        <br />
        <br />

        <asp:Button
            ID="btnViewStudents"
            runat="server"
            Text="View Students"
            OnClick="btnViewStudents_Click" />

        <br />
        <br />

        <asp:Label
            ID="lblMessage"
            runat="server"
            EnableViewState="false">
        </asp:Label>

        <br />
        <br />

        <asp:GridView
            ID="gvStudents"
            runat="server"
            AutoGenerateColumns="False"
            DataKeyNames="StudentId"
            OnRowCommand="gvStudents_RowCommand">

            <Columns>

                <asp:BoundField
                    DataField="StudentName"
                    HeaderText="Student Name" />

                <asp:BoundField
                    DataField="RollNumber"
                    HeaderText="Roll Number" />

                <asp:BoundField
                    DataField="DepartmentName"
                    HeaderText="Department Name" />

                <asp:BoundField
                    DataField="YearOfStudy"
                    HeaderText="Year" />

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button
                            ID="btnMarkAttendance"
                            runat="server"
                            Text="Mark Attendance"
                            CommandName="MarkAttendance"
                            CommandArgument='<%# Eval("StudentId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>

        <br />

        <asp:HyperLink
            ID="lnkBackDashboard"
            runat="server"
            NavigateUrl="~/TeacherDashboard.aspx"
            Text="Back To Teacher Dashboard">
        </asp:HyperLink>

    </form>
</body>
</html>