<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="WebApplication11.home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    scroll-behavior: smooth;
}

body {
    font-family: 'Oswald', sans-serif;
    background: #f3e4d5;
}

/* ================= HERO ================= */

.hero {
    text-align: center;
    padding: 90px 20px;
    background: linear-gradient(135deg, #0d7a6d, #12a089);
    color: white;
}

.hero h1 {
    font-size: 60px;
    margin-bottom: 10px;
}

.hero p {
    font-size: 22px;
    opacity: 0.9;
}

/* ================= CATEGORIES ================= */

.categories {
    width: 90%;
    margin: 70px auto;
    display: flex;
    justify-content: center;
    gap: 30px;
    flex-wrap: wrap;
}

.card {
    width: 300px;
    background: white;
    border-radius: 20px;
    padding: 30px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    text-align: center;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-8px);
}

.card h2 {
    font-size: 32px;
    color: #0d7a6d;
    margin-bottom: 10px;
}

.card p {
    font-size: 18px;
    color: #666;
    margin-bottom: 20px;
}

.card a {
    display: inline-block;
    padding: 10px 20px;
    background: #ff7b00;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    transition: 0.3s;
}

.card a:hover {
    background: #0d7a6d;
}

/* ================= FEATURES ================= */

.features {
    display: flex;
    justify-content: center;
    gap: 60px;
    padding: 70px 20px;
    background: white;
    text-align: center;
    flex-wrap: wrap;
    font-size: 20px;
    color: #333;
}

.features div {
    width: 200px;
}

</style>

<!-- ================= HERO ================= -->

<div class="hero">
    <h1>Welcome to Our Restaurant</h1>
    <p>Fresh food • Fast service • Unforgettable taste</p>
</div>

<!-- ================= CATEGORIES ================= -->

<div class="categories">
    <asp:Repeater ID="rptCategories" runat="server">
        <ItemTemplate>

            <div class="card">
                <h2><%# Eval("Name").ToString().ToUpper() %></h2>
                <p><%# Eval("Description") %></p>

                <a href='<%# "WebForm1.aspx#cat-" + Eval("CategoryID") %>'>
                    VIEW MENU →
                </a>
            </div>

        </ItemTemplate>
    </asp:Repeater>
</div>


</asp:Content>