FROM php:5.6-cli

# # Install mysql and cron
# RUN apt-get update && apt-get install -y \
# 		wget

ADD ./ /app

WORKDIR /app

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'a5c698ffe4b8e849a443b120cd5ba38043260d5c4023dbf93e1558871f1f07f58274fc6f4c93bcfd858c6bd0775cd8d1') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/local/bin/
RUN php -r "unlink('composer-setup.php');"

CMD ["php", "-f", "/app/docker/daemon.php"]

