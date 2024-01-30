log_file="/tmp/expense.log"
echo -e "\e[36m Disable nodejs Default version \e[0m"
dnf module disable nodejs -y &>>log_file
echo -e "\e[36m Enable nodjs 18 version \e[0m"
dnf module enable nodejs:18 -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Install nodejs \e[0m"
dnf install nodejs -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Copy appliation file  \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Add user \e[0m"
useradd expense &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Creating Application Dir \e[0m"
mkdir /app &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Download Application \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
echo -e "\e[36m Unzip the application \e[0m"
cd /app &>>log_file
unzip /tmp/backend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Insatll the Application \e[0m"
cd /app &>>log_file
npm install &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Enable nodjs 18 version \e[0m"
systemctl daemon-reload &>>log_file

systemctl enable backend &>>log_file
systemctl start backend &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
dnf install mysql -y &>>log_file

mysql -h 172.31.87.3 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file