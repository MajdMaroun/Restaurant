<%@ Page Title="Order Confirmation" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="WebApplication11.OrderConfirmation" %>

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

        /* ================= CONFIRMATION BOX ================= */

        .confirmation-container {
            width: 90%;
            max-width: 700px;
            margin: 60px auto;
        }

        .confirmation-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .confirmation-header .checkmark {
            font-size: 80px;
            display: block;
            margin-bottom: 20px;
        }

        .confirmation-header h1 {
            font-size: 55px;
            color: #0d7a6d;
        }

        .confirmation-header p {
            font-size: 20px;
            color: #888;
            margin-top: 10px;
        }

        /* ================= ORDER DETAILS ================= */

        .order-box {
            background: white;
            border-radius: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 30px;
        }

        .order-box h2 {
            font-size: 30px;
            color: #0d7a6d;
            margin-bottom: 25px;
            border-bottom: 2px dashed #d4b8a0;
            padding-bottom: 15px;
        }

        .order-meta {
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }

        .meta-item {
            flex: 1;
            min-width: 150px;
        }

        .meta-item .label {
            font-size: 16px;
            color: #aaa;
            margin-bottom: 5px;
        }

        .meta-item .value {
            font-size: 22px;
            color: #222;
            font-weight: bold;
        }

        /* ================= ITEMS TABLE ================= */

        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .items-table th {
            background: #0d7a6d;
            color: white;
            padding: 14px 18px;
            font-size: 20px;
            text-align: left;
        }

        .items-table td {
            padding: 14px 18px;
            font-size: 18px;
            border-bottom: 1px solid #eee;
        }

        .items-table tr:last-child td {
            border-bottom: none;
            font-weight: bold;
            font-size: 20px;
            background: #f7f7f7;
        }

        /* ================= EMAIL NOTE ================= */

        .email-note {
            text-align: center;
            font-size: 18px;
            color: #888;
            margin-bottom: 30px;
        }

        .email-note span {
            color: #0d7a6d;
            font-weight: bold;
        }

        /* ================= BUTTONS ================= */

        .buttons {
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .home-btn {
            background: #0d7a6d;
            color: white;
            border: none;
            padding: 15px 35px;
            font-size: 22px;
            border-radius: 12px;
            cursor: pointer;
            font-family: 'Oswald', sans-serif;
            text-decoration: none;
            display: inline-block;
        }

        .home-btn:hover {
            background: #09594f;
            color: white;
        }

        .cancel-btn {
            background: red;
            color: white;
            border: none;
            padding: 15px 35px;
            font-size: 22px;
            border-radius: 12px;
            cursor: pointer;
            font-family: 'Oswald', sans-serif;
        }

        .cancel-btn:hover {
            background: darkred;
        }

        .error-msg {
            color: red;
            font-size: 18px;
            text-align: center;
            margin-top: 15px;
            display: block;
        }

    </style>

    <div class="confirmation-container">

        <!-- HEADER -->
        <div class="confirmation-header">
            <span class="checkmark">✅</span>
            <h1>ORDER PLACED!</h1>
            <p>Your order has been successfully placed.</p>
        </div>

        <!-- ORDER DETAILS -->
        <div class="order-box">
            <h2>ORDER DETAILS</h2>

            <div class="order-meta">
                <div class="meta-item">
                    <div class="label">ORDER ID</div>
                    <div class="value"><asp:Label ID="lblOrderID" runat="server" /></div>
                </div>
                <div class="meta-item">
                    <div class="label">DATE</div>
                    <div class="value"><asp:Label ID="lblDate" runat="server" /></div>
                </div>
                <div class="meta-item">
                    <div class="label">TYPE</div>
                    <div class="value"><asp:Label ID="lblDeliveryType" runat="server" /></div>
                </div>
                <div class="meta-item">
                    <div class="label">PAYMENT</div>
                    <div class="value">Cash on Delivery</div>
                </div>
            </div>

            <asp:Panel ID="pnlAddress" runat="server" Visible="false">
                <div class="order-meta" style="margin-bottom:30px;">
                    <div class="meta-item">
                        <div class="label">DELIVERY ADDRESS</div>
                        <div class="value"><asp:Label ID="lblAddress" runat="server" /></div>
                    </div>
                </div>
            </asp:Panel>

            <asp:GridView
                ID="GridView1"
                runat="server"
                AutoGenerateColumns="False"
                Width="100%"
                GridLines="None"
                CssClass="items-table">
                <Columns>
                    <asp:BoundField DataField="Name"     HeaderText="ITEM" />
                    <asp:BoundField DataField="Quantity" HeaderText="QTY" />
                    <asp:BoundField DataField="Subtotal" HeaderText="PRICE" DataFormatString="{0:0.00}$" />
                </Columns>
            </asp:GridView>

        </div>

        <!-- EMAIL NOTE -->
        <div class="email-note">
            A confirmation email has been sent to <span><asp:Label ID="lblEmail" runat="server" /></span>
        </div>

        <!-- BUTTONS -->
        <div class="buttons">
            <a href="Home.aspx" class="home-btn">BACK TO HOME</a>
            <asp:Button ID="btnCancel" runat="server" Text="CANCEL ORDER" CssClass="cancel-btn" OnClick="btnCancel_Click" />
        </div>

        <asp:Label ID="lblError" runat="server" CssClass="error-msg" Visible="false" />

    </div>

</asp:Content>