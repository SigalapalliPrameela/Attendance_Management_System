<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatabaseTest.aspx.cs" Inherits="Attendance_Management_System.DatabaseTest" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Database Connection Test - AMS</title>
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
            width: 100%;
            max-width: 650px;
            margin: 50px auto;
            padding: 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
            text-align: center;
        }

        h2 {
            margin: 0 0 16px;
            color: #1f3b5b;
            font-size: 26px;
            font-weight: 650;
        }

        .database-description {
            margin: 0 0 26px;
            color: #667386;
            font-size: 15px;
        }

        #btnTestConnection {
            display: inline-block;
            min-height: 44px;
            padding: 11px 22px;
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

        #btnTestConnection:hover {
            background-color: #244b75;
        }

        #btnTestConnection:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        #lblResult {
            display: block;
            margin-top: 24px;
            padding: 12px;
            border-radius: 6px;
            color: #34465a;
            font-size: 14px;
            overflow-wrap: anywhere;
        }

        @media screen and (max-width: 600px) {
            body {
                padding: 15px 10px;
            }

            #form1 {
                margin: 25px auto;
                padding: 24px 16px;
            }

            h2 {
                font-size: 23px;
            }

            #btnTestConnection {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <h2>Database Connection Test</h2>

        <p class="database-description">
            Verify that the application can connect to the configured database.
        </p>

        <asp:Button
            ID="btnTestConnection"
            Text="Test Database Connection"
            runat="server"
            OnClick="btnTestConnection_Click" />

        <br />
        <br />

        <asp:Label
            ID="lblResult"
            runat="server">
        </asp:Label>

    </form>
</body>
</html>