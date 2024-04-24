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
            <a href="http://192.168.120.20:8080/viewmypost.jsp">내가 쓴 글 보기</a>
        </div>
    </div>

    <button class="write-post-btn" onclick="location.href='http://192.168.120.20:8080/makepost.jsp'">
        글쓰기
    </button>

    <h2>저장된 글 목록</h2>
    <div class="post-container">
        <%
            String JDBC_URL = "jdbc:mysql://192.168.120.30:3306/blog";
            String JDBC_USER = "test"; // MySQL 사용자명
            String JDBC_PASSWORD = "mypass"; // MySQL 비밀번호

            Connection conn = null;
            Statement statement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

                String selectSql = "SELECT posts.*, users.username FROM posts INNER JOIN users ON posts.author_id = users.user_id ORDER BY posts.created_at DESC"; // 작성일 기준으로 내림차순 정렬
                statement = conn.createStatement();
                resultSet = statement.executeQuery(selectSql);

                while (resultSet.next()) {
                    int postId = resultSet.getInt("post_id"); // 포스트 ID
                    String title = resultSet.getString("title"); // 제목
                    String content = resultSet.getString("content"); // 내용
                    Timestamp createdAt = resultSet.getTimestamp("created_at"); // 작성일
                    String author = resultSet.getString("username"); // 작성자
        %>
                    <div class="post">
                        <h3><a href="http://192.168.120.20:8080/viewsinglepost.jsp?postId=<%= postId %>"><%= title %></a> - 작성자: <%= author %></h3>
                        <p class="content-preview"><%= content.substring(0, Math.min(content.length(), 100)) %></p>
                        <%-- content의 일부만 표시하고 더 보기 링크 제공 --%>
                        <p><a href="http://192.168.120.20:8080/viewsinglepost.jsp?postId=<%= postId %>">더 보기</a></p>
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
                if (statement != null) {
                    try {
                        statement.close();
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
    <script>
        function logout() {
            <% session.invalidate(); %>
            window.location.href = 'http://192.168.120.10';
        }

        // 뒤로가기 방지
        history.pushState(null, null, window.location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
</body>
</html>

