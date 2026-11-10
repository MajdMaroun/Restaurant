<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master"
AutoEventWireup="true" CodeBehind="About.aspx.cs"
Inherits="WebApplication11.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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

        /* ================= HERO ================= */

        .hero {
            width: 100%;
            height: 520px;
            background-image: url('images/about-banner.jpg');
            background-size: cover;
            background-position: center;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: rgba(0,0,0,0.5);
        }

        .hero-content {
            position: relative;
            text-align: center;
            color: white;
        }

        .hero-content h1 {
            font-size: 75px;
            letter-spacing: 6px;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.5);
        }

        .hero-content p {
            font-size: 24px;
            color: #ffcc00;
            margin-top: 10px;
            letter-spacing: 3px;
        }

        /* ================= STORY ================= */

        .story-section {
            width: 90%;
            margin: 90px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 60px;
            flex-wrap: wrap;
        }

        .story-image {
            position: relative;
        }

        .story-image img {
            width: 480px;
            border-radius: 30px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.25);
            display: block;
        }

        .story-image::before {
            content: '';
            position: absolute;
            top: -15px;
            left: -15px;
            width: 100%;
            height: 100%;
            border: 4px solid #ff7b00;
            border-radius: 30px;
            z-index: -1;
        }

        .story-text {
            flex: 1;
            min-width: 300px;
        }

        .story-text .tag {
            display: inline-block;
            background: #ff7b00;
            color: white;
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 16px;
            letter-spacing: 2px;
            margin-bottom: 20px;
        }

        .story-text h2 {
            font-size: 55px;
            color: #0d7a6d;
            margin-bottom: 25px;
            line-height: 1.1;
        }

        .story-text p {
            font-size: 24px;
            line-height: 42px;
            color: #555;
        }

        /* ================= FEATURES ================= */

        .features-section {
            background: white;
            padding: 80px 20px;
            margin-top: 20px;
        }

        .features-title {
            text-align: center;
            font-size: 55px;
            color: #0d7a6d;
            margin-bottom: 60px;
        }

        .features-title span {
            color: #ff7b00;
        }

        .features {
            width: 90%;
            margin: 0 auto;
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .feature-card {
            width: 280px;
            padding: 40px 30px;
            border-radius: 25px;
            text-align: center;
            border: 2px solid #f0e0d0;
            transition: 0.4s;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: #ff7b00;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border-color: #ff7b00;
        }

        .feature-icon {
            font-size: 50px;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            font-size: 28px;
            color: #0d7a6d;
            margin-bottom: 15px;
        }

        .feature-card p {
            font-size: 20px;
            color: #777;
            line-height: 32px;
        }

        /* ================= STATS ================= */

        .stats {
            background: #0d7a6d;
            padding: 80px 20px;
            display: flex;
            justify-content: center;
            gap: 80px;
            flex-wrap: wrap;
            text-align: center;
            margin-top: 0;
            position: relative;
        }

        .stats::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: #ff7b00;
        }

        .stat-box {
            padding: 20px 40px;
        }

        .stat-box h2 {
            font-size: 65px;
            color: #ffcc00;
            line-height: 1;
        }

        .stat-box p {
            font-size: 24px;
            color: rgba(255,255,255,0.85);
            margin-top: 10px;
            letter-spacing: 1px;
        }

        /* ================= GALLERY ================= */

        .gallery-section {
            width: 90%;
            margin: 80px auto;
        }

        .gallery-title {
            text-align: center;
            font-size: 55px;
            color: #0d7a6d;
            margin-bottom: 50px;
        }

        .gallery {
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 25px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }

        .gallery-item img {
            width: 300px;
            height: 220px;
            object-fit: cover;
            display: block;
            transition: 0.5s;
        }

        .gallery-item:hover img {
            transform: scale(1.1);
        }

        .gallery-item .overlay {
            position: absolute;
            inset: 0;
            background: rgba(13,122,109,0.7);
            display: flex;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: 0.4s;
        }

        .gallery-item:hover .overlay {
            opacity: 1;
        }

        .gallery-item .overlay span {
            color: white;
            font-size: 26px;
            letter-spacing: 2px;
        }

        /* ================= RESPONSIVE ================= */

        @media(max-width: 1000px) {

            .hero-content h1 { font-size: 45px; }

            .story-section {
                flex-direction: column;
                text-align: center;
            }

            .story-image img { width: 100%; }

            .story-image::before { display: none; }

            .stats { gap: 40px; }

        }

    </style>

    <!-- ================= HERO ================= -->

    <div class="hero">
        <div class="hero-content">
            <h1>ABOUT US</h1>
            <p>Fresh food • Fast service • Unforgettable taste</p>
        </div>
    </div>

    <!-- ================= STORY SECTION ================= -->

    <div class="story-section">

        <div class="story-image">
            <img src="images/chef.jpg" />
        </div>

        <div class="story-text">
            <span class="tag">OUR STORY</span>
            <h2>PASSION ON<br />EVERY PLATE</h2>
            <p>
                Since 2015, our restaurant has been serving authentic
                Lebanese flavors with modern taste and quality.
                We prepare fresh sandwiches, burgers, subs, and appetizers
                made with passion and premium ingredients — every single day.
            </p>
        </div>

    </div>

    <!-- ================= FEATURES ================= -->

    <div class="features-section">
        <h2 class="features-title">WHY CHOOSE <span>US</span></h2>

        <div class="features">

            <div class="feature-card">
                <div class="feature-icon">🥗</div>
                <h3>FRESH FOOD</h3>
                <p>Daily fresh ingredients and homemade recipes you can taste.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">🚀</div>
                <h3>FAST DELIVERY</h3>
                <p>Quick service and fast delivery to your door, everywhere.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">👨‍🍳</div>
                <h3>BEST CHEFS</h3>
                <p>Professional chefs preparing delicious meals with love.</p>
            </div>

        </div>
    </div>

    <!-- ================= STATS ================= -->

    <div class="stats">

        <div class="stat-box">
            <h2>10+</h2>
            <p>Years Experience</p>
        </div>

        <div class="stat-box">
            <h2>5000+</h2>
            <p>Happy Customers</p>
        </div>

        <div class="stat-box">
            <h2>50+</h2>
            <p>Menu Items</p>
        </div>

    </div>

    <!-- ================= GALLERY ================= -->

    <div class="gallery-section">
        <h2 class="gallery-title">OUR FOOD</h2>

        <div class="gallery">

            <div class="gallery-item">
                <img src="images/burgers.jpg" />
                <div class="overlay"><span>BURGERS</span></div>
            </div>

            <div class="gallery-item">
                <img src="images/sandwiches.jpg" />
                <div class="overlay"><span>SANDWICHES</span></div>
            </div>

             <div class="gallery-item">
                <img src="images/subs.jpg" />
                <div class="overlay"><span>SUBS</span></div>
            </div>

            <div class="gallery-item">
                <img src="images/appetizers.jpg" />
                <div class="overlay"><span>APPETIZERS</span></div>
            </div>
            


        </div>
    </div>

</asp:Content>