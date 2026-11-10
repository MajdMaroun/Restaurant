<%@ Page Title="Menu Items" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="true" CodeBehind="AdminMenu.aspx.cs"
Inherits="WebApplication11.AdminMenu" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

<style>

body {
    font-family: 'Oswald', sans-serif;
}

.container {
    max-width: 1100px;
    margin: 60px auto;
}

h1 {
    text-align: center;
    color: #0d7a6d;
    font-size: 42px;
    margin-bottom: 25px;
}

.form-box {
    background: white;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    margin-bottom: 30px;
}

input, select {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
}

.btn {
    background: #0d7a6d;
    color: white;
    padding: 10px;
    border: none;
    cursor: pointer;
    width: 100%;
}

.grid {
    width: 100%;
    border-collapse: collapse;
    background: white;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

.grid th {
    background: #0d7a6d;
    color: white;
    padding: 10px;
}

.grid td {
    padding: 10px;
    border-bottom: 1px solid #eee;
}

</style>

<div class="container">

    <h1>Menu Items</h1>

    <div class="form-box">

        <asp:TextBox ID="txtName" runat="server" placeholder="Item Name" />
        <asp:TextBox ID="txtDescription" runat="server" placeholder="Description" />
        <asp:TextBox ID="txtPrice" runat="server" placeholder="Price" />

        <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>

        <asp:Button ID="btnAddItem" runat="server" Text="Add Item" CssClass="btn"
            OnClick="btnAddItem_Click" />

    </div>

    <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="False"
        CssClass="grid">

        <Columns>

            <asp:BoundField DataField="ItemID" HeaderText="ID" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:BoundField DataField="Price" HeaderText="Price" />
            <asp:BoundField DataField="CategoryName" HeaderText="Category" />

        </Columns>

    </asp:GridView>

</div>

</asp:Content>