dnf module disable nodejs -y
dnf module enable nodejs:18 -y
if [ $? -eq 0 ]; then
  echo -e "\e[36m Sucesses \e[0m"
else
  echo -e "\e[32m Sucesses \e[0m"
fi

dnf install nodejs -y
if [ $? -eq 0 ]; then
  echo -e "\e[36m Sucesses \e[0m"
else
  echo -e "\e[32m Sucesses \e[0m"
fi
cp backend.service /etc/systemd/system/backend.service
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m Sucesses \e[0m"
fi
useradd expense
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m Sucesses \e[0m"
fi

mkdir /app
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m Sucesses \e[0m"
fi
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m Sucesses \e[0m"
fi

cd /app
npm install
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m Sucesses \e[0m"
fi
systemctl daemon-reload

systemctl enable backend
systemctl start backend
if [ $? -eq 0 ]; then
  echo -e "\e[32m Sucesses \e[0m"
else
  echo -e "\e[31m Sucesses \e[0m"
fi
dnf install mysql -y

mysql -h 172.31.20.39 -uroot -pExpenseApp@1 < /app/schema/backend.sql