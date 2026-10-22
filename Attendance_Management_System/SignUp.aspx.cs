using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text.RegularExpressions;

namespace Attendance_Management_System
{
    public partial class SignUp : System.Web.UI.Page
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

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            lblResult.Text = "";

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string pin = txtPin.Text;
            string confirmPin = txtConfirmPin.Text;

            // check the  required fields first

            if (string.IsNullOrWhiteSpace(fullName) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(username) ||
                string.IsNullOrWhiteSpace(pin) ||
                string.IsNullOrWhiteSpace(confirmPin))
            {
                ShowMessage("Please fill in all fields , you are missing them.");
                return;
            }

            // Validate the lingths before we send that data to sql server to store

            if (fullName.Length > 100 || email.Length > 254 || username.Length > 50)
            {
                ShowMessage("One or more fields exceed the allowed length.");
                return;
            }

            // email format validation

            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ShowMessage("Please enter a valid email address.");
                return;
            }

            // now check if the pin contains length between 4 and 20

            if (!Regex.IsMatch(pin, @"^[0-9]{4,20}$"))
            {
                ShowMessage("PIN must be contain 4 to 20 digits.");
                return;
            }

            // Now checking whether the pin and confirm pin matches

            if (pin != confirmPin)
            {
                ShowMessage("PIN and Confirm PIN do not match");
                return;
            }

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                {
                    connection.Open();

                    // 6. Check whether the email or username is already used.
                    string checkQuery = @"
                        SELECT COUNT(1)
                        FROM dbo.Users
                        WHERE Email = @Email
                           OR Username = @Username;";

                    using (SqlCommand checkCommand =
                        new SqlCommand(checkQuery, connection))
                    {
                        checkCommand.Parameters.Add(
                            "@Email", SqlDbType.NVarChar, 254).Value = email;

                        checkCommand.Parameters.Add(
                            "@Username", SqlDbType.NVarChar, 50).Value =
                            username;

                        int existingUsers = Convert.ToInt32(
                            checkCommand.ExecuteScalar());

                        if (existingUsers > 0)
                        {
                            ShowMessage(
                                "This email or username is already registered.");
                            return;
                        }
                    }

                    // 7. Never save the original PIN.
                    string pinHash = HashPin(pin);

                    // 8. New public registrations are always Teachers
                    // and must wait for Admin approval.
                    string insertQuery = @"
                        INSERT INTO dbo.Users
                            (FullName, Email, Username, PinHash,
                             Role, ApprovalStatus, CreatedAt)
                        VALUES
                            (@FullName, @Email, @Username, @PinHash,
                             @Role, @ApprovalStatus, GETDATE());";

                    using (SqlCommand insertCommand =
                        new SqlCommand(insertQuery, connection))
                    {
                        insertCommand.Parameters.Add(
                            "@FullName", SqlDbType.NVarChar, 100).Value =
                            fullName;

                        insertCommand.Parameters.Add(
                            "@Email", SqlDbType.NVarChar, 254).Value =
                            email;

                        insertCommand.Parameters.Add(
                            "@Username", SqlDbType.NVarChar, 50).Value =
                            username;

                        insertCommand.Parameters.Add(
                            "@PinHash", SqlDbType.NVarChar, 500).Value =
                            pinHash;

                        insertCommand.Parameters.Add(
                            "@Role", SqlDbType.NVarChar, 20).Value =
                            "Teacher";

                        insertCommand.Parameters.Add(
                            "@ApprovalStatus", SqlDbType.NVarChar, 20).Value =
                            "Pending";

                        int rowsInserted = insertCommand.ExecuteNonQuery();

                        if (rowsInserted == 1)
                        {
                            ShowMessage(
                                "Registration successful! Your account is " +
                                "pending Admin approval. You can log in " +
                                "after your account is approved.");

                            // Clear the form after successful registration.
                            txtFullName.Text = "";
                            txtEmail.Text = "";
                            txtUsername.Text = "";
                            txtPin.Text = "";
                            txtConfirmPin.Text = "";
                        }
                        else
                        {
                            ShowMessage(
                                "Registration could not be completed. " +
                                "Please try again.");
                        }
                    }
                }
            }
            catch(SqlException ex)
            {
                if(ex.Number==2601 || ex.Number == 2627)
                {
                    ShowMessage("This email or username is already registered");
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine(ex);
                    ShowMessage("A database error occured , Please try again.");
                }
            }

            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                ShowMessage("Registration could not be completed, Please try again.");
            }
        }

        private string HashPin(string pin)
        {
            const int iterations = 200000;

            byte[] salt = new byte[16];

            using(var rng =  RandomNumberGenerator.Create())
            {
                rng.GetBytes(salt);
            }

            byte[] hash;
            using (Rfc2898DeriveBytes pbkdf2 = new Rfc2898DeriveBytes(
                pin,
                salt,
                iterations,
                HashAlgorithmName.SHA256))
            {
                hash = pbkdf2.GetBytes(32);
            }
            return "PBKDF2-SHA256$" + iterations + "$" + Convert.ToBase64String(salt) + "$" + Convert.ToBase64String(hash);

        }

        private void ShowMessage(string message)
        {
            lblResult.Text = message;
        }
    }
}