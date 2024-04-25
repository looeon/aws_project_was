                            <%@ page language="java" contentType="text/html; charset=UTF-8"
                              pageEncoding="UTF-8"%>
                            <%@ page import="java.sql.*" %>
                            <%@ page import="javax.servlet.http.*" %>
                            <!DOCTYPE html>
                            <html>
                            <head>
                              <title>Login Result</title>
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
                                  String username = request.getParameter("username");
                                  String password = request.getParameter("password");

                                  Connection conn = null;
                                  PreparedStatement statement = null;
                                  ResultSet resultSet = null;

                                  try {
                                      // MySQL 연결 정보
                                      String JDBC_URL = "jdbc:mysql://192.168.120.30:3306/test";
                                      String JDBC_USER = "test";
                                      String JDBC_PASSWORD = "mypass";

                                      // 데이터베이스 연결
                                      Class.forName("com.mysql.cj.jdbc.Driver");
                                      conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

                                      // 쿼리 작성
                                      String sql = "SELECT * FROM users WHERE username = ?";

                                      // PreparedStatement 생성
                                      statement = conn.prepareStatement(sql);

                                      // 쿼리 파라미터 설정
                                      statement.setString(1, username);

                                      // 쿼리 실행
                                      resultSet = statement.executeQuery();

                                      if (resultSet.next()) {
                                          // 사용자가 존재하는 경우
                                          String storedPassword = resultSet.getString("password");
                                          if (password.equals(storedPassword)) {
                                              // 로그인 성공
                                              // 세션에 사용자명 저장
                                              session = request.getSession();
                                              session.setAttribute("username", username);
                                              // 리다이렉트
                                              response.sendRedirect("viewpost.jsp");
                                          } else {
                                              // 비밀번호가 틀린 경우
                                  %>
                                              <h2>잘못된 비밀번호입니다.</h2>
                                              <div class="button-container">
                                                  <a href="login.jsp">다시 로그인하기</a>
                                                  <a href="sign.jsp">가입하기</a>
                                              </div>
                                  <%
                                          }
                                      } else {
                                          // 사용자가 존재하지 않는 경우
                                  %>
                                          <h2>존재하지 않는 사용자입니다.</h2>
                                          <div class="button-container">
                                              <a href="login.jsp">다시 로그인하기</a>
                                              <a href="sign.jsp">가입하기</a>
                                          </div>
                                  <%
                                      }
                                  } catch (SQLException e) {
                                      e.printStackTrace();
                                      out.println("An error occurred while processing login!");
                                  } catch (ClassNotFoundException e) {
                                      e.printStackTrace();
                                      out.println("JDBC driver not found!");
                                  } finally {
                                      // 리소스 해제
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
                            </body>
                            </html>

