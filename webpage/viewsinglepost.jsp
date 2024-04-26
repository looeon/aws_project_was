<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Single Post</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, rgba(255, 239, 213, 1), rgba(255, 239, 213, 0)); /* 최상단부터 최하단까지 점점 투명해지는 배경 */
            font-family: Arial, sans-serif;
        }

        .post-container {
            margin-top: 20px;
            padding: 20px;
        }

        .post {
            border-bottom: 1px solid #ccc;
            padding-bottom: 20px;
        }

        .post h3 {
            margin-top: 0;
        }

        .post p {
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="post-container">
        <%
            int postId = Integer.parseInt(request.getParameter("postId"));