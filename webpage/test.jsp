<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>DB Connection Test</title>
</head>
<body>
<%
String DB_URL = "jdbc:mysql://192.168.120.30:3306/test";
String DB_USER = "test";
String DB_PASSWORD= "mypass";

Connection conn = null;
Statement stmt = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    stmt = conn.createStatement();
    conn.close();
    out.println("DB 연동 성공입니다!!");
} catch(Exception e) {
    out.println("에러 메시지: " + e.getMessage());
} finally {
    try {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
</body>
</html>
