using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication11
{
    public partial class Register : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["RestaurantDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // validation
            if (string.IsNullOrWhiteSpace(firstName) || string.IsNullOrWhiteSpace(lastName) ||
                string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please fill in all required fields.");
                return;
            }

            if (password != confirmPassword)
            {
                ShowError("Passwords do not match.");
                return;
            }

            if (password.Length < 6)
            {
                ShowError("Password must be at least 6 characters.");
                return;
            }

            using (SqlConnection conn = new SqlConnection(cs))
            {
                conn.Open();

                // check if email already exists
                SqlCommand checkEmail = conn.CreateCommand();
                checkEmail.CommandText = "SELECT COUNT(*) FROM Customers WHERE Email = @Email";
                checkEmail.Parameters.AddWithValue("@Email", email);
                int count = Convert.ToInt32(checkEmail.ExecuteScalar());

                if (count > 0)
                {
                    ShowError("An account with this email already exists.");
                    return;
                }

                // hash password and insert customer
                string hashedPassword = PasswordHelper.Hash(password);

                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = @"INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, Password, FailedAttempts, IsLocked)
                                    VALUES (@FirstName, @LastName, @Email, @Phone, @Address, @Password, 0, 0)";
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Phone", string.IsNullOrWhiteSpace(phone) ? (object)DBNull.Value : phone);
                cmd.Parameters.AddWithValue("@Address", string.IsNullOrWhiteSpace(address) ? (object)DBNull.Value : address);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);
                cmd.ExecuteNonQuery();

                lblError.Visible = false;
                lblSuccess.Text = "Account created successfully! Redirecting to login...";
                lblSuccess.Visible = true;

                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
            lblSuccess.Visible = false;
        }
    }
}