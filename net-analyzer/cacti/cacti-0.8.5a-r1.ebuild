# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.5a-r1.ebuild,v 1.2 2004/08/17 14:36:48 eldad Exp $

inherit eutils webapp-apache

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.raxnet.net/products/cacti/"
SRC_URI="http://www.raxnet.net/downloads/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64"
IUSE="snmp mysql"

DEPEND=""
RDEPEND="net-www/apache
	snmp? ( virtual/snmp )
	net-analyzer/rrdtool
	mysql? ( dev-db/mysql )
	dev-php/php
	dev-php/mod_php"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/cacti-0.8.5a-sql-injection.patch
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}
	dodir ${destdir}

	dohtml docs/{INSTALL,UPGRADE}.htm
	dodoc docs/{CHANGELOG,CONTRIB}
	dodoc LICENSE

	#rm docs/{INSTALL,UPGRADE,INSTALL-WIN32}.htm
	rm docs/{README,CHANGELOG,CONTRIB}
	rm LICENSE README

	#Don't overwrite old config
	mv include/config.php include/config-sample.php

	#mv docs/manual .
	rm -rf docs
	rm -rf cactid

	edos2unix `find -type f -name '*.php'`
	#chown -R ${HTTPD_USER}.${HTTPD_GROUP} *
	cp -r . ${D}/${HTTPD_ROOT}/${PN}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
}

pkg_postinst() {
	# check to see if we have a previous version installed
	ver_installed="$(ls -d /var/db/pkg/net-analyzer/cacti* | sed 's:.*cacti-::')"
	if [[ ${ver_installed} != ${PV} ]]
	then
		einfo
		einfo "The cacti has been installed to ${HTTPD_ROOT}${PN}"
		einfo
		einfo "Before cacti works you must upgrade the cacti database:"
		einfo "1. Backup the old cacti database:"
		einfo "  shell> mysqlhotcopy --suffix=_old cacti"
		einfo "2. Drop the old cacti database:"
		einfo "  shell> mysqladmin -p drop cacti"
		einfo "3. Create the new cacti database"
		einfo "  shell> mysqladmin --user=root create cacti"
		einfo "4. Import the default cacti database:"
		einfo "  shell> mysql cacti < ${HTTPD_ROOT}${PN}/cacti.sql"
		einfo "5. Edit ${HTTPD_ROOT}${PN}/include/config.php."
		einfo " + Modify the MySQL user, password and database for your"
		einfo "   cacti configuration."
		einfo "		\$database_default = \"cacti\";"
		einfo "		\$database_hostname = \"localhost\";"
		einfo "		\$database_username = \"cactiuser\";"
		einfo "		\$database_password = \"cacti\";"
		einfo "6. Add this line to your /etc/crontab file:"
		einfo "   */5 * * * * ${HTTPD_USER} php ${HTTPD_ROOT}${PN}/cmd.php > /dev/null 2>&1"
		einfo "7. Point your web browser to:  http://your-server/cacti/"
		einfo " Select \"Upgrade\"."
		einfo " Make sure to fill in all of the path variables carefully and"
		einfo " correctly on the following screen."
		einfo
		einfo "FINALLY, you must have these settings in your php.ini:"
		einfo " register_globals = On"
		einfo " register_argc_argv = On"
		einfo
		einfo "Test your upgraded installation.  When all is fine you can"
		einfo "drop the cacti_old database like so:"
		einfo "  shell> mysqladmin -p drop cacti_old"
		einfo
	else
		einfo
		einfo "The cacti has been copied to ${HTTPD_ROOT}${PN}"
		einfo
		einfo "Before cacti works you must:"
		einfo "1. Create the new cacti database"
		einfo "  shell> mysqladmin --user=root create cacti"
		einfo "2. Import the default cacti database:"
		einfo "  shell> mysql cacti < ${HTTPD_ROOT}${PN}/cacti.sql"
		einfo "3. Optional: Create a MySQL username and password for cacti."
		einfo "  shell> mysql --user=root mysql"
		einfo "  mysql> GRANT ALL ON cacti.* TO cactiuser@localhost IDENTIFIED BY 'somepassword';"
		einfo "  mysql> flush privileges;"
		einfo "4. Copy ${HTTPD_ROOT}${PN}/include/config-sample.php to config.php."
		einfo " + Modify the MySQL user, password and database for your"
		einfo "   cacti configuration."
		einfo "		\$database_default = \"cacti\";"
		einfo "		\$database_hostname = \"localhost\";"
		einfo "		\$database_username = \"cactiuser\";"
		einfo "		\$database_password = \"cacti\";"
		einfo "5. Add this line to your /etc/crontab file:"
		einfo "   */5 * * * * ${HTTPD_USER} php ${HTTPD_ROOT}${PN}/cmd.php > /dev/null 2>&1"
		einfo "6. Point your web browser to:  http://your-server/cacti/"
		einfo " Make sure to fill in all of the path variables carefully and"
		einfo " correctly on the following screen."
		einfo
		einfo "FINALLY, you must have these settings in your php.ini:"
		einfo " register_globals = On"
		einfo " register_argc_argv = On"
		einfo
	fi
}
