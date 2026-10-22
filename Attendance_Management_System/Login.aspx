<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Attendance_Management_System.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login | Student Attendance Management System</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
            background-color: #f4f6f9;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #263445;
        }

        .login-container {
            width: 100%;
            max-width: 470px;
            padding: 32px 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 12px;
            box-shadow: 0 8px 28px rgba(25, 42, 70, 0.08);
        }

        .login-header {
            margin-bottom: 28px;
            text-align: center;
        }

        .login-header h1 {
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 22px;
            font-weight: 650;
            line-height: 1.4;
        }
        .login-header h2 {
                margin: 0 0 10px;
                color: #1f3b5b;
                font-size: 20px;
                font-weight: 645;
                line-height: 1.4;
            }


        .login-header p {
            margin: 0;
            color: #667386;
            font-size: 14px;
            line-height: 1.6;
        }

        .login-form-group {
            margin-bottom: 20px;
        }

        .login-label {
            display: block;
            margin-bottom: 8px;
            color: #34465a;
            font-size: 14px;
            font-weight: 600;
        }

        .login-input {
            display: block;
            width: 100%;
            height: 44px;
            padding: 10px 12px;
            border: 1px solid #ccd5df;
            border-radius: 6px;
            background-color: #ffffff;
            color: #263445;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .login-input:focus {
            outline: none;
            border-color: #315f91;
            box-shadow: 0 0 0 3px rgba(49, 95, 145, 0.13);
        }

        .login-button {
            display: block;
            width: 100%;
            min-height: 45px;
            margin-top: 8px;
            padding:6px 0;
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

        .login-button:hover {
            background-color: #244b75;
            border-color: #244b75;
        }

        .login-button:focus,
        .login-signup a:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        .login-result {
            display: block;
            margin-top: 16px;
            color: #b42318;
            font-size: 13px;
            line-height: 1.5;
            overflow-wrap: anywhere;
        }

        .login-signup {
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid #e8edf2;
            text-align: center;
            color: #667386;
            font-size: 14px;
        }

        .login-signup a {
            color: #315f91;
            font-weight: 600;
            text-decoration: none;
        }

        .login-signup a:hover {
            text-decoration: underline;
        }

        @media screen and (max-width: 480px) {
            body {
                padding: 16px;
            }

            .login-container {
                padding: 28px 22px;
            }

            .login-header h1 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <main class="login-container">
            <header class="login-header">
                <h1>Student Attendance Management System</h1>
                <h2>Login</h2>
                <p>Sign in to access your authorized account.</p>
            </header>

            <div class="login-form-group">
                <asp:Label ID="lblLogin" runat="server" Text="Username or Email:" CssClass="login-label" AssociatedControlID="txtLogin"></asp:Label>
                <asp:TextBox ID="txtLogin" runat="server" MaxLength="100" CssClass="login-input"></asp:TextBox>
            </div>

            <div class="login-form-group">
                <asp:Label ID="lblPin" runat="server" Text="PIN:" CssClass="login-label" AssociatedControlID="txtPin"></asp:Label>
                <asp:TextBox ID="txtPin" runat="server" TextMode="Password" MaxLength="20" CssClass="login-input"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="login-button" />

            <asp:Label ID="lblResult" runat="server" CssClass="login-result" EnableViewState="true"></asp:Label>

            <div class="login-signup">
                <asp:Label ID="lblSignup" runat="server" Text="New user? "></asp:Label>
                <asp:HyperLink ID="lnkSignup" runat="server" NavigateUrl="~/SignUp.aspx" Text="Sign up here"></asp:HyperLink>
            </div>
        </main>
    </form>
</body>
</html>