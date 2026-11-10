using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication11
{
    public partial class OrderConfirmation : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;
        private int orderID;

        protected void Page_Load(object sender, EventArgs e)
        {
            // redirect if no order ID in URL
            if (string.IsNullOrWhiteSpace(Request.QueryString["orderID"]))
            {
                Response.Redirect("Home.aspx");
                return;
            }

            orderID = Convert.ToInt32(Request.QueryString["orderID"]);

            if (!IsPostBack)
            {
                LoadConfirmation();
            }
        }

        private void LoadConfirmation()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // get order details
                SqlCommand orderCmd = conn.CreateCommand();
                orderCmd.CommandText = @"
                    SELECT o.OrderID, o.OrderDate, o.TotalPrice, o.DeliveryType, o.DeliveryAddress,
                           c.Email, c.FirstName
                    FROM Orders o
                    JOIN Customers c ON o.CustomerID = c.CustomerID
                    WHERE o.OrderID = @OrderID";
                orderCmd.Parameters.AddWithValue("@OrderID", orderID);

                SqlDataReader reader = orderCmd.ExecuteReader();

                if (!reader.Read())
                {
                    Response.Redirect("Home.aspx");
                    return;
                }

                lblOrderID.Text = "#" + reader["OrderID"].ToString();
                lblDate.Text = Convert.ToDateTime(reader["OrderDate"]).ToString("MMM dd, yyyy hh:mm tt");
                lblDeliveryType.Text = reader["DeliveryType"].ToString();
                lblEmail.Text = reader["Email"].ToString();

                if (reader["DeliveryType"].ToString() == "Delivery" && reader["DeliveryAddress"] != DBNull.Value)
                {
                    lblAddress.Text = reader["DeliveryAddress"].ToString();
                    pnlAddress.Visible = true;
                }

                reader.Close();

                // get order items
                SqlCommand itemsCmd = conn.CreateCommand();
                itemsCmd.CommandText = @"
                    SELECT mi.Name, oi.Quantity,
                           CAST(oi.UnitPrice * oi.Quantity AS DECIMAL(10,2)) AS Subtotal
                    FROM OrderItems oi
                    JOIN MenuItems mi ON oi.ItemID = mi.ItemID
                    WHERE oi.OrderID = @OrderID";
                itemsCmd.Parameters.AddWithValue("@OrderID", orderID);

                DataTable dt = new DataTable();
                new SqlDataAdapter(itemsCmd).Fill(dt);

                // add total row
                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                    total += Convert.ToDecimal(row["Subtotal"]);

                DataRow totalRow = dt.NewRow();
                totalRow["Name"] = "TOTAL";
                totalRow["Quantity"] = DBNull.Value;
                totalRow["Subtotal"] = total;
                dt.Rows.Add(totalRow);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // check order status first
                SqlCommand checkCmd = conn.CreateCommand();
                checkCmd.CommandText = "SELECT Status FROM Orders WHERE OrderID = @OrderID";
                checkCmd.Parameters.AddWithValue("@OrderID", orderID);
                string status = checkCmd.ExecuteScalar().ToString();

                if (status != "Pending")
                {
                    lblError.Text = "This order can no longer be cancelled.";
                    lblError.Visible = true;
                    return;
                }

                // delete order items
                SqlCommand deleteItems = conn.CreateCommand();
                deleteItems.CommandText = "DELETE FROM OrderItems WHERE OrderID = @OrderID";
                deleteItems.Parameters.AddWithValue("@OrderID", orderID);
                deleteItems.ExecuteNonQuery();

                // delete order
                SqlCommand deleteOrder = conn.CreateCommand();
                deleteOrder.CommandText = "DELETE FROM Orders WHERE OrderID = @OrderID";
                deleteOrder.Parameters.AddWithValue("@OrderID", orderID);
                deleteOrder.ExecuteNonQuery();
            }

            Response.Redirect("Home.aspx");
        }
    }
}