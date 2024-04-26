sudo wget https://github.com/looeon/aws_project_was/raw/main/mysql-connector-j-8.3.0-1.el9.noarch.rpm -O /root/mysql-connector-j-8.3.0-1.el9.noarch.rpm
sudo rpm2cpio /root/mysql-connector-j-8.3.0-1.el9.noarch.rpm > /root/mysql-connector-j.cpio
sudo cd /root && sudo cpio -idmv < /root/mysql-connector-j.cpio
sudo cp /root/usr/share/java/mysql-connector-j.jar /root/apache-tomcat-10.1.20/lib/mysql-connector-j.jar
sudo chmod 640 /root/apache-tomcat-10.1.20/lib/mysql-connector-j.jar
sudo mkdir -p /root/apache-tomcat-10.1.20/webapps/ROOT/WEB-INF/lib
sudo cp /root/apache-tomcat-10.1.20/lib/mysql-connector-j.jar /root/apache-tomcat-10.1.20/webapps/ROOT/WEB-INF/lib/