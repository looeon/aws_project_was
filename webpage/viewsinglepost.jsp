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

            String JDBC_URL = "jdbc:mysql://192.168.120.30:3306/blog";
            String JDBC_USER = "test"; // MySQL 사용자명
            String JDBC_PASSWORD = "mypass"; // MySQL 비밀번호

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

                String selectSql = "SELECT * FROM posts WHERE post_id=?";
                pstmt = conn.prepareStatement(selectSql);
                pstmt.setInt(1, postId);
                resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    String title = resultSet.getString("title"); // 제목
                    String content = resultSet.getString("content"); // 내용
                    Timestamp createdAt = resultSet.getTimestamp("created_at"); // 작성일
        %>
                    <div class="post">
                        <h3><%= title %></h3>
                        <p><%= content %></p>
                        <p><strong>작성일:</strong> <%= createdAt %></p>
                    </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } finally {
                if (resultSet != null) {
                    try {
                        resultSet.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>

