using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication11
{
    public partial class Categories : System.Web.UI.Page
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
                LoadCategories();
            }
        }

        void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM MenuCategories", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvCategories.DataSource = dt;
                gvCategories.DataBind();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO MenuCategories (Name, Description) VALUES (@n, @d)", con);

                cmd.Parameters.AddWithValue("@n", txtName.Text);
                cmd.Parameters.AddWithValue("@d", txtDescription.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadCategories();
        }

        protected void gvCategories_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCat")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    SqlCommand cmd1 = new SqlCommand(
                        "DELETE FROM MenuItems WHERE CategoryID=@id", con);
                    cmd1.Parameters.AddWithValue("@id", id);
                    cmd1.ExecuteNonQuery();

                    SqlCommand cmd2 = new SqlCommand(
                        "DELETE FROM MenuCategories WHERE CategoryID=@id", con);
                    cmd2.Parameters.AddWithValue("@id", id);
                    cmd2.ExecuteNonQuery();
                }

                LoadCategories();
            }
        }
    }
}