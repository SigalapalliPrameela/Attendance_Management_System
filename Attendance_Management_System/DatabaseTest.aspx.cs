using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


namespace Attendance_Management_System
{
    public partial class DatabaseTest : System.Web.UI.Page
    {
        //protected void Page_Load(object sender, EventArgs e)
        //{

        //}
        protected void btnTestConnection_Click(object sender, EventArgs e)
        {

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["StudentAttendanceConnection"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand("Select DB_NAME()", connection))
                    {
                        string databaseName = command.ExecuteScalar().ToString();

                        lblResult.Text = "Connection Successfull" + databaseName;
                        lblResult.ForeColor = System.Drawing.Color.Green;
                    }
                }

            }

            catch (Exception ex)
            {
                lblResult.Text = "Connection Failed" + Server.HtmlEncode(ex.Message);

                lblResult.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}