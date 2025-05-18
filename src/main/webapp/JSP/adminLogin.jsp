<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Form</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap');

        * {
            padding: 0px;
            margin: 0px;
            box-sizing: border-box;
        }

        :root {
            --linear-grad: linear-gradient(to right, #141E30, #243B55);
            --grad-clr1: #141E30;
            --grad-clr2: #243B55;
        }

        body {
            height: 100vh;
            background: #f6f5f7;
            display: grid;
            place-content: center;
            font-family: 'Poppins', sans-serif;
        }

        .container {
            position: relative;
            width: 850px;
            height: 500px;
            background-color: #FFFF;
            box-shadow: 25px 30px 55px #5557;
            border-radius: 13px;
            overflow: hidden;
        }

        .form-container {
            position: absolute;
            width: 60%;
            height: 100%;
            padding: 0px 40px;
            transition: all 0.6s ease-in-out;
        }

        form {
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 0px 50px;
        }

        h1 {
            color: var(--grad-clr1);
            padding: 12px 15px;
        }

        .infield {
            position: relative;
            margin: 8px 0px;
            width: 100%;
        }

        input {
            width: 100%;
            padding: 12px 15px;
            background-color: #f3f3f3;
            border: none;
            outline: none;
        }

        label {
            position: absolute;
            left: 50%;
            top: 100%;
            transform: translateX(-50%);
            width: 0%;
            height: 2px;
            background: var(--linear-grad);
            transition: 0.3s;
        }

        input:focus ~ label {
            width: 100%;
        }

        button {
            border-radius: 20px;
            border: 1px solid var(--grad-clr1);
            background: var(--grad-clr2);
            color: #FFF;
            font-size: 12px;
            font-weight: bold;
            padding: 12px 45px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .form-container button {
            margin-top: 17px;
            transition: 80ms ease-in;
        }

        .form-container button:hover {
            background: #FFF;
            color: var(--grad-clr1);
        }

        .overlay-container {
            position: absolute;
            top: 0;
            left: 60%;
            width: 40%;
            height: 100%;
            overflow: hidden;
            transition: transform 0.6s ease-in-out;
            z-index: 9;
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--linear-grad);
            color: #FFF;
            transition: transform 0.6s ease-in-out;
        }

        .overlay-panel {
            position: absolute;
            top: 0;
            right: 0;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0px 40px;
            text-align: center;
            transition: 0.6s ease-in-out;
        }

        .overlay-panel h1 {
            color: #FFF;
        }

        p {
            font-size: 14px;
            font-weight: 300;
            line-height: 20px;
            letter-spacing: 0.5px;
            margin: 25px 0px 35px;
        }
    </style>
</head>
<body>
<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form action="<%= request.getContextPath() %>/AdminServlet" method="post">

            <h1>Log in as Admin!</h1>
            <% String error = request.getParameter("error");
                if (error != null) { %>
            <p class="error-msg"><%= error %></p>
            <% } %>
            <div class="infield">
                <input type="text" name="username" placeholder="Name" />
                <label></label>
            </div>

            <div class="infield">
                <input type="password" name="password" placeholder="Password" />
                <label></label>
            </div>
            <button>LOG IN</button>
        </form>
    </div>

    <div class="overlay-container" id="overlayCon">
        <div class="overlay">
            <div class="overlay-panel overlay-right">
                <h1>Hello, Admin!</h1>
                <p>Manage reservations and keep everything running smoothly with ease</p>

            </div>
        </div>
    </div>
</div>
</body>
</html>
