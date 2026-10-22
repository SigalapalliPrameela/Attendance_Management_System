<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Attendance_Management_System.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .about-page {
            max-width: 1100px;
            margin: 30px auto;
            padding: 32px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
            font-family: "Segoe UI", Arial, sans-serif;
            color: #263445;
            line-height: 1.7;
        }

        .about-page .about-heading {
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 28px;
            font-weight: 650;
        }

        .about-page .about-subheading {
            margin: 0 0 18px;
            color: #315b82;
            font-size: 20px;
            font-weight: 600;
        }

        .about-page .about-description {
            margin: 0;
            color: #667386;
            font-size: 15px;
        }

        .about-page .about-divider {
            width: 65px;
            height: 3px;
            margin: 18px 0;
            border: none;
            border-radius: 2px;
            background-color: #315f91;
        }

        @media screen and (max-width: 768px) {
            .about-page {
                margin: 18px auto;
                padding: 22px 16px;
            }

            .about-page .about-heading {
                font-size: 24px;
            }

            .about-page .about-subheading {
                font-size: 18px;
            }
        }
    </style>

    <main class="about-page" aria-labelledby="title">

        <h2 id="title" class="about-heading">
            <%: Title %>
        </h2>

        <hr class="about-divider" />

        <h3 class="about-subheading">
            Your application description page.
        </h3>

        <p class="about-description">
            Use this area to provide additional information.
        </p>

    </main>

</asp:Content>