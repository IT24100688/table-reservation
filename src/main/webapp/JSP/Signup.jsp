<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="../css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form action="<%= request.getContextPath() %>/SignUpServlet" method="post">

            <h1>Create Account</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>or use your email for registration</span>
            <div class="infield">
                <input type="text" placeholder="Name" name="name" required />
                <label></label>
            </div>
            <div class="infield">
                <input type="email" placeholder="Email" name="email" required />
                <label></label>
            </div>
            <div class="infield phone-field">
                <input type="tel" placeholder="Phone Number" name="number" required />
                <label></label>
            </div>
            <div class="infield">
                <input type="password" placeholder="Password" name="password" required />
                <label></label>
            </div>
            <button type="submit">Sign Up</button>
        </form>
    </div>
    <div class="form-container sign-in-container">
        <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
            <h1>Sign in</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <span>or use your account</span>
            <div class="infield">
                <input type="email" placeholder="Email" name="email" required />
                <label></label>
            </div>
            <div class="infield">
                <input type="password" placeholder="Password" name="password" required />
                <label></label>
            </div>
            <a href="#" class="forgot">Forgot your password?</a>
            <button type="submit">Sign In</button>
        </form>
    </div>
    <div class="overlay-container" id="overlayCon">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>Hello, Friend!</h1>
                <p>Enter your personal details and start journey with us</p>
                <button>Sign Up</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>Welcome Back!</h1>
                <p>To keep connected with us please login with your personal info</p>
                <button>Sign In</button>
            </div>
        </div>
        <button id="overlayBtn"></button>
    </div>
</div>
</body>
</html>

<script>
    document.getElementById('overlayBtn').addEventListener('click', function() {
        document.getElementById('container').classList.toggle('right-panel-active');
    });
</script>
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
        background: url("https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=1950&q=80 ");
        display: grid;
        place-content: center;
        font-family: 'Poppins', sans-serif;
    }

    .container{
        position: relative;
        width: 850px;
        height: 500px;
        background-color: #FFFF;
        box-shadow: 25px 30px 55px #5557;
        border-radius: 13px;
        overflow: hidden;
    }
    .form-container{
        position: absolute;
        width: 60%;
        height: 100%;
        padding: 0px 40px;
        transition: all 0.6s ease-in-out;
    }
    .sign-up-container{
        opacity: 0;
        z-index: 1;
    }
    .sign-in-container{
        z-index: 2;
    }
    form{
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 0px 50px;
    }
    h1{
        color: var(--grad-clr1);
    }
    .social-container {
        display: flex; /* Ensures icons are properly spaced */
        justify-content: center; /* Centers them */
        gap: 10px; /* Adds spacing between icons */
        margin: 10px 0;
    }

    .social {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: #eee;
        text-decoration: none;
        font-size: 20px;
        color: #333;
        transition: background 0.3s;
    }

    .social:hover {
        background-color: #ddd;
    }

    span{
        font-size: 12px;
    }
    .infield{
        position: relative;
        margin: 8px 0px;
        width: 100%;
    }
    input{
        width: 100%;
        padding: 12px 15px;
        background-color: #f3f3f3;
        border: none;
        outline: none;
    }
    label{
        position: absolute;
        left: 50%;
        top: 100%;
        transform: translateX(-50%);
        width: 0%;
        height: 2px;
        background: var(--linear-grad);
        transition: 0.3s;
    }
    input:focus ~ label{
        width: 100%;
    }
    a{
        color: #333;
        font-size:14px;
        text-decoration: none;
        margin: 15px 0px;
    }
    a.forgot{
        padding-bottom: 3px;
        border-bottom: 2px solid #EEE;
    }
    button{
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
    .form-container button{
        margin-top: 17px;
        transition: 80ms ease-in;
    }
    .form-container button:hover{
        background: #FFF;
        color: var(--grad-clr1);
    }
    .overlay-container{
        position:absolute;
        top: 0;
        left: 60%;
        width: 40%;
        height: 100%;
        overflow: hidden;
        transition: transform 0.6s ease-in-out;
        z-index: 9;
    }
    #overlayBtn{
        cursor: pointer;
        position: absolute;
        left: 50%;
        top:304px;
        transform: translateX(-50%);
        width: 143.67px;
        height: 40px;
        border: 1px solid #FFF;
        background: transparent;
        border-radius: 20px;
    }
    .overlay{
        position: relative;
        background: var(--linear-grad);
        color: #FFF;
        left: -150%;
        height: 100%;
        width: 250%;
        transition: transform 0.6s ease-in-out;
    }
    .overlay-panel{
        position: absolute;
        display: flex;
        align-items:center;
        justify-content: center;
        flex-direction: column;
        padding: 0px 40px;
        text-align: center;
        height: 100%;
        width: 340px;
        transition: 0.6s ease-in-out;
    }
    .overlay-left{
        right: 60%;
        transform: translateX(-12%);
    }
    .overlay-right{
        right: 0;
        transform: translateX(0%);
    }
    .overlay-panel h1{
        color: #FFF;
    }
    p{
        font-size: 14px;
        font-weight: 300;
        line-height: 20px;
        letter-spacing: 0.5px;
        margin: 25px 0px 35px;
    }
    .overlay-panel button{
        border: none;
    }
    .right-panel-active .overlay-container{
        transform: translateX(-150%);
    }
    .right-panel-active .overlay{
        transform: translateX(50%);
    }
    .right-panel-active .overlay-left{
        transform: translateX(25%);
    }
    .right-panel-active .overlay-right{
        transform: translateX(35%);
    }
    .right-panel-active .sign-in-container{
        transform: translateX(20%);
        opacity: 0;
    }
    .right-panel-active .sign-up-container{
        transform: translateX(66.7%);
        opacity: 1;
        z-index: 5;
        animation: show 0.6s;
    }
    @keyframes show {
        0%, 50%{
            opacity: 0;
            z-index: 1;
        }
        50.1%, 100%{
            opacity: 1;
            z-index: 5;
        }
    }
    .btnScaled{
        animation: scaleBtn 0.6s;
    }
    @keyframes scaleBtn {
        0%{
            width: 143.67px;
        }
        50%{
            width: 250px;
        }
        100%{
            width: 143.67px;
        }

    }


</style>
</body>
</html>
