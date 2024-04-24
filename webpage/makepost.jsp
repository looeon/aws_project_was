<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Make Post</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.5), rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0));
            font-family: Arial, sans-serif;
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
            margin-bottom: 50px;
        }

        h2 {
            text-align: center;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 10px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        textarea {
            height: 200px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>글 작성하기</h2>
        <form action="savepost.jsp" method="post">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title">
            <label for="content">내용:</label>
            <textarea id="content" name="content"></textarea>
            <br><br>
            <input type="submit" value="저장">
        </form>
    </div>
</body>
</html>

