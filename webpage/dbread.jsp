dbwrite.jsp                                                                                         0000644 0000000 0000000 00000010705 14612123754 011742  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8"
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

                                                           index.jsp                                                                                           0000640 0000000 0000000 00000027721 14612123776 011417  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%--
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--%>
<%@ page session="false" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy");
request.setAttribute("year", sdf.format(new java.util.Date()));
request.setAttribute("tomcatUrl", "https://tomcat.apache.org/");
request.setAttribute("tomcatDocUrl", "/docs/");
request.setAttribute("tomcatExamplesUrl", "/examples/");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title><%=request.getServletContext().getServerInfo() %></title>
        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="tomcat.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div id="wrapper">
            <div id="navigation" class="curved container">
                <span id="nav-home"><a href="${tomcatUrl}">Home</a></span>
                <span id="nav-hosts"><a href="${tomcatDocUrl}">Documentation</a></span>
                <span id="nav-config"><a href="${tomcatDocUrl}config/">Configuration</a></span>
                <span id="nav-examples"><a href="${tomcatExamplesUrl}">Examples</a></span>
                <span id="nav-wiki"><a href="https://cwiki.apache.org/confluence/display/TOMCAT/">Wiki</a></span>
                <span id="nav-lists"><a href="${tomcatUrl}lists.html">Mailing Lists</a></span>
                <span id="nav-help"><a href="${tomcatUrl}findhelp.html">Find Help</a></span>
                <br class="separator" />
            </div>
            <div id="asf-box">
                <h1>${pageContext.servletContext.serverInfo}</h1>
            </div>
            <div id="upper" class="curved container">
                <div id="congrats" class="curved container">
                    <h2>If you're seeing this, you've successfully installed Tomcat. Congratulations!</h2>
                </div>
                <div id="notice">
                    <img id="tomcat-logo" src="tomcat.svg" alt="[tomcat logo]" />
                    <div id="tasks">
                        <h3>Recommended Reading:</h3>
                        <h4><a href="${tomcatDocUrl}security-howto.html">Security Considerations How-To</a></h4>
                        <h4><a href="${tomcatDocUrl}manager-howto.html">Manager Application How-To</a></h4>
                        <h4><a href="${tomcatDocUrl}cluster-howto.html">Clustering/Session Replication How-To</a></h4>
                    </div>
                </div>
                <div id="actions">
                    <div class="button">
                        <a class="container shadow" href="/manager/status"><span>Server Status</span></a>
                    </div>
                    <div class="button">
                        <a class="container shadow" href="/manager/html"><span>Manager App</span></a>
                    </div>
                    <div class="button">
                        <a class="container shadow" href="/host-manager/html"><span>Host Manager</span></a>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <div id="middle" class="curved container">
                <h3>Developer Quick Start</h3>
                <div class="col25">
                    <div class="container">
                        <p><a href="${tomcatDocUrl}setup.html">Tomcat Setup</a></p>
                        <p><a href="${tomcatDocUrl}appdev/">First Web Application</a></p>
                    </div>
                </div>
                <div class="col25">
                    <div class="container">
                        <p><a href="${tomcatDocUrl}realm-howto.html">Realms &amp; AAA</a></p>
                        <p><a href="${tomcatDocUrl}jndi-datasource-examples-howto.html">JDBC DataSources</a></p>
                    </div>
                </div>
                <div class="col25">
                    <div class="container">
                        <p><a href="${tomcatExamplesUrl}">Examples</a></p>
                    </div>
                </div>
                <div class="col25">
                    <div class="container">
                        <p><a href="https://cwiki.apache.org/confluence/display/TOMCAT/Specifications">Servlet Specifications</a></p>
                        <p><a href="https://cwiki.apache.org/confluence/display/TOMCAT/Tomcat+Versions">Tomcat Versions</a></p>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <div id="lower">
                <div id="low-manage" class="">
                    <div class="curved container">
                        <h3>Managing Tomcat</h3>
                        <p>For security, access to the <a href="/manager/html">manager webapp</a> is restricted.
                        Users are defined in:</p>
                        <pre>$CATALINA_HOME/conf/tomcat-users.xml</pre>
                        <p>In Tomcat 10.1 access to the manager application is split between
                           different users. &nbsp; <a href="${tomcatDocUrl}manager-howto.html">Read more...</a></p>
                        <br />
                        <h4><a href="${tomcatDocUrl}RELEASE-NOTES.txt">Release Notes</a></h4>
                        <h4><a href="${tomcatDocUrl}changelog.html">Changelog</a></h4>
                        <h4><a href="${tomcatUrl}migration.html">Migration Guide</a></h4>
                        <h4><a href="${tomcatUrl}security.html">Security Notices</a></h4>
                    </div>
                </div>
                <div id="low-docs" class="">
                    <div class="curved container">
                        <h3>Documentation</h3>
                        <h4><a href="${tomcatDocUrl}">Tomcat 10.1 Documentation</a></h4>
                        <h4><a href="${tomcatDocUrl}config/">Tomcat 10.1 Configuration</a></h4>
                        <h4><a href="https://cwiki.apache.org/confluence/display/TOMCAT/">Tomcat Wiki</a></h4>
                        <p>Find additional important configuration information in:</p>
                        <pre>$CATALINA_HOME/RUNNING.txt</pre>
                        <p>Developers may be interested in:</p>
                        <ul>
                            <li><a href="https://tomcat.apache.org/bugreport.html">Tomcat 10.1 Bug Database</a></li>
                            <li><a href="${tomcatDocUrl}api/index.html">Tomcat 10.1 JavaDocs</a></li>
                            <li><a href="https://github.com/apache/tomcat/tree/10.1.x">Tomcat 10.1 Git Repository at GitHub</a></li>
                        </ul>
                    </div>
                </div>
                <div id="low-help" class="">
                    <div class="curved container">
                        <h3>Getting Help</h3>
                        <h4><a href="${tomcatUrl}faq/">FAQ</a> and <a href="${tomcatUrl}lists.html">Mailing Lists</a></h4>
                        <p>The following mailing lists are available:</p>
                        <ul>
                            <li id="list-announce"><strong><a href="${tomcatUrl}lists.html#tomcat-announce">tomcat-announce</a><br />
                                Important announcements, releases, security vulnerability notifications. (Low volume).</strong>
                            </li>
                            <li><a href="${tomcatUrl}lists.html#tomcat-users">tomcat-users</a><br />
                                User support and discussion
                            </li>
                            <li><a href="${tomcatUrl}lists.html#taglibs-user">taglibs-user</a><br />
                                User support and discussion for <a href="${tomcatUrl}taglibs/">Apache Taglibs</a>
                            </li>
                            <li><a href="${tomcatUrl}lists.html#tomcat-dev">tomcat-dev</a><br />
                                Development mailing list, including commit messages
                            </li>
                        </ul>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <div id="footer" class="curved container">
                <div class="col20">
                    <div class="container">
                        <h4>Other Downloads</h4>
                        <ul>
                            <li><a href="${tomcatUrl}download-connectors.cgi">Tomcat Connectors</a></li>
                            <li><a href="${tomcatUrl}download-native.cgi">Tomcat Native</a></li>
                            <li><a href="${tomcatUrl}taglibs/">Taglibs</a></li>
                            <li><a href="${tomcatDocUrl}deployer-howto.html">Deployer</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Other Documentation</h4>
                        <ul>
                            <li><a href="${tomcatUrl}connectors-doc/">Tomcat Connectors</a></li>
                            <li><a href="${tomcatUrl}connectors-doc/">mod_jk Documentation</a></li>
                            <li><a href="${tomcatUrl}native-doc/">Tomcat Native</a></li>
                            <li><a href="${tomcatDocUrl}deployer-howto.html">Deployer</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Get Involved</h4>
                        <ul>
                            <li><a href="${tomcatUrl}getinvolved.html">Overview</a></li>
                            <li><a href="${tomcatUrl}source.html">Source Repositories</a></li>
                            <li><a href="${tomcatUrl}lists.html">Mailing Lists</a></li>
                            <li><a href="https://cwiki.apache.org/confluence/display/TOMCAT/">Wiki</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Miscellaneous</h4>
                        <ul>
                            <li><a href="${tomcatUrl}contact.html">Contact</a></li>
                            <li><a href="${tomcatUrl}legal.html">Legal</a></li>
                            <li><a href="https://www.apache.org/foundation/sponsorship.html">Sponsorship</a></li>
                            <li><a href="https://www.apache.org/foundation/thanks.html">Thanks</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Apache Software Foundation</h4>
                        <ul>
                            <li><a href="${tomcatUrl}whoweare.html">Who We Are</a></li>
                            <li><a href="${tomcatUrl}heritage.html">Heritage</a></li>
                            <li><a href="https://www.apache.org">Apache Home</a></li>
                            <li><a href="${tomcatUrl}resources.html">Resources</a></li>
                        </ul>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <p class="copyright">Copyright &copy;1999-${year} Apache Software Foundation.  All Rights Reserved</p>
        </div>
    </body>

</html>
                                               login.jsp                                                                                           0000644 0000000 0000000 00000004774 14612124006 011412  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
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
            width: 300px; /* 로그인 박스의 너비 */
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
            background-color: #4CAF50; /* 로그인 버튼의 배경색 */
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
            <h2>로그인</h2>
            <form action="dbread.jsp" method="post">
                <label for="username">유저이름:</label><br>
                <input type="text" id="username" name="username"><br>
                <label for="password">비밀번호:</label><br>
                <input type="password" id="password" name="password"><br><br>
                <input type="submit" value="로그인">
            </form>
        </div>
    </div>
</body>
</html>

    makepost.jsp                                                                                        0000644 0000000 0000000 00000003723 14612123730 012121  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

                                             savepost.jsp                                                                                        0000644 0000000 0000000 00000004141 14612123760 012140  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

                                                                                                                                                                                                                                                                                                                                                                                                                               sign.jsp                                                                                            0000644 0000000 0000000 00000005014 14612123772 011237  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8"
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
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    test.jsp                                                                                            0000644 0000000 0000000 00000001607 14612124003 011246  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
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
                                                                                                                         tomcat.css                                                                                          0000640 0000000 0000000 00000012720 14612124027 011552  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   /*
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/
body {
    margin: 10px 20px;
    text-align: center;
    font-family: Arial, sans-serif;
}

h1,
h2,
h3,
h4,
h5,
h6,
p,
ul,
ol {
    margin: 0 0 0.5em;
}

h1 {
    font-size: 18pt;
    margin: 0.5em 0 0;
}

h2 {
    font-size: 16pt;
}

h3 {
    font-size: 13pt;
}

h4 {
    font-size: 12pt;
}

h5 {
    font-size: 11pt;
}

p {
    font-size: 11pt
}

ul {
    margin: 0;
    padding: 0 0 0 0.25em;
    text-indent: 0;
    list-style: none;
}

li {
    margin: 0;
    padding: 0 0 0.25em;
    text-indent: 0;
    font-size: 80%;
}

pre {
    text-indent: 0.25em;
    width: 90%;
    font-size: 90%;
}

br.separator {
    margin: 0;
    padding: 0;
    clear: both;
}

a img {
    border: 0 none;
}

.container {
    padding: 10px;
    margin: 0 0 10px;
}

.col20 {
    float: left;
    width: 20%;
}

.col25 {
    float: left;
    width: 25%;
}

#wrapper {
    display: block;
    margin: 0 auto;
    text-align: left;
    min-width: 720px;
    max-width: 1000px;
}

.curved {
    border-radius: 10px;
}

#tomcat-logo {
    width: 150px;
    height: 106px;
}

#navigation {
    background: #eee url(bg-nav.png) repeat-x top left;
    margin: 0 0 10px;
    padding: 0;
}

#navigation span {
    float: left;
}

#navigation span a {
    display: block;
    padding: 10px;
    font-weight: bold;
    text-shadow: 1px 1px 1px #fff;
}

#navigation span a:link,
#navigation span a:visited,
#navigation span a:hover,
#navigation span a:active {
    color: #666;
    text-decoration: none;
}

#navigation span#nav-help {
    float: right;
    margin-right: 0;
}

#asf-box {
    height: 40px;
    background: #fff url(asf-logo-wide.svg) no-repeat top right;
}

#asf-box h1 {
    margin: 0;
    line-height: 1.5;
}

#upper {
    background: #fff url(bg-upper.png) repeat-x top left;
}

#congrats {
    text-align: center;
    padding: 10px;
    margin: 0 40px 20px;
    background-color: #9c9;
}

#congrats h2 {
    font-size: 14pt;
    padding: 0;
    margin: 0;
    color: #fff;
}

#notice {
    float: left;
    width: 560px;
    color: #696;
}

#notice a:link,
#notice a:visited,
#notice a:hover,
#notice a:active {
    color: #090;
    text-decoration: none;
}

#notice img,
#notice #tasks {
    float: left;
}

#tasks a:link,
#tasks a:visited,
#tasks a:hover,
#tasks a:active {
    text-decoration: underline;
}

#notice img {
    margin-right: 20px;
}

#actions {
    float: right;
    width: 140px;
}

#actions .button {
    display: block;
    padding: 0;
    height: 36px;
    background: url(bg-button.png) no-repeat top left;
}

#actions .button a {
    display: block;
    padding: 0;
}

#actions .button a:link,
#actions .button a:visited,
#actions .button a:hover,
#actions .button a:active {
    color: #696;
    text-decoration: none;
}

#actions .button a span {
    display: block;
    padding: 6px 10px;
    color: #666;
    text-shadow: 1px 1px 1px #fff;
    font-size: 10pt;
    font-weight: bold;
}

#middle {
    background: #eef url(bg-middle.png) repeat-x top left;
    margin: 20px 0;
    padding: 1px 10px;
}

#middle h3 {
    margin: 0 0 10px;
    color: #033;
}

#middle p {
    font-size: 10pt;
}

#middle a:link,
#middle a:visited,
#middle a:hover,
#middle a:active {
    color: #366;
    font-weight: bold;
}

#middle .col25 .container {
    padding: 0 0 1px;
}

#developers {
    float: left;
    width: 40%;
}

#security {
    float: right;
    width: 50%;
}

#lower {
    padding: 0;
}

#lower a:link,
#lower a:visited,
#lower a:hover,
#lower a:active {
    color: #600;
}

#lower strong a:link,
#lower strong a:visited,
#lower strong a:hover,
#lower strong a:active {
    color: #c00;
}

#lower h3 {
    color: #963;
    font-size: 14pt;
}

#lower h4 {
    font-size: 12pt;
}

#lower ul {
    padding: 0;
    margin: 0.5em 0;
}

#lower p,
#lower li {
    font-size: 9pt;
    color: #753;
    margin: 0 0 0.1em;
}

#lower li {
    padding: 3px 5px;
}

#lower li strong {
    color: #a53;
}

#lower li#list-announce {
    border: 1px solid #f90;
    background-color: #ffe8c8;
}

#lower p {
    font-size: 10.5pt;
}

#low-manage,
#low-docs,
#low-help {
    float: left;
    width: 32%;
}

#low-docs {
    margin: 0 0 0 2.2%;
}

#low-help {
    float: right;
}

#low-manage div,
#low-docs div,
#low-help div {
    min-height: 280px;
    border: 3px solid #ffdc75;
    background-color: #fff1c8;
    padding: 10px;
}

#footer {
    padding: 0;
    margin: 20px 0;
    color: #999;
    background-color: #eee;
}

#footer h4 {
    margin: 0 0 10px;
    font-size: 10pt;
}

#footer p {
    margin: 0 0 10px;
    font-size: 10pt;
}

#footer ul {
    margin: 6px 0 1px;
    padding: 0;
}

#footer li {
    margin: 0;
    font-size: 9pt;
}

#footer a:link,
#footer a:visited,
#footer a:hover,
#footer a:active {
    color: #666;
}

.copyright {
    font-size: 10pt;
    color: #666;
}                                                viewmypost.jsp                                                                                      0000644 0000000 0000000 00000000000 14612123747 012515  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   viewpost.jsp                                                                                        0000644 0000000 0000000 00000013421 14612123765 012162  0                                                                                                    ustar   root                            root                                                                                                                                                                                                                   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               