#!/bin/bash

# Изменение репозиториев Termux
termux-change-repo

# Обновление пакетов
pkg upgrade -y 

# Установка proot-distro
pkg install proot-distro -y 

# Установка дистрибутива Ubuntu
proot-distro install ubuntu

# Настройка хранилища
termux-setup-storage 

# Ожидание 10 секунд
sleep 10 

# Переход в директорию downloads
cd storage/downloads 

# Копирование ASF
cp ASF -r /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/ 

# Обновление пакетов в Ubuntu
proot-distro login ubuntu -- apt update 

# Обновление пакетов в Ubuntu
proot-distro login ubuntu -- apt upgrade -y 

# Установка dotnet-sdk-8.0 в Ubuntu
proot-distro login ubuntu -- apt-get install -y dotnet-sdk-8.0 

# Создание символической ссылки
proot-distro login ubuntu -- ln -s /root/ASF/ASF-generic/ArchiSteamFarm.sh ArchiSteamFarm.sh 

# Установка pip и python3
proot-distro login ubuntu -- apt install -y python3 python3-pip 

# Установка зависимостей из requirements.txt
proot-distro login ubuntu -- pip install -r /root/ASF/ASFBot-master/ASFBot-master/requirements.txt --break-system-packages

# Создание символической ссылки для bot.py
proot-distro login ubuntu -- ln -s /root/ASF/ASFBot-master/ASFBot-master/bot.py bot.py

# Переход в нужную директорию для настройки окружения
cd /data/data/com.termux/files/usr/var/lib/proot-distro/installed-rootfs/ubuntu/etc/profile.d/

# Запись строки в файл dotnet-env.sh
echo "export DOTNET_GCHeapHardLimit=1C0000000" > dotnet-env.sh