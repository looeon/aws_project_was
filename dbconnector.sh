sudo cd /root && sudo cpio -idmv < /root/mysql-connector-j.cpio
sudo cp /root/usr/share/java/mysql-connector-j.jar /root/apache-tomcat-10.1.20/lib/mysql-connector-j.jar
sudo chmod 640 /root/apache-tomcat-10.1.20/lib/mysql-connector-j.jar
sudo mkdir -p /root/apache-tomcat-10.1.20/webapps/ROOT/WEB-INF/lib
sudo cp /root/apache-tomcat-10.1.20/lib/mysql-connector-j.jar /root/apache-tomcat-10.1.20/webapps/ROOT/WEB-INF/lib/