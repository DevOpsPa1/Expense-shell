log_file="/tmp/expense.log"
if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi
MYSQL_ROOT_PASSWORD=$1
echo -e "\e[36m Dsable NodeJS default Version \e[0m"
dnf module disable nodejs -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Enable NodeJS 18 VErsion \e[0m"
dnf module enable nodejs:18 -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Install NodeJS \e[0m"
dnf install nodejs -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Copy backend Service File  \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
id expense &>>log_file
if [ $? -ne 0 ]; then
 echo -e "\e[36m Add Application User \e[0m"
 useradd expense &>>log_file
 if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
  else
  echo -e "\e[31m failure \e[0m"
  fi
fi

if [ ! -d /app ]; then
  echo -e "\e[36m Creating Application Dir \e[0m"
  mkdir /app &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

echo -e "\e[36m DElete old Application Content \e[0m"
rm -rm /app/* &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

echo -e "\e[36m Download Application Content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi

echo -e "\e[36m Extract Application content \e[0m"
cd /app &>>log_file
unzip /tmp/backend.zip &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Download NodeJs Dependencies \e[0m"
npm install &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Install MySQL Clint to Schema \e[0m"
dnf install mysql -y &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Load Schema \e[0m"
mysql -h 172.31.87.3 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi
echo -e "\e[36m Starting Backend Service \e[0m"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m failure \e[0m"
fi