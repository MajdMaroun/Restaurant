using System;

namespace WebApplication11
{
    public partial class AdminHome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminID"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("AdminLogin.aspx");
        }
    }
}