log_file="/tmp/expense.log"
Status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m Sucesses \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
  fi
}
echo -e "\e[36m Installing nginx \e[0m"
dnf install nginx -y &>>log_file
Status_check

echo -e "\e[36m Copy Expense Config file file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
Status_check
echo -e "\e[36m Clean Old Nginx Content \e[0m"
rm -rf /usr/share/nginx/html/* &>>log_file
Status_check
echo -e "\e[36m Download Frontend Application Code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
Status_check
echo -e "\e[36m Extract Downloaded Application Content \e[0m"
cd /usr/share/nginx/html &>>log_file
unzip /tmp/frontend.zip &>>log_file
Status_check
echo -e "\e[36m Starting Nginx Service \e[0m"
systemctl enable nginx &>>log_file
systemctl start nginx &>>log_file
Status_check
#systemctl restart nginx.
