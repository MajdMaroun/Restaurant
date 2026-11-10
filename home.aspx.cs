using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication11
{
    public partial class home : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT CategoryID, Name, Description FROM MenuCategories", conn);

                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);

                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
        }
    }
}