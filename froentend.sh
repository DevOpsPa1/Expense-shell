source common.sh

echo -e "${colour}  Installing nginx \e[0m"
dnf install nginx -y &>>log_file
Status_check

echo -e "${colour} m Copy Expense Config file file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
Status_check

echo -e "${colour} m Clean Old Nginx Content \e[0m"
rm -rf /usr/share/nginx/html/* &>>log_file
Status_check

echo -e "${colour} m Download Frontend Application Code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
Status_check

echo -e "${colour}  Extract Downloaded Application Content \e[0m"
cd /usr/share/nginx/html &>>log_file
unzip /tmp/frontend.zip &>>log_file
Status_check

echo -e "${colour}  Starting Nginx Service \e[0m"
systemctl enable nginx &>>log_file
systemctl start nginx &>>log_file
Status_check

#systemctl restart nginx.
