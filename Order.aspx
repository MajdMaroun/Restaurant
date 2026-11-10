<%@ Page Title="Order" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="WebApplication11.Order" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet"/>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Oswald', sans-serif;
            background: #f3e4d5;
            color: #222;
        }

        .title {
            text-align: center;
            margin-top: 50px;
            margin-bottom: 40px;
        }

        .title h1 {
            font-size: 70px;
            color: #0d7a6d;
        }

        .table-container {
            width: 90%;
            margin: auto;
            margin-bottom: 50px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            border-radius: 20px;
            overflow: hidden;
        }

        th {
            background: #0d7a6d;
            color: white;
            padding: 18px;
            font-size: 24px;
        }

        td {
            padding: 18px;
            text-align: center;
            font-size: 22px;
            border-bottom: 1px solid #ddd;
        }

        .delete-btn {
            background: red;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }

        .delete-btn:hover {
            background: darkred;
        }

        .total-row td {
            background: #f7f7f7;
            font-weight: bold;
            font-size: 24px;
        }

        /* ================= DELIVERY OPTIONS ================= */

        .delivery-section {
            width: 90%;
            margin: 0 auto 40px auto;
            background: white;
            border-radius: 20px;
            padding: 35px 40px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .delivery-section h2 {
            font-size: 32px;
            color: #0d7a6d;
            margin-bottom: 25px;
        }

        .delivery-options {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .delivery-option {
            flex: 1;
            min-width: 200px;
            border: 3px solid #ddd;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: 0.3s;
            font-size: 22px;
        }

        .delivery-option:hover {
            border-color: #0d7a6d;
        }

        .delivery-option input[type="radio"] {
            display: none;
        }

        .delivery-option.selected {
            border-color: #0d7a6d;
            background: #f0faf8;
        }

        .delivery-option span {
            font-size: 40px;
            display: block;
            margin-bottom: 10px;
        }

        .address-group {
            margin-top: 20px;
        }

        .address-group label {
            display: block;
            font-size: 20px;
            margin-bottom: 8px;
            color: #333;
        }

        .address-group .textbox {
            width: 100%;
            padding: 12px 18px;
            font-size: 18px;
            border: 2px solid #ddd;
            border-radius: 10px;
            outline: none;
            font-family: 'Oswald', sans-serif;
            box-sizing: border-box;
        }

        .address-group .textbox:focus {
            border-color: #0d7a6d;
        }

        .error-msg {
            color: red;
            font-size: 18px;
            margin-top: 10px;
            display: block;
        }

        .buttons {
            width: 90%;
            margin: 40px auto;
            display: flex;
            justify-content: center;
            gap: 25px;
        }

        .order-btn {
            background: #0d7a6d;
            color: white;
            border: none;
            padding: 15px 35px;
            font-size: 22px;
            border-radius: 12px;
            cursor: pointer;
            font-family: 'Oswald', sans-serif;
        }

        .order-btn:hover {
            background: #09594f;
        }

        .clear-btn {
            background: #ff7b00;
            color: white;
            border: none;
            padding: 15px 35px;
            font-size: 22px;
            border-radius: 12px;
            cursor: pointer;
            font-family: 'Oswald', sans-serif;
        }

        .clear-btn:hover {
            background: #cc6200;
        }

        .empty-msg {
            text-align: center;
            font-size: 28px;
            color: #888;
            margin: 60px 0;
        }

        .login-msg {
            text-align: center;
            font-size: 24px;
            color: #888;
            margin: 60px 0;
        }

        .login-msg a {
            color: #ff7b00;
            text-decoration: none;
        }

        .login-msg a:hover {
            text-decoration: underline;
        }

    </style>

    <div class="title">
        <h1>YOUR ORDER</h1>
    </div>

    <asp:Panel ID="pnlNotLoggedIn" runat="server" Visible="false">
        <div class="login-msg">
            Please <a href="Login.aspx">login</a> to view your cart.
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlCart" runat="server" Visible="false">

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="empty-msg">Your cart is empty.</div>
        </asp:Panel>

        <asp:Panel ID="pnlItems" runat="server" Visible="false">

            <div class="table-container">
                <asp:GridView
                    ID="GridView1"
                    runat="server"
                    AutoGenerateColumns="False"
                    Width="100%"
                    GridLines="None"
                    OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Name"     HeaderText="ITEM" />
                        <asp:BoundField DataField="Quantity" HeaderText="QUANTITY" />
                        <asp:BoundField DataField="Subtotal" HeaderText="PRICE" DataFormatString="{0:0.00}$" />
                        <asp:TemplateField HeaderText="DELETE">
                            <ItemTemplate>
                                <asp:Button
                                    ID="btnDelete"
                                    runat="server"
                                    Text="DELETE"
                                    CssClass="delete-btn"
                                    CommandName="DeleteItem"
                                    CommandArgument='<%# Eval("CartItemID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- ================= DELIVERY OPTIONS ================= -->

            <div class="delivery-section">
                <h2>DELIVERY OPTIONS</h2>

                <div class="delivery-options">

                    <label class="delivery-option" id="lblDelivery">
                        <input type="radio" name="deliveryType" value="Delivery" checked
                               onclick="selectOption('Delivery')" />
                        <span>🛵</span>
                        DELIVERY
                    </label>

                    <label class="delivery-option" id="lblTakeaway">
                        <input type="radio" name="deliveryType" value="Takeaway"
                               onclick="selectOption('Takeaway')" />
                        <span>🥡</span>
                        TAKEAWAY
                    </label>

                </div>

                <asp:HiddenField ID="hdnDeliveryType" runat="server" Value="Delivery" />

                <div id="addressGroup" class="address-group">
                    <label>Delivery Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" placeholder="Enter your delivery address" CssClass="textbox" />
                </div>

                <div class="address-group" style="margin-top:20px;">
                    <label>Notes (optional)</label>
                    <asp:TextBox ID="txtNotes" runat="server" placeholder="e.g. no onions, extra sauce, ring the bell..." CssClass="textbox" TextMode="MultiLine" Rows="3" />
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false" />

            </div>

            <div class="buttons">
                <asp:Button ID="btnOrder" runat="server" Text="PLACE ORDER" CssClass="order-btn" OnClick="btnOrder_Click" />
                <asp:Button ID="btnClear" runat="server" Text="CLEAR CART"  CssClass="clear-btn" OnClick="btnClear_Click" />
            </div>

        </asp:Panel>

    </asp:Panel>

    <script>
        function selectOption(type) {
            document.getElementById('<%= hdnDeliveryType.ClientID %>').value = type;

            var lblDelivery = document.getElementById('lblDelivery');
            var lblTakeaway = document.getElementById('lblTakeaway');
            var addressGroup = document.getElementById('addressGroup');

            if (type === 'Delivery') {
                lblDelivery.classList.add('selected');
                lblTakeaway.classList.remove('selected');
                addressGroup.style.display = 'block';
            } else {
                lblTakeaway.classList.add('selected');
                lblDelivery.classList.remove('selected');
                addressGroup.style.display = 'none';
            }
        }

        window.onload = function () {
            selectOption('Delivery');
        };
    </script>

</asp:Content>