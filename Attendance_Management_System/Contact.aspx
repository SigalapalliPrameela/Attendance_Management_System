<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Attendance_Management_System.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .contact-page {
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

        .contact-page .contact-heading {
            margin: 0 0 10px;
            color: #1f3b5b;
            font-size: 28px;
            font-weight: 650;
        }

        .contact-page .contact-subheading {
            margin: 0 0 24px;
            color: #315b82;
            font-size: 20px;
            font-weight: 600;
        }

        .contact-page .contact-divider {
            width: 65px;
            height: 3px;
            margin: 18px 0 24px;
            border: none;
            border-radius: 2px;
            background-color: #315f91;
        }

        .contact-page .contact-section {
            margin-bottom: 22px;
            padding: 20px 22px;
            background-color: #f8fafc;
            border: 1px solid #e1e6ed;
            border-radius: 8px;
        }

        .contact-page .contact-section h3 {
            margin: 0 0 12px;
            color: #29435f;
            font-size: 17px;
            font-weight: 600;
        }

        .contact-page address {
            margin: 0;
            color: #667386;
            font-size: 15px;
            font-style: normal;
            line-height: 1.9;
        }

        .contact-page strong {
            color: #34465a;
            font-weight: 600;
        }

        .contact-page a {
            color: #315f91;
            text-decoration: none;
            overflow-wrap: anywhere;
            transition: color 0.2s;
        }

        .contact-page a:hover {
            color: #1f4269;
            text-decoration: underline;
        }

        .contact-page a:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        .contact-page .contact-icon {
            display: inline-block;
            margin-right: 8px;
            color: #315f91;
        }

        @media screen and (max-width: 768px) {
            .contact-page {
                margin: 18px auto;
                padding: 22px 16px;
            }

            .contact-page .contact-heading {
                font-size: 24px;
            }

            .contact-page .contact-subheading {
                font-size: 18px;
            }

            .contact-page .contact-section {
                padding: 16px 14px;
            }
        }
    </style>

    <main class="contact-page" aria-labelledby="title">

        <h2 id="title" class="contact-heading">
            <%: Title %>
        </h2>

        <hr class="contact-divider" />

        <h3 class="contact-subheading">
            Your contact page.
        </h3>

        <section class="contact-section">
            <h3>Our Address</h3>

            <address>
                One Microsoft Way<br />
                Redmond, WA 98052-6399<br />
                <strong>Phone:</strong>
                425.555.0100
            </address>
        </section>

        <section class="contact-section">
            <h3>Get in Touch</h3>

            <address>
                <strong>Support:</strong>
                <a href="mailto:Support@example.com">Support@example.com</a>
                <br />

                <strong>Marketing:</strong>
                <a href="mailto:Marketing@example.com">Marketing@example.com</a>
            </address>
        </section>

    </main>

</asp:Content>