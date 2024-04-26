<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Posts</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, rgba(255, 239, 213, 1), rgba(255, 239, 213, 0)); /* 최상단부터 최하단까지 점점 투명해지는 배경 */
            font-family: Arial, sans-serif;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 20px;
            background-color: rgba(255, 255, 255, 0.7);
        }

        .write-post-btn {
            background-color: #007bff;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        .write-post-btn:hover {
            background-color: #0056b3;
        }

        .post-container {
            margin-top: 20px;
            padding: 20px;
            min-height: 100vh; /* 최소 높이 설정 */
        }

        .post {
            margin-bottom: 20px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 20px;
        }

        .post h3 {
            margin-top: 0;
        }

        .post p {
            margin-bottom: 0;
        }

        .user-info {
            text-align: center;
            margin-top: 10px;
        }

        .logout-btn {
            background-color: #ff0000;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #cc0000;
        }

        .content-preview {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="header">
        <div></div> <!-- 이 공간은 로그아웃 버튼이 오른쪽으로 이동하면서 자동으로 채워집니다. -->
        <div class="user-info">
            현재 로그인한 사용자: <%= session.getAttribute("username") %> <!-- 세션에 저장된 username 가져오기 -->
            <button class="logout-btn" onclick="logout()">로그아웃</button>