
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Attendance_Management_System
{
    public partial class AdminTeacherApproval : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["StudentAttendanceConnection"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only an authenticated Admin may open this page.
            if (!IsAdmin())
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadPendingTeachers();
            }
        }

        private bool IsAdmin()
        {
            return Session["UserId"] != null &&
                   Convert.ToString(Session["Role"]) == "Admin";
        }

        private void LoadPendingTeachers()
        {
            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                {
                    string query = @"
                        SELECT UserId, FullName, Email, Username, CreatedAt
                        FROM dbo.Users
                        WHERE Role = @Role
                          AND ApprovalStatus = @Status
                        ORDER BY CreatedAt ASC;";

                    using (SqlCommand command =
                        new SqlCommand(query, connection))
                    {
                        command.Parameters.Add(
                            "@Role", SqlDbType.NVarChar, 20).Value =
                            "Teacher";

                        command.Parameters.Add(
                            "@Status", SqlDbType.NVarChar, 20).Value =
                            "Pending";

                        using (SqlDataAdapter adapter =
                            new SqlDataAdapter(command))
                        {
                            DataTable table = new DataTable();
                            adapter.Fill(table);

                            gvTeachers.DataSource = table;
                            gvTeachers.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                lblMessage.Text =
                    "Unable to load teacher requests. Please try again.";
            }
        }

        protected void gvTeachers_RowCommand(
            object sender, GridViewCommandEventArgs e)
        {
            // Recheck authorization when an action is submitted.
            if (!IsAdmin())
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string newStatus;

            if (e.CommandName == "ApproveTeacher")
            {
                newStatus = "Approved";
            }
            else if (e.CommandName == "RejectTeacher")
            {
                newStatus = "Rejected";
            }
            else
            {
                return;
            }

            int teacherId;

            if (!int.TryParse(
                Convert.ToString(e.CommandArgument), out teacherId))
            {
                lblMessage.Text = "Invalid teacher selection.";
                return;
            }

            int adminId = Convert.ToInt32(Session["UserId"]);

            try
            {
                using (SqlConnection connection =
                    new SqlConnection(ConnectionString))
                {
                    string query = @"
                        UPDATE dbo.Users
                        SET ApprovalStatus = @Status,
                            ApprovedByUserId = @AdminId,
                            ApprovedAt =
                                CASE
                                    WHEN @Status = 'Approved'
                                    THEN GETDATE()
                                    ELSE NULL
                                END
                        WHERE UserId = @TeacherId
                          AND Role = 'Teacher'
                          AND ApprovalStatus = 'Pending';";

                    using (SqlCommand command =
                        new SqlCommand(query, connection))
                    {
                        command.Parameters.Add(
                            "@Status", SqlDbType.NVarChar, 20).Value =
                            newStatus;

                        command.Parameters.Add(
                            "@AdminId", SqlDbType.Int).Value =
                            adminId;

                        command.Parameters.Add(
                            "@TeacherId", SqlDbType.Int).Value =
                            teacherId;

                        connection.Open();

                        int rowsUpdated = command.ExecuteNonQuery();

                        if (rowsUpdated == 1)
                        {
                            lblMessage.Text = newStatus == "Approved"
                                ? "Teacher approved successfully."
                                : "Teacher rejected successfully.";
                        }
                        else
                        {
                            lblMessage.Text =
                                "This request was already processed " +
                                "or is no longer available.";
                        }
                    }
                }

                // Refresh the list so processed requests disappear.
                LoadPendingTeachers();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                lblMessage.Text =
                    "Unable to update the teacher request. Please try again.";
            }
        }
    }
}
