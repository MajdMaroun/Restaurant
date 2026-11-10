<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication11.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

    <style>

        .register-container {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 80px 0;
        }

        .register-box {
            background: white;
            padding: 50px 60px;
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            width: 550px;
            text-align: center;
        }

        .register-box h1 {
            font-size: 50px;
            color: #0d7a6d;
            margin-bottom: 10px;
        }

        .register-box p {
            font-size: 18px;
            color: #888;
            margin-bottom: 40px;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-size: 20px;
            margin-bottom: 8px;
            color: #333;
        }

        .input-group .textbox {
            width: 100%;
            padding: 12px 18px;
            font-size: 18px;
            border: 2px solid #ddd;
            border-radius: 10px;
            outline: none;
            font-family: 'Oswald', sans-serif;
            box-sizing: border-box;
        }

        .input-group .textbox:focus {
            border-color: #0d7a6d;
        }

        .register-btn {
            width: 100%;
            padding: 15px;
            background: #0d7a6d;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 22px;
            cursor: pointer;
            font-family: 'Oswald', sans-serif;
            margin-top: 10px;
        }

        .register-btn:hover {
            background: #09594f;
        }

        .error-msg {
            color: red;
            font-size: 18px;
            margin-top: 15px;
            display: block;
        }

        .success-msg {
            color: #0d7a6d;
            font-size: 18px;
            margin-top: 15px;
            display: block;
        }

        .login-link {
            margin-top: 25px;
            font-size: 18px;
            color: #555;
        }

        .login-link a {
            color: #ff7b00;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

    </style>

    <div class="register-container">
        <div class="register-box">

            <h1>REGISTER</h1>
            <p>Create your account to start ordering</p>

            <div class="input-group">
                <label>First Name</label>
                <asp:TextBox ID="txtFirstName" runat="server" placeholder="Enter your first name" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Last Name</label>
                <asp:TextBox ID="txtLastName" runat="server" placeholder="Enter your last name" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter your email" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter your phone number" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Address</label>
                <asp:TextBox ID="txtAddress" runat="server" placeholder="Enter your address" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Confirm Password</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm your password" CssClass="textbox" />
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="REGISTER" CssClass="register-btn" OnClick="btnRegister_Click" />

            <asp:Label ID="lblError"   runat="server" CssClass="error-msg"   Visible="false" />
            <asp:Label ID="lblSuccess" runat="server" CssClass="success-msg" Visible="false" />

            <div class="login-link">
                Already have an account? <a href="Login.aspx">Login here</a>
            </div>

        </div>
    </div>

</asp:Content>