<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site.master"
AutoEventWireup="true" CodeBehind="Orders.aspx.cs"
Inherits="WebApplication11.Orders" %>

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
        color: #0d7a6d;
        text-align: center;
        font-size: 45px;
        margin-bottom: 30px;
    }

    .grid {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }

    .grid th {
        background: #0d7a6d;
        color: white;
        padding: 15px;
        text-align: left;
    }

    .grid td {
        padding: 12px;
        border-bottom: 1px solid #eee;
    }

    .status {
        padding: 5px 10px;
        border-radius: 8px;
        color: white;
        font-size: 14px;
    }

    .Pending { background: orange; }
    .Preparing { background: #3498db; }
    .Ready { background: #2ecc71; }
    .Delivered { background: #7f8c8d; }

    .action-btn {
        padding: 6px 10px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        background: #0d7a6d;
        color: white;
    }

</style>

<div class="container">

    <h1>ORDERS MANAGEMENT</h1>
    <asp:Button 
    ID="btnBackAdmin"
    runat="server"
    Text="← Admin Dashboard"
    CssClass="action-btn"
    OnClick="btnBackAdmin_Click"
    style="margin-bottom:20px; background:#0d7a6d; font-size:16px;" />

    <asp:GridView ID="gvOrders" runat="server"
        CssClass="grid"
        AutoGenerateColumns="False"
        DataKeyNames="OrderID"
        OnRowCommand="gvOrders_RowCommand">

        <Columns>

            <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
            <asp:BoundField DataField="CustomerID" HeaderText="Customer" />
            <asp:BoundField DataField="OrderDate" HeaderText="Date" />
            <asp:BoundField DataField="TotalPrice" HeaderText="Total ($)" />
            <asp:BoundField DataField="DeliveryType" HeaderText="Delivery Type" />
            <asp:BoundField DataField="DeliveryAddress" HeaderText="Address" />
            <asp:BoundField DataField="Notes" HeaderText="Notes" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <span class='status <%# Eval("Status") %>'>
                        <%# Eval("Status") %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>

                    <asp:Button 
                        ID="btnNextStatus"
                        runat="server"
                        Text="Next Step"
                        CssClass="action-btn"
                        CommandName="NextStatus"
                        CommandArgument='<%# Eval("OrderID") %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

        

</div>

</asp:Content>