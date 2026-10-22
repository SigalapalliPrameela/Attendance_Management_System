<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminSetUp.aspx.cs" Inherits="Attendance_Management_System.AdminSetUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Initial Admin Setup - AMS</title>
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
            max-width: 560px;
            margin: 20px auto;
            padding: 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
        }

        h2 {
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 27px;
            font-weight: 650;
        }

        #form1 > p {
            margin: 0 0 26px;
            color: #667386;
            font-size: 15px;
        }

        #lblfullname,
        #lblEmail,
        #lblUsername,
        #lblPin,
        #lblConfirmPin {
            display: inline-block;
            margin-bottom: 7px;
            color: #34465a;
            font-size: 14px;
            font-weight: 600;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            display: block;
            width: 100%;
            min-height: 43px;
            padding: 10px 12px;
            border: 1px solid #ccd5e0;
            border-radius: 6px;
            background-color: #ffffff;
            color: #263445;
            font-family: inherit;
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #356da8;
            box-shadow: 0 0 0 3px rgba(53, 109, 168, 0.12);
        }

        #btnCreateAdmin {
            width: 100%;
            min-height: 44px;
            margin-top: 18px;
            padding: 11px 18px;
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

        #btnCreateAdmin:hover {
            background-color: #244b75;
        }

        #btnCreateAdmin:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        #lblResult {
            display: block;
            margin-top: 18px;
            color: #34465a;
            font-size: 14px;
            overflow-wrap: anywhere;
        }

        @media screen and (max-width: 600px) {
            body {
                padding: 15px 10px;
            }

            #form1 {
                margin: 10px auto;
                padding: 24px 18px;
            }

            h2 {
                font-size: 23px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <h2>Initial Admin Setup</h2>

        <p>Create the initial administrator account to manage the system.</p>

        <asp:Label ID="lblfullname" runat="server" Text="Full Name"></asp:Label>
        <asp:TextBox ID="txtfullName" runat="server" MaxLength="100"></asp:TextBox>
        <br />

        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" MaxLength="256"></asp:TextBox>
        <br />

        <asp:Label ID="lblUsername" runat="server" Text="User Name"></asp:Label>
        <asp:TextBox ID="txtUsername" runat="server" MaxLength="50"></asp:TextBox>
        <br />

        <asp:Label ID="lblPin" runat="server" Text="Admin PIN (6 or more digits recommended for better security)"></asp:Label>
        <asp:TextBox ID="txtPin" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>
        <br />

        <asp:Label ID="lblConfirmPin" runat="server" Text="Confirm Admin PIN"></asp:Label>
        <asp:TextBox ID="txtConfirmPin" runat="server" TextMode="Password" MaxLength="20"></asp:TextBox>

        <asp:Button
            ID="btnCreateAdmin"
            runat="server"
            Text="Create Admin Account"
            OnClick="btnCreateAdmin_Click" />

        <asp:Label ID="lblResult" runat="server"></asp:Label>

    </form>
</body>
</html>