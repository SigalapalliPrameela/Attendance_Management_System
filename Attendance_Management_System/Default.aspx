<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Attendance_Management_System._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .home-page {
            max-width: 1100px;
            margin: 30px auto;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #263445;
            line-height: 1.7;
        }

        .home-hero {
            padding: 42px 36px;
            margin-bottom: 26px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(25, 42, 70, 0.06);
        }

        .home-hero h1 {
            margin: 0 0 16px;
            color: #1f3b5b;
            font-size: 34px;
            font-weight: 650;
            line-height: 1.3;
        }

        .home-hero .home-lead {
            max-width: 760px;
            margin: 0 0 24px;
            color: #667386;
            font-size: 17px;
        }

        .home-primary-link {
            display: inline-block;
            padding: 11px 20px;
            background-color: #315f91;
            border: 1px solid #315f91;
            border-radius: 6px;
            color: #ffffff !important;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none !important;
            transition: background-color 0.2s;
        }

        .home-primary-link:hover {
            background-color: #244b75;
            border-color: #244b75;
        }

        .home-primary-link:focus,
        .home-card-link:focus {
            outline: 2px solid #8bb7e5;
            outline-offset: 3px;
        }

        .home-section-heading {
            margin: 0 0 16px;
            color: #1f3b5b;
            font-size: 23px;
            font-weight: 600;
        }

        .home-card-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
        }

        .home-card {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            min-width: 0;
            padding: 25px 22px;
            background-color: #ffffff;
            border: 1px solid #e1e6ed;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(25, 42, 70, 0.04);
        }

        .home-card h2 {
            margin: 0 0 12px;
            color: #315b82;
            font-size: 19px;
            font-weight: 600;
        }

        .home-card p {
            flex-grow: 1;
            margin: 0 0 20px;
            color: #667386;
            font-size: 14px;
        }

        .home-card-link {
            display: inline-block;
            padding: 9px 14px;
            background-color: #edf2f7;
            border: 1px solid #d7e0e9;
            border-radius: 6px;
            color: #315f91 !important;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none !important;
            transition: background-color 0.2s;
        }

        .home-card-link:hover {
            background-color: #e0e9f3;
        }

        @media screen and (max-width: 900px) {
            .home-card-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media screen and (max-width: 600px) {
            .home-page {
                margin: 18px auto;
            }

            .home-hero {
                padding: 28px 20px;
            }

            .home-hero h1 {
                font-size: 27px;
            }

            .home-hero .home-lead {
                font-size: 15px;
            }

            .home-section-heading {
                font-size: 21px;
            }

            .home-card-grid {
                grid-template-columns: 1fr;
                gap: 14px;
            }

            .home-card {
                padding: 22px 18px;
            }
        }
    </style>

    <main class="home-page">

        <section class="home-hero" aria-labelledby="aspnetTitle">

            <h1 id="aspnetTitle">Student Attendance Management System</h1>

            <p class="home-lead">
                A centralized system for managing student attendance,
                organizing student records, and supporting secure
                teacher registration and approval.
            </p>

            <a href="Login.aspx" class="home-primary-link">
                Login to Your Account &raquo;
            </a>

        </section>

        <section aria-labelledby="gettingStartedTitle">

            <h2 id="gettingStartedTitle" class="home-section-heading">
                Explore the System
            </h2>

            <div class="home-card-grid">

                <section class="home-card" aria-labelledby="attendanceTitle">

                    <h2 id="attendanceTitle">Attendance Management</h2>

                    <p>
                        View student records by department and year of study
                        and access attendance-related activities according
                        to your authorized role.
                    </p>

                    <a class="home-card-link" href="Login.aspx">
                        Access Account &raquo;
                    </a>

                </section>

                <section class="home-card" aria-labelledby="teacherTitle">

                    <h2 id="teacherTitle">Teacher Registration</h2>

                    <p>
                        Teachers can register for an account. Access to
                        attendance management is provided after the
                        administrator approves the registration.
                    </p>

                    <a class="home-card-link" href="TeacherRegister.aspx">
                        Teacher Registration &raquo;
                    </a>

                </section>

                <section class="home-card" aria-labelledby="adminTitle">

                    <h2 id="adminTitle">Administrator</h2>

                    <p>
                        The administrator can review teacher registration
                        requests and manage access to the system through
                        the authorized admin dashboard.
                    </p>

                    <a class="home-card-link" href="Login.aspx">
                        Admin Login &raquo;
                    </a>

                </section>

            </div>

        </section>

    </main>

</asp:Content>