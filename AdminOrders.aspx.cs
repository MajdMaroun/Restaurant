using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication11
{
    public partial class Orders : System.Web.UI.Page
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
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT * FROM Orders ORDER BY OrderDate DESC", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        protected void gvOrders_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "NextStatus")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // get current status
                    SqlCommand getCmd = new SqlCommand(
                        "SELECT Status FROM Orders WHERE OrderID = @id", con);

                    getCmd.Parameters.AddWithValue("@id", orderId);

                    string status = getCmd.ExecuteScalar().ToString();

                    string newStatus = GetNextStatus(status);

                    SqlCommand updateCmd = new SqlCommand(
                        "UPDATE Orders SET Status = @status WHERE OrderID = @id", con);

                    updateCmd.Parameters.AddWithValue("@status", newStatus);
                    updateCmd.Parameters.AddWithValue("@id", orderId);

                    updateCmd.ExecuteNonQuery();
                }

                LoadOrders();
            }
        }

        private string GetNextStatus(string current)
        {
            switch (current)
            {
                case "Pending": return "Preparing";
                case "Preparing": return "Ready";
                case "Ready": return "Delivered";
                default: return "Delivered";
            }
        }

        protected void btnBackAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminHome.aspx");
        }
    }
}