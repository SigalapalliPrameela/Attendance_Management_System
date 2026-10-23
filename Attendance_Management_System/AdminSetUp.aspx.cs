using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Security.Cryptography;
using System.Net.Mail;

namespace Attendance_Management_System
{
    public partial class AdminSetUp : System.Web.UI.Page
    {
        private const int Pbkdf2Iterations = 200000;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Request.IsLocal)
            {
                btnCreateAdmin.Enabled = false;
                lblResult.Text = "Admin setup is available only for the local machine ";
                return;
            }

            if(!IsPostBack && AdminExists())
            {
                btnCreateAdmin.Enabled = false;
                lblResult.Text = "an Admin account already exists . Setup is disabled";
            }
        }
        private bool AdminExists()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["StudentAttendanceConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("SELECT COUNT(1) FROM Users WHERE Role = @Role", connection))
                {
                    command.Parameters.AddWithValue("@Role", "Admin");

                    connection.Open();

                    return Convert.ToInt32(command.ExecuteScalar()) > 0;
                }
            }
        }

        private string HashPin(string pin)
        {
            byte[] salt = new byte[16];  // 16 byte array to store the random number 

            using(var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);  // now the salt is filled with some random number which is generated 
            }

            byte[] hash;

            using (Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(
                pin,
                salt,
                Pbkdf2Iterations,
                HashAlgorithmName.SHA256
                ))
            {
                hash = pbkdf2.GetBytes(32);  //  here it derives 32 bytes of data
            }
            return "PBKDF2-SHA256$" + Pbkdf2Iterations + "$" + Convert.ToBase64String(salt) + "$" + Convert.ToBase64String(hash);
        }

        protected void btnCreateAdmin_Click(object sender , EventArgs e)
        {
            lblResult.Text = "";

            // Check if it is local machine only
            if(!Request.IsLocal)
            {
                btnCreateAdmin.Enabled = false;
                lblResult.Text = "Admin Setup is available only on the local machine";
                return;
            }
            //Security check 2 : there should be only one admin , so never create another one

            try
            {
                if(AdminExists())
                {
                    btnCreateAdmin.Enabled = false;  // the submit button is disabled means it is not active to click
                    lblResult.Text = "An Admin already exists / Setup is disabled";
                    return;
                }
            }
            catch(Exception)
            {
                lblResult.Text = "Unable to verify the Admin account. Check the database connection";
                return;

            }

            string fullName = txtfullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string pin = txtPin.Text;
            string confirmPin = txtConfirmPin.Text;

            if(string.IsNullOrWhiteSpace(fullName)
                ||string.IsNullOrWhiteSpace(email)
                ||string.IsNullOrWhiteSpace(username)
                || string.IsNullOrWhiteSpace(pin)
                ||string.IsNullOrWhiteSpace(confirmPin))
            {
                lblResult.Text = "All fields are required";
                return;
            }

            if(fullName.Length > 100 || email.Length >256 || username.Length > 50)
            {
                lblResult.Text = "One ore more fields are too long.";
                return;
            }
            try
            {
                MailAddress parsedEmail = new MailAddress(email);
                if(!string.Equals(parsedEmail.Address , email , StringComparison.OrdinalIgnoreCase))
                {
                    lblResult.Text = "Enter a valid email Address.";
                    return;
                }
            }
            catch(FormatException)
            {
                lblResult.Text = "Enter Valid Email address.";
                return;
            }

            if(!Regex.IsMatch(username , @"^[A-Za-z0-9_.-]{3,50}$"))
            {
                lblResult.Text = "Username must be 3-50 characters and use letters, numbers , dots , underscores , or hyphens.";
                return;
            }

            if(!Regex.IsMatch(pin,@"^\d{4,20}$"))
            {
                lblResult.Text = "Pin must contain 4-20 digits. A longer Pin is recommended for more security.";
                return;
            }
            if(pin != confirmPin)
            {
                lblResult.Text = "Pins do not match , Please check both pin and confirm pin should be same";
                return;
            }

            string pinHash = HashPin(pin);

            string connectionString = ConfigurationManager.ConnectionStrings["StudentAttendanceConnection"].ConnectionString;

            try
            {
                using(SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    // Recheck the Admin and insert within one transaction

                    using (SqlTransaction transaction = connection.BeginTransaction(System.Data.IsolationLevel.Serializable))
                    {
                        try
                        {
                            using (SqlCommand checkCommand = new SqlCommand(@"SELECT COUNT(1)
                             FROM dbo.Users WITH (UPDLOCK, HOLDLOCK)
                             WHERE Role = @Role",connection, transaction))
                            {
                                checkCommand.Parameters.AddWithValue("@Role", "Admin");

                                if (Convert.ToInt32(checkCommand.ExecuteScalar()) > 0)
                                {
                                    transaction.Rollback();
                                    btnCreateAdmin.Enabled = false;
                                    lblResult.Text = "An admin already exists , So Setup is disabled";
                                    return;
                                }
                            }
                            string insertSql = @"Insert into Users(FullName , Email , Username, PinHash , Role , ApprovalStatus) values (@FullName , @Email , @Username, @PinHash , @Role , @ApprovalStatus);";

                            using(SqlCommand insertCommand = new SqlCommand(insertSql , connection , transaction))
                            {
                                insertCommand.Parameters.AddWithValue("@FullName", fullName);
                                insertCommand.Parameters.AddWithValue("@Email", email);
                                insertCommand.Parameters.AddWithValue("@Username", username);
                                insertCommand.Parameters.AddWithValue("@PinHash", pinHash);
                                insertCommand.Parameters.AddWithValue("@Role", "Admin");
                                insertCommand.Parameters.AddWithValue("@ApprovalStatus", "Approved");
                                insertCommand.ExecuteNonQuery();
                            }

                            transaction.Commit();
                        }
                        catch
                        {
                            transaction.Rollback();
                            throw;
                        }
                        
                    }
                }
                lblResult.Text =
                    "Admin account created successfully. Remove the setup page now.";
                btnCreateAdmin.Enabled = false;

                // Clear the PINs from the server-side controls.
                txtPin.Text = "";
                txtConfirmPin.Text = "";
            }

            catch(SqlException ex)
            {

                System.Diagnostics.Debug.WriteLine(
        "SQL ERROR: " + ex.ToString());
                // 2601 and 2627 are duplicate-key errors.
                if (ex.Number == 2601 || ex.Number == 2627)
                {
                    lblResult.Text =
                        "That email or username already exists. Check the existing records.";
                }
                else
                {
                    lblResult.Text =
                        "The Admin account could not be created. Check the database configuration.";
                }
            }
            catch (Exception ex)
            {
                lblResult.Text =
                    "The Admin account could not be created. Please check the application configuration.";

                System.Diagnostics.Debug.WriteLine(
        "ADMIN SETUP ERROR: " + ex.ToString());

                lblResult.Text =
                    "Admin creation failed. Check Visual Studio Output for details.";
            }
        }


    }
}