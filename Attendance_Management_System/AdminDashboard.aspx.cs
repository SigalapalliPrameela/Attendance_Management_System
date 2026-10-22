using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Attendance_Management_System
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check whether the uses has logged in.

            if (Session["UserId"] == null)
            {
                RedirectTo("~/Login.aspx");
                return;
            }

            // Only Admin users can access this page right

            string role = Convert.ToString(Session["Role"]);

            if(role != "Admin")
            {
                if(role == "Teacher")
                {
                    RedirectTo("~/TeacherDashboard.aspx");
                }
                else
                {
                    RedirectTo("~/Login.aspx");
                }
                return;
            }

            // Populate the dashboard only on first load
            if(!IsPostBack)
            {
                string fullName = Convert.ToString(Session["FullName"]);

                lblWelcome.Text = "Welcome, " + fullName + "!";
                lblDate.Text = DateTime.Now.ToString("dd MMMM yyyy");
                lblRole.Text = "Your Role : Admin";

                lblStatus.Text = "Teacher approval and attendance management modules will be added next";

            }
        }

        protected void btnLogout_Click(object sender , EventArgs e)
        {
            // Remove the current user's session information

            Session.Clear();
            Session.Abandon();

            RedirectTo("~/Login.aspx");
        }

        private void RedirectTo(string url)
        {
            Response.Redirect(url, false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}