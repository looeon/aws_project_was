<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Save Post</title>
    <meta http-equiv="refresh" content="0;url=http://192.168.120.20:8080/viewpost.jsp">
</head>
<body>
    <%
        // MySQL 연결 정보
        String JDBC_URL = "jdbc:mysql://192.168.120.30:3306/blog";
        String JDBC_USER = "test";
        String JDBC_PASSWORD = "mypass";

        // 입력된 제목과 내용 가져오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // SQL 쿼리 준비
            String sql = "INSERT INTO posts (title, content) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);

            // 쿼리 실행
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
    %>
            <h2>글이 성공적으로 저장되었습니다.</h2>
    <%
            } else {
    %>
            <h2>글 저장에 실패했습니다.</h2>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
    %>
            <h2>글 저장에 실패했습니다.</h2>
    <%
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
    %>
            <h2>글 저장에 실패했습니다.</h2>
    <%
        } finally {
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
</body>
</html>

