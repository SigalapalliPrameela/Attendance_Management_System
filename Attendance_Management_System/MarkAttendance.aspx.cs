using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Attendance_Management_System
{
    public partial class MarkAttendance : System.Web.UI.Page
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
            if(!IsAuthorized())
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if(!IsPostBack)
            {
                LoadStudentDetails();
            }

        }

        private bool IsAuthorized()
        {
            if (Session["UserId"] == null)
            {
                return false;
            }

            string role = Convert.ToString(Session["Role"]);

            if(role=="Admin")
            {
                return true;
            }

            if(role!="Teacher")
            {
                return false;
            }

            try
            {
                using(SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    string query = @"SELECT ApprovalStatus FROM dbo.Users WHERE UserId = @UserId AND Role = 'Teacher';";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@UserId", SqlDbType.Int).Value = Convert.ToInt32(Session["UserId"]);

                        connection.Open();

                        object result = command.ExecuteScalar();

                        return result != null && result != DBNull.Value && Convert.ToString(result) == "Approved";
                    }



                }
            }

            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                return false;
            }
        }

        private void LoadStudentDetails()
        {
            int studentId;

            if (!int.TryParse(Request.QueryString["StudentId"], out studentId) || studentId <= 0)
            {
                ShowError("Invalid student selection");
                DisableAttendanceControls();
                return;
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    string query = @"Select s.studentId , s.StudentName , S.RollNumber , d.DepartmentName , s.YearOfStudy from Students as s inner join Departments as d on s.DepartmentId = d.DepartmentId where s.StudentId= @StudentId and s.IsActive =1 and d.IsActive =1;";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@StudentId", SqlDbType.Int).Value = studentId;

                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblStudentName.Text = Convert.ToString(reader["StudentName"]);

                                lblRollNumber.Text = Convert.ToString(reader["RollNumber"]);

                                lblDepartment.Text = Convert.ToString(reader["DepartmentName"]);

                                lblYear.Text = Convert.ToString(reader["YearOfStudy"]);

                                lblAttendanceDate.Text = DateTime.Today.ToString("dd-MM-yyyy");

                                if (AttendanceAlreadyExists(studentId))
                                {
                                    ShowDuplicateAttendancePopup();
                                    DisableAttendanceControls();
                                }
                            }

                            else
                            {
                                ShowError(
                                    "Student not found or is inactive.");

                                DisableAttendanceControls();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                ShowError("Unable to load student details , please try again.");

                DisableAttendanceControls();

            }
        }

        private void ShowDuplicateAttendancePopup()
        {
            string message = "Attendance Already Submitted for today";

            ClientScript.RegisterStartupScript(
                GetType(),
                "DuplicateAttendance",
                "alert('" + message + "');",
                true
            );
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
        }

        private void DisableAttendanceControls()
        {
            rblAttendanceStatus.Enabled = false;
            btnSubmitAttendance.Enabled = false;
        }


        private bool AttendanceAlreadyExists(int studentId)
        {
            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                {
                    string query = @"
                SELECT COUNT(1)
                FROM dbo.Attendance
                WHERE StudentId = @StudentId
                  AND AttendanceDate = @AttendanceDate;";

                    using (SqlCommand command =
                        new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@StudentId", SqlDbType.Int)
                            .Value = studentId;

                        command.Parameters.Add("@AttendanceDate", SqlDbType.Date)
                            .Value = DateTime.Today;

                        connection.Open();

                        return Convert.ToInt32(command.ExecuteScalar()) > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                ShowError(
                    "Unable to check existing attendance. Please try again.");

                DisableAttendanceControls();

                return true;
            }
        }



        protected void btnSubmitAttendance_Click(object sender, EventArgs e)
        {
            if (!IsAuthorized())
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            int studentId;

            if (!int.TryParse(Request.QueryString["StudentId"], out studentId)
                || studentId <= 0)
            {
                ShowError("Invalid student selection.");
                DisableAttendanceControls();
                return;
            }

            string status = rblAttendanceStatus.SelectedValue;

            if (status != "Present" && status != "Absent")
            {
                ShowError("Please select Present or Absent.");
                return;
            }

            int markedByUserId = Convert.ToInt32(Session["UserId"]);
            DateTime attendanceDate = DateTime.Today;

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                {
                    connection.Open();

                    // Check whether attendance has already been submitted.
                    string checkQuery = @"
                SELECT COUNT(1)
                FROM dbo.Attendance
                WHERE StudentId = @StudentId
                  AND AttendanceDate = @AttendanceDate;";

                    using (SqlCommand checkCommand =
                        new SqlCommand(checkQuery, connection))
                    {
                        checkCommand.Parameters.Add("@StudentId", SqlDbType.Int)
                            .Value = studentId;

                        checkCommand.Parameters.Add("@AttendanceDate", SqlDbType.Date)
                            .Value = attendanceDate;

                        int existingRecords =
                            Convert.ToInt32(checkCommand.ExecuteScalar());

                        if (existingRecords > 0)
                        {
                            ShowDuplicateAttendancePopup();
                            DisableAttendanceControls();
                            return;
                        }
                    }

                    // Save the attendance record.
                    string insertQuery = @"
                INSERT INTO dbo.Attendance
                    (StudentId, AttendanceDate, AttendanceStatus,
                     MarkedByUserId, CreatedAt)
                VALUES
                    (@StudentId, @AttendanceDate, @AttendanceStatus,
                     @MarkedByUserId, @CreatedAt);";

                    using (SqlCommand insertCommand =
                        new SqlCommand(insertQuery, connection))
                    {
                        insertCommand.Parameters.Add("@StudentId", SqlDbType.Int)
                            .Value = studentId;

                        insertCommand.Parameters.Add("@AttendanceDate", SqlDbType.Date)
                            .Value = attendanceDate;

                        insertCommand.Parameters.Add("@AttendanceStatus", SqlDbType.VarChar, 10)
                            .Value = status;

                        insertCommand.Parameters.Add("@MarkedByUserId", SqlDbType.Int)
                            .Value = markedByUserId;

                        insertCommand.Parameters.Add("@CreatedAt", SqlDbType.DateTime)
                            .Value = DateTime.Now;

                        insertCommand.ExecuteNonQuery();
                    }

                    ShowError("Attendance submitted successfully.");

                    rblAttendanceStatus.Enabled = false;
                    btnSubmitAttendance.Enabled = false;
                }
            }
            catch (SqlException ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                if (ex.Number == 2601 || ex.Number == 2627)
                {
                    ShowDuplicateAttendancePopup();
                    DisableAttendanceControls();
                }
                else
                {
                    ShowError(
                        "Unable to submit attendance. Please try again.");
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);

                ShowError(
                    "Unable to submit attendance. Please try again.");
            }
        }

    }
}