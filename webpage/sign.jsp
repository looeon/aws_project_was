<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Page</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, rgba(255,215,0,1), rgba(255,215,0,0));
            font-family: Arial, sans-serif;
        }

        .container {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-box {
            background-color: rgba(255, 255, 255, 0.7); /* 반투명한 흰색 배경 */
            border-radius: 20px; /* 둥근 모서리 */
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
            width: 300px; /* 회원가입인 박스의 너비 */
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 10px;
            border: none;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #4CAF50; /* 회원가입 버튼의 배경색 */
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* 마우스 호버시 색상 변경 */
        }

        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            background-color: transparent;
            border: none;
            cursor: pointer;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="container">
        <button onclick="location.href='http://192.168.120.10'" class="back-button">←</button>
        <div class="login-box">
            <h2>회원가입</h2>
            <form action="dbwrite.jsp" method="post">
                <label for="username">유저이름:</label><br>
                <input type="text" id="username" name="username"><br>
                <label for="password">비밀번호:</label><br>
                <input type="password" id="password" name="password"><br><br>
                <input type="submit" value="회원가입">
            </form>
        </div>
    </div>
</body>
</html>
