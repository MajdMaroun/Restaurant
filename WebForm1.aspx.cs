using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication11
{
    public partial class WebForm1 : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenu();
            }

            if (Session["SnackMessage"] != null)
            {
                string msg = Session["SnackMessage"].ToString();
                if (msg == "added")
                    hdnMessage.Value = "✓ Item added to cart!";
                else if (msg == "notloggedin")
                    hdnMessage.Value = "Please login to add items to your cart.";
                Session.Remove("SnackMessage");
            }
        }

        private void LoadMenu()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand catCmd = conn.CreateCommand();
                catCmd.CommandText = "SELECT CategoryID, Name FROM MenuCategories ORDER BY CategoryID";
                DataTable catTable = new DataTable();
                new SqlDataAdapter(catCmd).Fill(catTable);

                rptCatNav.DataSource = catTable;
                rptCatNav.DataBind();

                rptCategories.DataSource = catTable;
                rptCategories.DataBind();

                foreach (RepeaterItem catItem in rptCategories.Items)
                {
                    int categoryID = Convert.ToInt32(catTable.Rows[catItem.ItemIndex]["CategoryID"]);

                    SqlCommand itemCmd = conn.CreateCommand();
                    itemCmd.CommandText = "SELECT ItemID, Name, Description, Price FROM MenuItems WHERE CategoryID = @CatID AND IsAvailable = 1";
                    itemCmd.Parameters.AddWithValue("@CatID", categoryID);

                    DataTable itemTable = new DataTable();
                    new SqlDataAdapter(itemCmd).Fill(itemTable);

                    Repeater rptItems = (Repeater)catItem.FindControl("rptItems");
                    rptItems.DataSource = itemTable;
                    rptItems.DataBind();
                }
            }
        }

        protected void AddToCart_Command(object sender, CommandEventArgs e)
        {
            int itemID = Convert.ToInt32(e.CommandArgument);

            if (Session["CustomerID"] == null)
            {
                Session["SnackMessage"] = "notloggedin";
                Response.Redirect(Request.Url.AbsoluteUri);
                return;
            }

            int customerID = Convert.ToInt32(Session["CustomerID"]);

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand getCart = conn.CreateCommand();
                getCart.CommandText = "SELECT CartID FROM Cart WHERE CustomerID = @CID";
                getCart.Parameters.AddWithValue("@CID", customerID);
                object cartObj = getCart.ExecuteScalar();

                int cartID;
                if (cartObj == null)
                {
                    SqlCommand createCart = conn.CreateCommand();
                    createCart.CommandText = "INSERT INTO Cart (CustomerID) VALUES (@CID); SELECT SCOPE_IDENTITY()";
                    createCart.Parameters.AddWithValue("@CID", customerID);
                    cartID = Convert.ToInt32(createCart.ExecuteScalar());
                }
                else
                {
                    cartID = Convert.ToInt32(cartObj);
                }

                SqlCommand checkItem = conn.CreateCommand();
                checkItem.CommandText = "SELECT CartItemID, Quantity FROM CartItems WHERE CartID = @CartID AND ItemID = @ItemID";
                checkItem.Parameters.AddWithValue("@CartID", cartID);
                checkItem.Parameters.AddWithValue("@ItemID", itemID);
                SqlDataReader reader = checkItem.ExecuteReader();

                if (reader.Read())
                {
                    int cartItemID = Convert.ToInt32(reader["CartItemID"]);
                    int newQty = Convert.ToInt32(reader["Quantity"]) + 1;
                    reader.Close();

                    SqlCommand updateQty = conn.CreateCommand();
                    updateQty.CommandText = "UPDATE CartItems SET Quantity = @Qty WHERE CartItemID = @ID";
                    updateQty.Parameters.AddWithValue("@Qty", newQty);
                    updateQty.Parameters.AddWithValue("@ID", cartItemID);
                    updateQty.ExecuteNonQuery();
                }
                else
                {
                    reader.Close();

                    SqlCommand insertItem = conn.CreateCommand();
                    insertItem.CommandText = "INSERT INTO CartItems (CartID, ItemID, Quantity) VALUES (@CartID, @ItemID, 1)";
                    insertItem.Parameters.AddWithValue("@CartID", cartID);
                    insertItem.Parameters.AddWithValue("@ItemID", itemID);
                    insertItem.ExecuteNonQuery();
                }
            }

            Session["SnackMessage"] = "added";
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}