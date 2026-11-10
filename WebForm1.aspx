<%@ Page Title="Menu" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication11.WebForm1" %>

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

        /* ================= TITLE ================= */

        .menu-title {
            text-align: center;
            margin-top: 60px;
            margin-bottom: 30px;
        }

        .menu-title h1 {
            font-size: 70px;
            color: #0d7a6d;
            letter-spacing: 4px;
        }

        .underline {
            width: 180px;
            height: 5px;
            background: #ff7b00;
            margin: 10px auto 0 auto;
            border-radius: 20px;
        }

        /* ================= CATEGORY NAV ================= */

        .cat-nav {
            position: sticky;
            top: 0;
            z-index: 100;
            background: #f3e4d5;
            border-bottom: 2px dashed #d4b8a0;
            display: flex;
            justify-content: center;
            gap: 30px;
            padding: 15px 0;
            flex-wrap: wrap;
            margin-bottom: 50px;
        }

        .cat-nav a {
            text-decoration: none;
            color: #222;
            font-size: 20px;
            padding: 8px 20px;
            border-radius: 20px;
            transition: 0.3s;
        }

        .cat-nav a:hover {
            background: #0d7a6d;
            color: white;
        }

        /* ================= CATEGORY SECTION ================= */

        .category-section {
            width: 90%;
            margin: 0 auto 80px auto;
            scroll-margin-top: 80px;
        }

        .category-section h2 {
            font-size: 50px;
            color: #111;
            margin-bottom: 30px;
            border-left: 6px solid #ff7b00;
            padding-left: 20px;
        }

        /* ================= MENU ITEM ================= */

        .menu-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border-bottom: 2px dotted #b8a08d;
            padding-bottom: 15px;
        }

        .item-info {
            flex: 1;
        }

        .item-name {
            font-size: 26px;
        }

        .item-desc {
            font-size: 16px;
            color: #888;
            margin-top: 4px;
        }

        .item-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .price {
            background: #0d7a6d;
            color: white;
            padding: 8px 18px;
            border-radius: 10px;
            font-size: 22px;
        }

        .add-btn {
            background: #ff7b00;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-family: 'Oswald', sans-serif;
        }

        .add-btn:hover {
            background: #0d7a6d;
        }

        /* ================= RESPONSIVE ================= */

        @media(max-width: 768px) {
            .menu-title h1 { font-size: 45px; }
            .category-section h2 { font-size: 35px; }
            .item-name { font-size: 20px; }
        }

        /* ================= SNACKBAR ================= */

        .snackbar {
            visibility: hidden;
            min-width: 280px;
            background: #333;
            color: white;
            text-align: center;
            border-radius: 12px;
            padding: 16px 24px;
            position: fixed;
            z-index: 9999;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 18px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .snackbar.show {
            visibility: visible;
            animation: fadein 0.3s, fadeout 0.3s 2.7s;
        }

        @keyframes fadein {
            from { bottom: 20px; opacity: 0; }
            to   { bottom: 40px; opacity: 1; }
        }

        @keyframes fadeout {
            from { bottom: 40px; opacity: 1; }
            to   { bottom: 20px; opacity: 0; }
        }

    </style>

    <!-- ================= TITLE ================= -->

    <div class="menu-title">
        <h1>OUR MENU</h1>
        <div class="underline"></div>
    </div>

    <!-- ================= CATEGORY NAV ================= -->

    <div class="cat-nav">
        <asp:Repeater ID="rptCatNav" runat="server">
            <ItemTemplate>
                <a href='<%# "#cat-" + Eval("CategoryID") %>'><%# Eval("Name") %></a>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- ================= MENU SECTIONS ================= -->

    <asp:Repeater ID="rptCategories" runat="server">
        <ItemTemplate>
            <div class="category-section" id='<%# "cat-" + Eval("CategoryID") %>'>
                <h2><%# Eval("Name").ToString().ToUpper() %></h2>

                <asp:Repeater ID="rptItems" runat="server">
                    <ItemTemplate>
                        <div class="menu-item">
                            <div class="item-info">
                                <div class="item-name"><%# Eval("Name").ToString().ToUpper() %></div>
                                <div class="item-desc"><%# Eval("Description") %></div>
                            </div>
                            <div class="item-right">
                                <span class="price"><%# Eval("Price") %>$</span>
                                <asp:Button
                                    runat="server"
                                    Text="ADD"
                                    CssClass="add-btn"
                                    CommandArgument='<%# Eval("ItemID") %>'
                                    CommandName="AddToCart"
                                    OnCommand="AddToCart_Command" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </ItemTemplate>
    </asp:Repeater>
    <div id="snackbar" class="snackbar"></div>


    <!-- ================= SNACKBAR ================= -->

    <div id="snackbar" class="snackbar"></div>
    <asp:HiddenField ID="hdnMessage" runat="server" Value="" />

    <script>
        window.onload = function () {
            var msg = document.getElementById('<%= hdnMessage.ClientID %>').value;
            if (msg !== '') {
                var sb = document.getElementById('snackbar');
                sb.innerText = msg;
                sb.style.background = msg.indexOf('login') !== -1 ? '#ff7b00' : '#0d7a6d';
                sb.className = 'snackbar show';
                setTimeout(function () { sb.className = 'snackbar'; }, 3000);
            }
        };
    </script>

</asp:Content>