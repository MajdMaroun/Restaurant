using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication11
{
    public partial class Customers : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["adminID"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCustomers();
            }
        }

        void LoadCustomers()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM Customers", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvCustomers.DataSource = dt;
                gvCustomers.DataBind();
            }
        }

        protected void gvCustomers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                if (e.CommandName == "Unlock")
                {
                    SqlCommand cmd = new SqlCommand(@"
                UPDATE Customers
                SET IsLocked = 0,
                    FailedAttempts = 0,
                    LockedUntil = NULL
                WHERE CustomerID = @id", con);

                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
                else if (e.CommandName == "Lock")
                {
                    SqlCommand cmd = new SqlCommand(@"
                UPDATE Customers
                SET IsLocked = 1,
                    LockedUntil = DATEADD(HOUR, 3, GETDATE())
                WHERE CustomerID = @id", con);

                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadCustomers();
        }
    }
}