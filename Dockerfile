FROM ubuntu:18.04
MAINTAINER Gentoo9ball <gentoo9ball@gmail.com>

RUN	export DEBIAN_FRONTEND=noninteractive && \
	apt update && \
	apt -y upgrade && \
	apt -y install apache2 libapache2-mod-php php-mysql php php-gd php-pear php-curl php-ldap git pwgen mariadb-client && \
	apt -y install gcc make autoconf libc-dev pkg-config libmcrypt-dev php7.2-dev && \
	pecl install mcrypt-1.0.1 && \
	echo 'extension=mcrypt.so' >> /etc/php/7.2/apache2/php.ini && \
	cd /var/www/ && \
	rm -f html/index.html && \
	git clone https://github.com/gentoo9ball/hashtopolis-server.git hashtopolis && \
	mv hashtopolis/src/* html/ && \
	mv /var/www/html/inc /var/www && \
	mkdir /var/www/html/inc && \
	mkdir -p /var/www/html/inc/utils/locks && \
	chown -R www-data:www-data /var/www/html && \
	ln -sf /dev/stdout /var/log/apache2/access.log && \
	ln -sf /dev/sterr /var/log/apache2/error.log && \
	echo "ServerName Hashtopolis" > /etc/apache2/conf-enabled/serverName.conf && \
	rm -rf /var/lib/apt /var/lib/dpkg /var/cache/apt /usr/share/doc /usr/share/man /usr/share/info
COPY	entrypoint.sh 	/
COPY	conf.php /var/www/
COPY	adduser.php /var/www/html/install/

EXPOSE 80
ENTRYPOINT [ "/entrypoint.sh" ]
