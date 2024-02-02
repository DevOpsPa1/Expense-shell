log_file="/tmp/expense.log"

colour="\e[33m"
Status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m Sucesses \e[0m"
  else
    echo -e "\e[31m failure \e[0m"
  fi
}