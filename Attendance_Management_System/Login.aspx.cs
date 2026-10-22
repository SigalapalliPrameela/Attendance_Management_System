using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using Microsoft.Ajax.Utilities;


namespace Attendance_Management_System
{
    public partial class Login : System.Web.UI.Page
    {

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["StudentAttendanceConnection"].ConnectionString;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack && Session["UserId"] != null)
            {
                RedirectByRole();
            }
        }

        protected void btnLogin_Click(object sender , EventArgs e)
        {
            lblResult.Text = "";

            string login = txtLogin.Text.Trim();
            string pin = txtPin.Text;

            if(string.IsNullOrWhiteSpace(login) || string.IsNullOrWhiteSpace(pin))
            {
                lblResult.Text = "Please enter your username/email and pin";
                return;
            }

            if(pin.Length > 20)
            {
                lblResult.Text = "Invalid Username/email or PIN";
                return;
            }

            try
            {
                int userId;
                string fullName;
                string storedHash;
                string role;
                string approvalStatus;

                using(SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    string query = @"Select UserId , FullName , PinHash , Role , ApprovalStatus from Users where Username = @Login or Email=@Login;";

                    using (SqlCommand command = new SqlCommand(query , connection))
                    {
                        command.Parameters.Add("@Login", SqlDbType.NVarChar, 100).Value = login;

                        connection.Open();

                        using(SqlDataReader reader = command.ExecuteReader())
                        {
                            if(!reader.Read())
                            {
                                lblResult.Text = "Invalid username/email or Pin.";
                                return;
                            }

                            userId = Convert.ToInt32(reader["UserId"]);
                            fullName = Convert.ToString(reader["FullName"]);
                            storedHash = Convert.ToString(reader["PinHash"]);
                            role = Convert.ToString(reader["Role"]);
                            approvalStatus = Convert.ToString(reader["ApprovalStatus"]);
                        }
                    }
                }

                //if (!VerifyPin(pin, storedHash))
                //{
                //    lblResult.Text = "Invalid username/email or PIN.";
                //    return;
                //}

                bool pinIsValid = VerifyPin(pin, storedHash);

                //System.Diagnostics.Debug.WriteLine(
                //    "Admin login: account found; PIN verification = "
                //    + pinIsValid);

                if (!pinIsValid)
                {
                    lblResult.Text = "Invalid username/email or PIN.";
                    return;
                }

                if (role == "Teacher" && approvalStatus!="Approved")
                {
                    lblResult.Text = approvalStatus == "Pending" ? "Your account is awaiting for Admin's approval , So try after some time." : "Your account is not approved , Contact Admin.";
                    return;
                }

                if(role != "Teacher" && role!="Admin")
                {
                    lblResult.Text = "Account role is Invalid";
                    return;
                }

                //startig a fresh Authenticated session
                Session.Clear();
                Session["UserId"] = userId;
                Session["FullName"] = fullName;
                Session["Role"] = role;

                //// Regeenerate the session identifier after login

                //SessionIDManager manager = new SessionIDManager();

                //string newSessionId = manager.CreateSessionID(Context);

                //bool redirected;
                //bool cookieAdded;

                //manager.SaveSessionID(Context,
                //    newSessionId,
                //    out redirected,
                //    out cookieAdded);

                RedirectByRole();

            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                lblResult.Text = "Login could not be completed, Please try again";

            }
        }

        private bool VerifyPin(string pin , string storedHash)

        {
            try
            {
                string[] parts = storedHash.Split('$');

                //for (int i = 0; i < parts[0].Length; i++)
                //{
                //    System.Diagnostics.Debug.WriteLine(
                //        "Character " + i + ": '" + parts[0][i]
                //        + "' Code: " + (int)parts[0][i]);
                //}
                //// TEMPORARY DEBUGGING: inspect the prefix
                //System.Diagnostics.Debug.WriteLine(
                //    "Prefix: [" + parts[0] + "]");

                //System.Diagnostics.Debug.WriteLine(
                //    "Prefix length: " + parts[0].Length);

                //            System.Diagnostics.Debug.WriteLine(
                //"Part count: " + parts.Length);

                //            for (int i = 0; i < parts.Length; i++)
                //            {
                //                System.Diagnostics.Debug.WriteLine(
                //                    "Part " + i + " length: " + parts[i].Length);
                //            }

                if (parts.Length != 4 || parts[0] != "PBKDF2-SHA256")
                {
                    return false;
                }
                int iterations;

                if (!int.TryParse(parts[1] , out iterations) || iterations != 200000)
                {
                    return false;
                }

                byte[] salt = Convert.FromBase64String(parts[2]);

                byte[] expectedHash = Convert.FromBase64String(parts[3]);

                if(salt.Length != 16 || expectedHash.Length != 32)
                {
                    return false;
                }

                using (Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(
                    pin , salt , iterations , HashAlgorithmName.SHA256
                    ))
                {
                    byte[] actualHash = pbkdf2.GetBytes(32);
                    int difference = 0;

                    for(int i=0; i< expectedHash.Length; i++)
                    {
                        difference |= expectedHash[i] ^ actualHash[i];
                    }
                    return difference == 0;
                }
            }
            catch(FormatException)
            {
                return false;
            }
            catch(ArgumentException)
            {
                return false;
            }
        }

        private void RedirectByRole()
        {
            string role = Convert.ToString(Session["Role"]);

            if(role  == "Admin")
            {
                Response.Redirect("~/AdminDashboard.aspx", false);

            }
            else if (role == "Teacher")
                {
                Response.Redirect("~/TeacherDashboard.aspx", false);

                }
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}