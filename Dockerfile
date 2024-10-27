FROM ubuntu:20.04

ENV TZ='Europe/Moscow'
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -y tzdata


# Установка необходимых пакетов и зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    git \
    libgl1 \
    libgtk2.0-dev \
    libgtk-3-dev \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libexpat1 \
    libxss1 \
    libxtst6 \
    python3 \
    python3-pip

# Скачивание и установка Unity 2018.4.27f1 для Linux
RUN wget -q https://download.unity3d.com/download_unity/ab112815652e/unity-editor_amd64-2018.4.27f1.deb
RUN dpkg -i unity-editor_amd64-2018.4.27f1.deb

# Копирование проекта Unity в контейнер
COPY . /project

# Установка рабочей директории
WORKDIR /project

# Открытие порта для WebGL-сборки
EXPOSE 8060

# Скрипт для сборки и запуска WebGL
RUN echo '#!/bin/bash' > runUnity.sh
RUN echo 'mkdir -p /project/WebGL-Dist' >> runUnity.sh
RUN echo '/opt/Unity/Editor/Unity -quit -batchmode -projectPath /project -buildWebGL /project/WebGL-Dist' >> runUnity.sh
RUN echo 'cd /project/WebGL-Dist' >> runUnity.sh 
RUN echo 'python3 -m http.server 8000' >> runUnity.sh
RUN chmod +x runUnity.sh

# Запуск скрипта при старте контейнера
CMD ["/bin/bash", "/project/runUnity.sh"]