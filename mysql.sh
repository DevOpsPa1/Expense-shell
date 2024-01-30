log_file="/tmp/expense.log"
echo -e "\e[36m Disable default mysql \e[0m"
dnf module disable mysql -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m coppy the mysq repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m install mysql  \e[0m"
dnf install mysql-community-server -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m enable mysql \e[0m"
systemctl enable mysqld &>>log_file
echo -e "\e[36m Start mysql \e[0m"
systemctl start mysqld &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>log_file
