<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>DB Write Result</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, rgba(255,215,0,1), rgba(255,215,0,0));
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .result-box {
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .button-container {
            margin-top: 20px;
        }

        .button-container a {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
        }

        .button-container a:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="result-box">
        <%
        // 사용자가 입력한 ID와 PASSWORD 가져오기
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // MySQL 연결 정보
        String JDBC_URL = "jdbc:mysql://192.168.120.30:3306/test";
        String JDBC_USER = "test";
        String JDBC_PASSWORD = "mypass";

        Connection conn = null;
        PreparedStatement statement = null;

        try {
            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // 쿼리 작성
            String selectSql = "SELECT * FROM users WHERE username = ?";
            PreparedStatement selectStatement = conn.prepareStatement(selectSql);
            selectStatement.setString(1, username);
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                // 이미 존재하는 사용자인 경우
        %>
                <h2>이미 존재하는 사용자입니다.</h2>
                <div class="button-container">
                    <a href="http://192.168.120.20:8080/sign.jsp">다시 가입하기</a>
                    <a href="http://192.168.120.20:8080/login.jsp">로그인 하기</a>
                </div>
        <%
            } else {
                // 회원가입 시도
                // 쿼리 작성
                String insertSql = "INSERT INTO users (username, password) VALUES (?, ?)";

                // PreparedStatement 생성
                statement = conn.prepareStatement(insertSql);

                // 쿼리 파라미터 설정
                statement.setString(1, username);
                statement.setString(2, password);

                // 쿼리 실행
                int rowsInserted = statement.executeUpdate();

                if (rowsInserted > 0) {
                    // 회원가입 성공
        %>
                    <h2>회원가입 성공!</h2>
                    <p>사용자: <%= username %></p>
                    <div class="button-container">
                        <a href="http://192.168.120.20:8080/login.jsp">로그인 하기</a>
                    </div>
        <%
                } else {
                    // 회원가입 실패
        %>
                    <h2>회원가입 실패!</h2>
        <%
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        %>
            <p>회원가입 중 오류가 발생했습니다.</p>
        <%
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        %>
            <p>JDBC 드라이버를 찾을 수 없습니다.</p>
        <%
        } finally {
            // 리소스 해제
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
</body>
</html>

