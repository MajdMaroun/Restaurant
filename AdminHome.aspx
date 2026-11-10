<%@ Page Title="Admin Home" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs"
Inherits="WebApplication11.AdminHome" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

<style>

    body {
        font-family: 'Oswald', sans-serif;
    }

    .admin-wrapper {
        max-width: 1200px;
        margin: 80px auto;
        text-align: center;
    }

    .admin-title {
        font-size: 48px;
        color: #0d7a6d;
        margin-bottom: 10px;
    }

    .admin-subtitle {
        font-size: 18px;
        color: #777;
        margin-bottom: 50px;
    }

    .cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
    }

    .card {
        background: white;
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        transition: 0.3s;
        cursor: pointer;
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(0,0,0,0.15);
    }

    .card h3 {
        color: #0d7a6d;
        font-size: 24px;
        margin-bottom: 10px;
    }

    .card p {
        color: #666;
        font-size: 16px;
    }

    .logout-btn {
        margin-top: 40px;
        padding: 12px 25px;
        background: #ff4d4d;
        color: white;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-size: 18px;
    }

    .logout-btn:hover {
        background: #d63c3c;
    }

</style>

<div class="admin-wrapper">

    <div class="admin-title">ADMIN DASHBOARD</div>
    <div class="admin-subtitle">Manage your restaurant system</div>

    <div class="cards">

        <div class="card" onclick="location.href='AdminOrders.aspx'">
            <h3>Orders</h3>
            <p>View and manage customer orders</p>
        </div>

        <div class="card" onclick="location.href='AdminMenu.aspx'">
            <h3>Menu</h3>
            <p>Add, edit or remove food items</p>
        </div>

        <div class="card" onclick="location.href='MenuCategories.aspx'">
            <h3>Categories</h3>
            <p>Manage food categories</p>
        </div>

        <div class="card" onclick="location.href='Customers.aspx'">
            <h3>Users</h3>
            <p>View and unblock suspended accounts</p>
        </div>

    </div>

    <asp:Button 
        ID="btnLogout" 
        runat="server" 
        Text="Logout"
        CssClass="logout-btn"
        OnClick="btnLogout_Click" />

</div>

</asp:Content>