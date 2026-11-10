using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication11
{
    public partial class Order : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            if (Session["CustomerID"] == null)
            {
                pnlNotLoggedIn.Visible = true;
                pnlCart.Visible = false;
                return;
            }

            pnlNotLoggedIn.Visible = false;
            pnlCart.Visible = true;

            int customerID = Convert.ToInt32(Session["CustomerID"]);

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand getCart = conn.CreateCommand();
                getCart.CommandText = "SELECT CartID FROM Cart WHERE CustomerID = @CID";
                getCart.Parameters.AddWithValue("@CID", customerID);
                object cartObj = getCart.ExecuteScalar();

                if (cartObj == null)
                {
                    pnlEmpty.Visible = true;
                    pnlItems.Visible = false;
                    return;
                }

                int cartID = Convert.ToInt32(cartObj);

                SqlCommand itemsCmd = conn.CreateCommand();
                itemsCmd.CommandText = @"
                    SELECT
                        ci.CartItemID,
                        mi.Name,
                        ci.Quantity,
                        CAST(mi.Price * ci.Quantity AS DECIMAL(10,2)) AS Subtotal
                    FROM CartItems ci
                    JOIN MenuItems mi ON ci.ItemID = mi.ItemID
                    WHERE ci.CartID = @CartID";
                itemsCmd.Parameters.AddWithValue("@CartID", cartID);

                DataTable dt = new DataTable();
                new SqlDataAdapter(itemsCmd).Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlEmpty.Visible = true;
                    pnlItems.Visible = false;
                    return;
                }

                pnlEmpty.Visible = false;
                pnlItems.Visible = true;

                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                    total += Convert.ToDecimal(row["Subtotal"]);

                DataRow totalRow = dt.NewRow();
                totalRow["Name"] = "TOTAL";
                totalRow["CartItemID"] = DBNull.Value;
                totalRow["Quantity"] = DBNull.Value;
                totalRow["Subtotal"] = total;
                dt.Rows.Add(totalRow);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                int cartItemID = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(cs))
                {
                    conn.Open();
                    SqlCommand cmd = conn.CreateCommand();
                    cmd.CommandText = "DELETE FROM CartItems WHERE CartItemID = @ID";
                    cmd.Parameters.AddWithValue("@ID", cartItemID);
                    cmd.ExecuteNonQuery();
                }

                LoadCart();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            int customerID = Convert.ToInt32(Session["CustomerID"]);

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand getCart = conn.CreateCommand();
                getCart.CommandText = "SELECT CartID FROM Cart WHERE CustomerID = @CID";
                getCart.Parameters.AddWithValue("@CID", customerID);
                object cartObj = getCart.ExecuteScalar();

                if (cartObj != null)
                {
                    int cartID = Convert.ToInt32(cartObj);
                    SqlCommand clear = conn.CreateCommand();
                    clear.CommandText = "DELETE FROM CartItems WHERE CartID = @CartID";
                    clear.Parameters.AddWithValue("@CartID", cartID);
                    clear.ExecuteNonQuery();
                }
            }

            LoadCart();
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            if (Session["CustomerID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string deliveryType = hdnDeliveryType.Value;
            string address = txtAddress.Text.Trim();

            // validate address for delivery
            if (deliveryType == "Delivery" && string.IsNullOrWhiteSpace(address))
            {
                lblError.Text = "Please enter a delivery address.";
                lblError.Visible = true;
                return;
            }

            lblError.Visible = false;

            int customerID = Convert.ToInt32(Session["CustomerID"]);

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                SqlCommand getCart = conn.CreateCommand();
                getCart.CommandText = "SELECT CartID FROM Cart WHERE CustomerID = @CID";
                getCart.Parameters.AddWithValue("@CID", customerID);
                object cartObj = getCart.ExecuteScalar();

                if (cartObj == null) return;
                int cartID = Convert.ToInt32(cartObj);

                SqlCommand itemsCmd = conn.CreateCommand();
                itemsCmd.CommandText = @"
                    SELECT ci.ItemID, ci.Quantity, mi.Price, mi.Name
                    FROM CartItems ci
                    JOIN MenuItems mi ON ci.ItemID = mi.ItemID
                    WHERE ci.CartID = @CartID";
                itemsCmd.Parameters.AddWithValue("@CartID", cartID);

                DataTable dt = new DataTable();
                new SqlDataAdapter(itemsCmd).Fill(dt);

                if (dt.Rows.Count == 0) return;

                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                    total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);

                // create order
                SqlCommand createOrder = conn.CreateCommand();
                createOrder.CommandText = @"
                        INSERT INTO Orders (CustomerID, TotalPrice, DeliveryType, DeliveryAddress, Notes)
                        VALUES (@CID, @Total, @DeliveryType, @Address, @Notes);
                        SELECT SCOPE_IDENTITY()";
                createOrder.Parameters.AddWithValue("@CID", customerID);
                createOrder.Parameters.AddWithValue("@Total", total);
                createOrder.Parameters.AddWithValue("@DeliveryType", deliveryType);
                createOrder.Parameters.AddWithValue("@Address", deliveryType == "Delivery" ? address : (object)DBNull.Value);
                createOrder.Parameters.AddWithValue("@Notes", string.IsNullOrWhiteSpace(txtNotes.Text) ? (object)DBNull.Value : txtNotes.Text.Trim());
                int orderID = Convert.ToInt32(createOrder.ExecuteScalar());

                // insert order items
                foreach (DataRow row in dt.Rows)
                {
                    SqlCommand insertItem = conn.CreateCommand();
                    insertItem.CommandText = "INSERT INTO OrderItems (OrderID, ItemID, Quantity, UnitPrice) VALUES (@OID, @IID, @Qty, @Price)";
                    insertItem.Parameters.AddWithValue("@OID", orderID);
                    insertItem.Parameters.AddWithValue("@IID", row["ItemID"]);
                    insertItem.Parameters.AddWithValue("@Qty", row["Quantity"]);
                    insertItem.Parameters.AddWithValue("@Price", row["Price"]);
                    insertItem.ExecuteNonQuery();
                }

                // clear cart
                SqlCommand clearCart = conn.CreateCommand();
                clearCart.CommandText = "DELETE FROM CartItems WHERE CartID = @CartID";
                clearCart.Parameters.AddWithValue("@CartID", cartID);
                clearCart.ExecuteNonQuery();

                // get customer email
                SqlCommand getEmail = conn.CreateCommand();
                getEmail.CommandText = "SELECT Email, FirstName FROM Customers WHERE CustomerID = @CID";
                getEmail.Parameters.AddWithValue("@CID", customerID);
                SqlDataReader reader = getEmail.ExecuteReader();
                string customerEmail = "";
                string firstName = "";
                if (reader.Read())
                {
                    customerEmail = reader["Email"].ToString();
                    firstName = reader["FirstName"].ToString();
                }
                reader.Close();

                // build email body
                StringBuilder sb = new StringBuilder();
                sb.AppendLine($"Hi {firstName},");
                sb.AppendLine();
                sb.AppendLine($"Thank you for your order! Here are your order details:");
                sb.AppendLine();
                sb.AppendLine($"Order ID: #{orderID}");
                sb.AppendLine($"Type: {deliveryType}");
                if (deliveryType == "Delivery")
                    sb.AppendLine($"Address: {address}");
                sb.AppendLine();
                sb.AppendLine("ITEMS:");
                sb.AppendLine("------------------------");
                foreach (DataRow row in dt.Rows)
                {
                    decimal subtotal = Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                    sb.AppendLine($"{row["Name"]} x{row["Quantity"]} — ${subtotal:0.00}");
                }
                sb.AppendLine("------------------------");
                sb.AppendLine($"TOTAL: ${total:0.00}");
                sb.AppendLine();
                sb.AppendLine("Payment: Cash on Delivery");
                sb.AppendLine();
                sb.AppendLine("Thank you for choosing our restaurant!");

                // send email
                try
                {
                    SendEmail(customerEmail, $"Order Confirmation #{orderID}", sb.ToString());
                }
                catch
                {
                    
                }
                Response.Redirect($"OrderConfirmation.aspx?orderID={orderID}");
            }

           
        }

        private void SendEmail(string toEmail, string subject, string body)
        {
            string fromEmail = ConfigurationManager.AppSettings["GmailEmail"];  
            string appPassword = ConfigurationManager.AppSettings["GmailPassword"];         

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential(fromEmail, appPassword);

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromEmail, "Our Restaurant");
            mail.To.Add(toEmail);
            mail.Subject = subject;
            mail.Body = body;
            mail.IsBodyHtml = false;

            smtp.Send(mail);
        }
    }
}