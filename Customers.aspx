<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="true" CodeBehind="Customers.aspx.cs"
Inherits="WebApplication11.Customers" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

<style>

body {
    font-family: 'Oswald', sans-serif;
}

.container {
    max-width: 1200px;
    margin: 60px auto;
}

h1 {
    text-align: center;
    color: #0d7a6d;
    font-size: 42px;
    margin-bottom: 30px;
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
    padding: 12px;
}

.grid td {
    padding: 12px;
    border-bottom: 1px solid #eee;
}

.locked {
    color: red;
    font-weight: bold;
}

.active {
    color: green;
    font-weight: bold;
}

.btn {
    background: #0d7a6d;
    color: white;
    padding: 6px 10px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.small {
    font-size: 13px;
    color: #555;
}

</style>

<div class="container">

    <h1>Customers Management</h1>

    <asp:GridView ID="gvCustomers" runat="server"
        AutoGenerateColumns="False"
        DataKeyNames="CustomerID"
        OnRowCommand="gvCustomers_RowCommand"
        CssClass="grid">

        <Columns>

            <asp:BoundField DataField="CustomerID" HeaderText="ID" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="FailedAttempts" HeaderText="Failed Attempts" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>

                    <%# Convert.ToBoolean(Eval("IsLocked")) ? 
                        "<span class='locked'>Locked</span>" : 
                        "<span class='active'>Active</span>" %>

                    <br />

                    <span class="small">
                        Locked Until: <%# Eval("LockedUntil") %>
                    </span>

                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>

                    <asp:Button
                        runat="server"
                        CssClass="btn"
                        Text='<%# Convert.ToBoolean(Eval("IsLocked")) ? "Unlock" : "Lock" %>'
                        CommandName='<%# Convert.ToBoolean(Eval("IsLocked")) ? "Unlock" : "Lock" %>'
                        CommandArgument='<%# Eval("CustomerID") %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>

</asp:Content>