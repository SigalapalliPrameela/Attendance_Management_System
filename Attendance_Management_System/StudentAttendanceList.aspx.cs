using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace Attendance_Management_System
{
    public partial class StudentAttendanceList : System.Web.UI.Page
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
                LoadDepartments();
            }
        }

        private bool IsAuthorized()
        {
            if (Session["UserId"] == null)
            {
                return false;

            }

            string role = Convert.ToString(Session["Role"]);

            if (role == "Admin")
            {
                return true;
            }

            if(role != "Teacher")
            {
                return false;
            }

            // check approvsl status against the database rather than only trusting session alone

            try
            {
                using(SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    string query = @"Select ApprovalStatus from Users where UserId=@UserId and Role='Teacher';";

                    using(SqlCommand command = new SqlCommand(query,connection))
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

        private void LoadDepartments()
        {
            try
            {
                using(SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    string query = @"Select DepartmentId , DepartmentName from Departments where IsActive = 1 order by DepartmentName;";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        using(SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable table = new DataTable();
                            adapter.Fill(table);

                            ddlDepartment.DataSource = table;
                            ddlDepartment.DataTextField = "DepartmentName";
                            ddlDepartment.DataValueField = "DepartmentId";
                            ddlDepartment.DataBind();
                        }
                    }
                }

                ddlDepartment.Items.Insert(0, new ListItem("Select Department", ""));

                lblMessage.Text = "";

            }

            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex);
                lblMessage.Text = "Unable to load Departments , Please try again";
            }
        }

        protected void btnViewStudents_Click(object sender , EventArgs e)
        {
            // Recheck authorization for this request.

            if(!IsAuthorized())
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            int departmentId;
            int yearOfStudy;
            if(!int.TryParse(
                ddlDepartment.SelectedValue , out departmentId))
            {
                lblMessage.Text = "Please select a department.";
                gvStudents.DataSource = null;
                gvStudents.DataBind();
                return;
            }

            if(!int.TryParse(ddlYear.SelectedValue, out yearOfStudy) || yearOfStudy < 1 || yearOfStudy > 4)
            {
                lblMessage.Text = "Please select a valid year.";
                gvStudents.DataSource = null;
                gvStudents.DataBind();
                return;

            }

            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    string query = @"Select s.StudentId , s.StudentName , s.RollNumber , d.DepartmentName , s.YearOfStudy from Students as s inner join Departments as d on 
                        s.DepartmentId = d.DepartmentId
                        WHERE s.DepartmentId = @DepartmentId
                          AND s.YearOfStudy = @YearOfStudy
                          AND s.IsActive = 1
                          AND d.IsActive = 1
                        ORDER BY s.RollNumber;";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@DepartmentId", SqlDbType.Int).Value = departmentId;

                        command.Parameters.Add("@YearOfStudy", SqlDbType.Int).Value = yearOfStudy;

                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            DataTable table = new DataTable();
                            adapter.Fill(table);

                            gvStudents.DataSource = table;
                            gvStudents.DataBind();

                            if (table.Rows.Count == 0)
                            {
                                lblMessage.Text = "No students found for the selected Department and Year. ";
                            }
                            else
                            {
                                lblMessage.Text = "Students loaded successfully.";
                            }

                        }
                    }
                }
            }
            catch (Exception ex) 
            {
                System.Diagnostics.Debug.WriteLine(ex);
                gvStudents.DataSource = null;
                gvStudents.DataBind();

                lblMessage.Text = "Unable to load students , Please try again.";
            }
        }

        protected void gvStudents_RowCommand(object sender , GridViewCommandEventArgs e)
        {
            if (e.CommandName != "MarkAttendance")
                return;

            if(!IsAuthorized())
            {
                Response.Redirect("~/Login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            int studentId;

            if(!int.TryParse(Convert.ToString(e.CommandArgument),out studentId) || studentId <=0)
            {
                lblMessage.Text = "Invalid student selection";
                return;
            }

            // Pass only the student ID , next page will retireve the students detials from the database
            Response.Redirect(
                "~/MarkAttendance.aspx?StudentId=" + studentId
            );
        }

        protected void gvStudents_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}