<%@ Page Title="Categories" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="true" CodeBehind="Categories.aspx.cs"
Inherits="WebApplication11.Categories" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

<style>

body {
    font-family: 'Oswald', sans-serif;
}

.container {
    max-width: 1000px;
    margin: 60px auto;
}

h1 {
    color: #0d7a6d;
    text-align: center;
    font-size: 40px;
    margin-bottom: 30px;
}

.form-box {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    margin-bottom: 30px;
}

input {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
}

.btn {
    background: #0d7a6d;
    color: white;
    padding: 10px 15px;
    border: none;
    cursor: pointer;
}

.grid {
    width: 100%;
    background: white;
    border-collapse: collapse;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
}

.grid th {
    background: #0d7a6d;
    color: white;
    padding: 10px;
}

.grid td {
    padding: 10px;
}

</style>

<div class="container">

    <h1>Categories</h1>

    <div class="form-box">

        <asp:TextBox ID="txtName" runat="server" placeholder="Category Name" />
        <asp:TextBox ID="txtDescription" runat="server" placeholder="Description" />

        <asp:Button ID="btnAdd" runat="server" Text="Add Category" CssClass="btn" OnClick="btnAdd_Click" />

    </div>

    <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False"
        DataKeyNames="CategoryID"
        OnRowCommand="gvCategories_RowCommand"
        CssClass="grid">

        <Columns>

            <asp:BoundField DataField="CategoryID" HeaderText="ID" />
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />

            <asp:TemplateField>
                <ItemTemplate>

                    <asp:Button
                        runat="server"
                        Text="Delete"
                        CommandName="DeleteCat"
                        CommandArgument='<%# Eval("CategoryID") %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>

</asp:Content>