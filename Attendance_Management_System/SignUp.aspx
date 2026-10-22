<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Attendance_Management_System.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sign Up | Student Attendance Management System</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 30px 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f4f6f9;
            color: #263445;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .signup-container {
            width: 100%;
            max-width: 500px;
            padding: 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 12px;
            box-shadow: 0 8px 28px rgba(25, 42, 70, 0.08);
        }

        .signup-header {
            margin-bottom: 26px;
            text-align: center;
        }

        .signup-header h1 {
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 22px;
            font-weight: 650;
            line-height: 1.4;
        }

        .signup-header h2{
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 20px;
            font-weight: 650;
            line-height: 1.4;
        }

        .signup-header p {
            margin: 0;
            color: #667386;
            font-size: 14px;
            line-height: 1.6;
        }

        .signup-field {
            margin-bottom: 18px;
        }

        .signup-label {
            display: block;
            margin-bottom: 7px;
            color: #34465a;
            font-size: 14px;
            font-weight: 600;
        }

        .signup-input {
            display: block;
            width: 100%;
            height: 43px;
            padding: 10px 12px;
            border: 1px solid #ccd5df;
            border-radius: 6px;
            background-color: #ffffff;
            color: #263445;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .signup-input:focus {
            outline: none;
            border-color: #315f91;
            box-shadow: 0 0 0 3px rgba(49, 95, 145, 0.13);
        }

        .signup-hint {
            margin: 6px 0 0;
            color: #778496;
            font-size: 12px;
            line-height: 1.5;
        }

        .signup-button {
            display: block;
            width: 100%;
            min-height: 45px;
            margin-top: 24px;
            padding: 11px 18px;
            border: 1px solid #315f91;
            border-radius: 6px;
            background-color: #315f91;
            color: #ffffff;
            font-family: inherit;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .signup-button:hover {
            background-color: #244b75;
            border-color: #244b75;
        }

        .signup-button:focus,
        .signup-footer a:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        .signup-result {
            display: block;
            font-family:bold;
            margin-top: 16px;
            color: #b42318;
            font-size: 13px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .signup-footer {
            margin-top: 22px;
            padding-top: 18px;
            border-top: 1px solid #e8edf2;
            text-align: center;
            color: #667386;
            font-size: 14px;
        }

        .signup-footer a {
            color: #315f91;
            font-weight: 600;
            text-decoration: none;
        }

        .signup-footer a:hover {
            text-decoration: underline;
        }

        @media screen and (max-width: 520px) {
            body {
                padding: 18px 12px;
            }

            .signup-container {
                padding: 26px 20px;
            }

            .signup-header h1 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <main class="signup-container">
            <header class="signup-header">
                <h1>Student Attendance Management System</h1>
                <h2>Sign Up</h2>
                <p>Create your account to request access to the system.</p>
            </header>

            <div class="signup-field">
                <asp:Label ID="lblFullName" runat="server" Text="Full Name:" CssClass="signup-label" AssociatedControlID="txtFullName"></asp:Label>
                <asp:TextBox ID="txtFullName" runat="server" MaxLength="100" CssClass="signup-input"></asp:TextBox>
            </div>

            <div class="signup-field">
                <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="signup-label" AssociatedControlID="txtEmail"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" MaxLength="254" TextMode="Email" CssClass="signup-input"></asp:TextBox>
            </div>

            <div class="signup-field">
                <asp:Label ID="lblUsername" runat="server" Text="Username:" CssClass="signup-label" AssociatedControlID="txtUsername"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" MaxLength="50" CssClass="signup-input"></asp:TextBox>
            </div>

            <div class="signup-field">
                <asp:Label ID="lblPin" runat="server" Text="PIN (4–20 digits):" CssClass="signup-label" AssociatedControlID="txtPin"></asp:Label>
                <asp:TextBox ID="txtPin" runat="server" TextMode="Password" MaxLength="20" CssClass="signup-input"></asp:TextBox>
               
            </div>

            <div class="signup-field">
                <asp:Label ID="lblConfirmPin" runat="server" Text="Confirm PIN:" CssClass="signup-label" AssociatedControlID="txtConfirmPin"></asp:Label>
                <asp:TextBox ID="txtConfirmPin" runat="server" TextMode="Password" MaxLength="20" CssClass="signup-input"></asp:TextBox>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="signup-button" />

            <asp:Label ID="lblResult" runat="server" EnableViewState="false" CssClass="signup-result"></asp:Label>

            <div class="signup-footer">
                Already registered?
                <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/Login.aspx" Text="Login here"></asp:HyperLink>
            </div>
        </main>
    </form>
</body>
</html>