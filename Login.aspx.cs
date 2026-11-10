using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication11
{
    public partial class Login : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                lblError.Text = "Please enter your email and password.";
                lblError.Visible = true;
                return;
            }

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT CustomerID, FirstName, Password, FailedAttempts, LockedUntil FROM Customers WHERE Email = @Email";
                cmd.Parameters.AddWithValue("@Email", email);

                SqlDataReader reader = cmd.ExecuteReader();

                if (!reader.Read())
                {
                    lblError.Text = "Invalid email or password.";
                    lblError.Visible = true;
                    return;
                }

                int customerID = Convert.ToInt32(reader["CustomerID"]);
                int failedAttempts = Convert.ToInt32(reader["FailedAttempts"]);
                string firstName = reader["FirstName"].ToString();
                string storedHash = reader["Password"].ToString();
                DateTime? lockedUntil = reader["LockedUntil"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["LockedUntil"]);
                reader.Close();

                // check if account is temporarily locked
                if (lockedUntil.HasValue && DateTime.Now < lockedUntil.Value)
                {
                    int minutesLeft = (int)(lockedUntil.Value - DateTime.Now).TotalMinutes + 1;
                    lblError.Text = $"Account locked. Try again in {minutesLeft} minute(s).";
                    lblError.Visible = true;
                    return;
                }

                if (PasswordHelper.Verify(password, storedHash))
                {
                    // success — reset failed attempts and lock
                    SqlCommand reset = conn.CreateCommand();
                    reset.CommandText = "UPDATE Customers SET FailedAttempts = 0, LockedUntil = NULL WHERE CustomerID = @ID";
                    reset.Parameters.AddWithValue("@ID", customerID);
                    reset.ExecuteNonQuery();

                    Session["CustomerID"] = customerID;
                    Session["FirstName"] = firstName;
                    Response.Redirect("Home.aspx");
                }
                else
                {
                    failedAttempts++;
                    SqlCommand update = conn.CreateCommand();

                    if (failedAttempts >= 5)
                    {
                        // lock for 1 hour
                        DateTime lockTime = DateTime.Now.AddHours(1);
                        update.CommandText = "UPDATE Customers SET FailedAttempts = @Attempts, LockedUntil = @LockedUntil WHERE CustomerID = @ID";
                        update.Parameters.AddWithValue("@LockedUntil", lockTime);
                        lblError.Text = "Too many failed attempts. Your account has been locked for 1 hour.";
                    }
                    else
                    {
                        update.CommandText = "UPDATE Customers SET FailedAttempts = @Attempts WHERE CustomerID = @ID";
                        lblError.Text = $"Invalid password. {5 - failedAttempts} attempts remaining.";
                    }

                    update.Parameters.AddWithValue("@Attempts", failedAttempts);
                    update.Parameters.AddWithValue("@ID", customerID);
                    update.ExecuteNonQuery();

                    lblError.Visible = true;
                }
            }
        }
    }
}