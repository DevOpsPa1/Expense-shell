source common.sh

if [ -z "$1" ]; then
  echo Password Input Missing
  exit
fi
MYSQL_ROOT_PASSWORD=$1
echo -e "${colour} Dsable NodeJS default Version \e[0m"
dnf module disable nodejs -y &>>log_file
Status_check

echo -e "${colour}  Enable NodeJS 18 VErsion \e[0m"
dnf module enable nodejs:18 -y &>>log_file
Status_check

echo -e "${colour} Install NodeJS \e[0m"
dnf install nodejs -y &>>log_file
Status_check

echo -e "${colour}  Copy backend Service File  \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file
Status_check

id expense &>>log_file
if [ $? -ne 0 ]; then
 echo -e "${colour}  Add Application User \e[0m"
 useradd expense &>>log_file
 Status_check

if [ ! -d /app ]; then
  echo -e "${colour}  Creating Application Dir \e[0m"
  mkdir /app &>>log_file
Status_check

echo -e "${colour}  DElete old Application Content \e[0m"
rm -rm /app/* &>>log_file
Status_check

echo -e "${colour}  Download Application Content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
Status_check

echo -e "${colour}  Extract Application content \e[0m"
cd /app &>>log_file
unzip /tmp/backend.zip &>>log_file
Status_check

echo -e "${colour}  Download NodeJs Dependencies \e[0m"
npm install &>>log_file
Status_check

echo -e "${colour} Install MySQL Clint to Schema \e[0m"
dnf install mysql -y &>>log_file
Status_check

echo -e "${colour}  Load Schema \e[0m"
mysql -h mysql-dev.pavanbalubadi3017.online -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>log_file
Status_check

echo -e "${colour}  Starting Backend Service \e[0m"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl start backend &>>log_file
Status_check
