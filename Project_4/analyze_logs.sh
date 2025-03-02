#!/bin/bash

# Проверяем наличие файла
if [ ! -f access.log ]; then
    echo "Файл отсутствует"
    exit 1
fi

# Общее количества запросов
total_requests=$(wc -l < access.log)

# Подсчет уникальных IP-адресов
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)

# Подсчет количества запросов по методам
request_methods=$(awk '{print $6}' access.log | sort | uniq -c)

# Поиск самого популярного URL
popular_url=$(awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -n 1)

# Создание отчета
{
    echo "Отчет по логе веб-сервиса"
    echo "==========================="
    echo "Общее количество запросов: $total_requests"
    echo "Количество уникальных IP-адресов: $unique_ips"
    echo "Количество запросов по методам:"
    echo "$request_methods"
    echo "Самый популярный URL: $popular_url"
} > report.txt

# Сообщение о завершении
echo "Отчет создан в файле report.txt"
