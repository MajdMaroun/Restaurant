<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication11.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

    <style>

        .login-container {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 80px 0;
        }

        .login-box {
            background: white;
            padding: 50px 60px;
            border-radius: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            width: 500px;
            text-align: center;
        }

        .login-box h1 {
            font-size: 50px;
            color: #0d7a6d;
            margin-bottom: 10px;
        }

        .login-box p {
            font-size: 18px;
            color: #888;
            margin-bottom: 40px;
        }

        .input-group {
            margin-bottom: 25px;
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

        .login-btn {
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

        .login-btn:hover {
            background: #09594f;
        }

        .error-msg {
            color: red;
            font-size: 18px;
            margin-top: 15px;
            display: block;
        }

        .register-link {
            margin-top: 25px;
            font-size: 18px;
            color: #555;
        }

        .register-link a {
            color: #ff7b00;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

    </style>

    <div class="login-container">
        <div class="login-box">

            <h1>LOGIN</h1>
            <p>Welcome back, please login to your account</p>

            <div class="input-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter your email" CssClass="textbox" />
            </div>

            <div class="input-group">
                <label>Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="textbox" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="LOGIN" CssClass="login-btn" OnClick="btnLogin_Click" />

            <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false" />

            <div class="register-link">
                Don't have an account? <a href="Register.aspx">Register here</a><br />
                <a href="AdminLogin.aspx">Access Admin Page</a>
            </div>

        </div>
    </div>

</asp:Content>