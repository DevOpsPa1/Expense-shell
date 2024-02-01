log_file="/tmp/expense.log"
if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "\e[36m Disable Mysql default Version \e[0m"
dnf module disable mysql -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m copy MySQL Repo file\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Install MySQL Server \e[0m"
dnf install mysql-community-server -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Start MySQL Server \e[0m"
systemctl enable mysqld &>>log_file
systemctl start mysqld &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Set MySQL Password \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi