using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Xml.Linq;

namespace WebApplication11
{
    public partial class AdminMenu : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

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
                LoadItems();
            }
        }

        void LoadCategories()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT CategoryID, Name FROM MenuCategories", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlCategory.DataSource = dt;
                ddlCategory.DataTextField = "Name";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();
            }
        }

        void LoadItems()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        MenuItems.ItemID,
                        MenuItems.Name,
                        MenuItems.Description,
                        MenuItems.Price,
                        MenuCategories.Name AS CategoryName
                    FROM MenuItems
                    INNER JOIN MenuCategories
                    ON MenuItems.CategoryID = MenuCategories.CategoryID";

                SqlDataAdapter da = new SqlDataAdapter(query, con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvItems.DataSource = dt;
                gvItems.DataBind();
            }
        }

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO MenuItems 
                    (CategoryID, Name, Description, Price)
                    VALUES (@cat, @name, @desc, @price)", con);

                cmd.Parameters.AddWithValue("@cat", ddlCategory.SelectedValue);
                cmd.Parameters.AddWithValue("@name", txtName.Text);
                cmd.Parameters.AddWithValue("@desc", txtDescription.Text);
                cmd.Parameters.AddWithValue("@price", txtPrice.Text);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadItems();
        }
    }
}