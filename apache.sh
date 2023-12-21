#apache.sh

#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "hii krishna" >/var/www/html/index.html
