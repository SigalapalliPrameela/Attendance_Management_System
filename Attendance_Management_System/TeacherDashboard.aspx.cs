using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Attendance_Management_System
{
    public partial class TeacherDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Require a logged-in user

            if (Session["UserID"] == null)
            {
                RedirectTo("~/Login.aspx");
                return;
            }

            // Only Teachers can access this dashboard

            string role = Convert.ToString(Session["Role"]);
            if(role!="Teacher")
            {
                if(role=="Admin")
                {
                    RedirectTo("~/AdminDashboard.aspx");
                }

                else
                {
                    RedirectTo("~/Login.aspx");
                }
                return;
            }

            // Display tracher information on first load

            if(!IsPostBack)
            {
                string fullName = Convert.ToString(Session["FullName"]);

                lblWelcome.Text = "Welcome, " + fullName + "!";

                lblDate.Text = "Date:" + DateTime.Now.ToString("dd MMMM yyyy");
                lblRole.Text = "Your role: Teacher";

                lblStatus.Text = "You can manage attendance after you account has been approved by the Admin";
            }
        }

        protected void btnLogout_Click(object sender , EventArgs e )
        {
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