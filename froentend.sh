log_file=expense.log

echo -e "\e[36m install nginx \e[0m"
dnf install nginx -y &>>log_file
echo $?
echo -e "\e[36m copy expense.conf file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
echo $?
echo -e "\e[36m remove nginx defult content \e[0m"
rm -rf /usr/share/nginx/html/* &>>log_file
echo $?
echo -e "\e[36m download the frontend file \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
echo $?
echo -e "\e[36m unzip frontend file \e[0m"
cd /usr/share/nginx/html &>>log_file
echo $?
unzip /tmp/frontend.zip &>>log_file
echo $?
echo -e "\e[36m eanble and start nginx \e[0m"
systemctl enable nginx &>>log_file
systemctl start nginx &>>log_file
echo $?
#systemctl restart nginx.
