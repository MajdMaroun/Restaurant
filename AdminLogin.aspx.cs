using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication11
{
    public partial class AdminLogin : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAdminLogin_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                lblError.Text = "Please enter your email and password.";
                lblError.Visible = true;
                return;
            }

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT AdminID, Username, Password FROM Admins WHERE Username = @Username";
                cmd.Parameters.AddWithValue("@Username", username);

                SqlDataReader reader = cmd.ExecuteReader();

                if (!reader.Read())
                {
                    lblError.Text = "Invalid username or password.";
                    lblError.Visible = true;
                    return;
                }

                int adminID = Convert.ToInt32(reader["AdminID"]);
                string storedHash = reader["Password"].ToString();
                reader.Close();

              

                if (PasswordHelper.Verify(password, storedHash))
                {
            
                    Session["adminID"] = adminID;
                    Session["username"] = username;
                    Response.Redirect("AdminHome.aspx");
                }
                else
                {
                    lblError.Text = "Invalid password.";
                    lblError.Visible = true;
                }
            }
        }
    }
}