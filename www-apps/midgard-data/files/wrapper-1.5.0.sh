#!/bin/bash

function die {
	echo $1
	exit 1
}

# default values for db stuff
D_HOST="localhost"
D_ADMIN="root"
D_USER="midgard"
D_USERHOST="localhost"
D_IP="127.0.0.1"
D_PORT="80"
D_BLOBDIR="/var/www/localhost/htdocs/midgardblobs"

read_vars() {
	read -p "Database host [${D_HOST}]: " MY_HOST
	if (test -z ${MY_HOST}) ; then MY_HOST=${D_HOST} ; fi

	read -p "Database admin [${D_ADMIN}]: " MY_ADMIN
	if (test -z ${MY_ADMIN}) ; then MY_ADMIN=${D_ADMIN}; fi

	read -p "Database admin pass: " MY_PASS
	if (test -z ${MY_PASS}) ; then die "Admin password required"; fi

	read -p "Database user [${D_USER}]: " MY_USER
	if (test -z ${MY_USER}) ; then MY_USER=${D_USER}; fi

	read -p "Database user pass: " MY_USERPASS
	if (test -z ${MY_USERPASS}) ; then die "User password required"; fi

	read -p "Hostname [${D_USERHOST}]: " MY_USERHOST
	if (test -z ${MY_USERHOST}) ; then MY_USERHOST=${D_USERHOST}; fi

	read -p "IP [${D_IP}]: " MY_IP
	if (test -z ${MY_IP}) ; then MY_IP=${D_IP}; fi

	read -p "Port [${D_PORT}]: " MY_PORT
	if (test -z ${MY_PORT}) ; then MY_PORT=${D_PORT}; fi

	echo "Put the blobdir so that Apache can serve files from it"
	read -p "Blobdir [${D_BLOBDIR}]: " MY_BLOBDIR
	if (test -z ${MY_BLOBDIR}) ; then MY_BLOBDIR=${D_BLOBDIR}; fi

	echo "****WARNING!****"
	echo "If you answer new, your existing database will be dropped!"
	echo "Answer upgrade only if a database already exists"
	echo "****WARNING!****"
	read -p "Install type, new|upgrade: " MY_INSTALL
	if (test -z ${MY_INSTALL}) ; then die "You must specify new or upgrade"; fi
	if [ ${MY_INSTALL} != "new" -a ${MY_INSTALL} != "upgrade" ]; then
		die "Invalid answer"
	fi
}

make_dirs() {
	if [ ! -d ${MY_BLOBDIR} ]; then
		mkdir -p ${MY_BLOBDIR} || die  "Could not mkdir ${BLOBDIR}"
	fi
	cd ${MY_BLOBDIR} || die
	for A in 0 1 2 3 4 5 6 7 8 9 A B C D E F; do
		for B in 0 1 2 3 4 5 6 7 8 9 A B C D E F; do
			mkdir -p ${A}/${B} && touch ${A}/${B}/.keep
		done
	done
}

do_configure() {
	cd ${ROOT}/usr/share/${P}
	./configure \
		--with-db-host=${MY_HOST} \
		--with-db-admin-user=${MY_ADMIN} \
		--with-db-admin-password=${MY_PASS} \
		--with-db-user=${MY_USER} \
		--with-db-user-password=${MY_USERPASS} \
		--with-host=${MY_USERHOST} \
		--with-ip=${MY_IP} \
		--with-blobdir=${MY_BLOBDIR} \
		--with-apxs=/usr/sbin/apxs \
		--with-apache-user=apache \
		--with-apache-group=apache \
		--with-asgard \
		--with-adminsite \
		--with-install=${MY_INSTALL}
}

do_install() {
	./dbinstall
}

instructions() {
	echo
	echo
	echo "Now cp `pwd`/midgard-data.conf /etc/apache/conf/addon-modules"
	echo "And add it to your /etc/apache/conf/apache.conf"
	echo "You will need to edit it to set MidgardRootFile,"
	echo "which is located somewhere in your Apache DOCUMENT_ROOT"
	echo
	echo "Now you can login: http://yourhost/asgard - new interface"
	echo "or http://yourhost/admin - old interface"
	echo "If the bundled Asgard is broken, emerge www-apps/asgard"
}

# main
read_vars
make_dirs
do_configure
do_install
instructions
