# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.6b.ebuild,v 1.1 2004/10/14 04:41:29 eldad Exp $

inherit eutils webapp

DESCRIPTION="Cacti is a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
SRC_URI="http://www.cacti.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="snmp"

DEPEND=""

# TODO: RDEPEND Not just apache... but there's no virtual/webserver (yet)

RDEPEND="net-www/apache
	snmp? ( virtual/snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	virtual/cron
	dev-php/php
	dev-php/mod_php"

check_useflag() {
	local my_pkg=$(best_version ${1})
	local my_flag=${2}

	if [[ $(grep -wo ${my_flag} /var/db/pkg/${my_pkg}/USE) ]]
	then
		return 0
	fi

	eerror "${my_pkg} was compiled without ${my_flag}. Please re-emerge it with USE=${my_flag}"
	die "check_useflag failed"

}

pkg_setup() {
	webapp_pkg_setup

	# Check if php, mod_php was emerged with mysql useflag

	check_useflag dev-php/php mysql
	check_useflag dev-php/mod_php mysql
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	webapp_src_preinst

	dodoc LICENSE
	rm LICENSE README

	dodoc docs/{CHANGELOG,CONTRIB,INSTALL,README,REQUIREMENTS,UPGRADE}
	rm -rf docs
	#Don't overwrite old config
	mv include/config.php include/config-sample.php

	edos2unix `find -type f -name '*.php'`

	dodir ${D}${MY_HTDOCSDIR}
	cp -r . ${D}${MY_HTDOCSDIR}

	webapp_src_install
}

pkg_postinst() {
	local webserver_root=${VHOST_ROOT}/${VHOST_HTDOCS_INSECURE}

	einfo "Install Notes: Assuming your webserver is at ${webserver_root},"
	einfo "and that the webserver group is ${VHOST_DEFAULT_GID}."
	einfo
	einfo "New Install"
	einfo
	einfo "1. Create the new cacti database"
	einfo "	 shell> mysqladmin --user=root create cacti"
	einfo "2. Import the default cacti database:"
	einfo "	 shell> mysql cacti < ${webserver_root}/${PN}/cacti.sql"
	einfo "3. Optional: Create a MySQL username and password for cacti."
	einfo "	 shell> mysql --user=root mysql"
	einfo "	 mysql> GRANT ALL ON cacti.* TO cactiuser@localhost IDENTIFIED BY 'somepassword';"
	einfo "	 mysql> flush privileges;"
	einfo "4. Copy ${webserver_root}/${PN}/include/config-sample.php to config.php."
	einfo " + Modify the MySQL user, password and database for your"
	einfo "	  cacti configuration."
	einfo "		\$database_default = \"cacti\";"
	einfo "		\$database_hostname = \"localhost\";"
	einfo "		\$database_username = \"cactiuser\";"
	einfo "		\$database_password = \"cacti\";"
	einfo "6. Point your web browser to:  http://your-server/cacti/"
	einfo " Make sure to fill in all of the path variables carefully and"
	einfo " correctly on the following screen."
	einfo
	einfo "Upgrading"
	einfo
	einfo "Before cacti works you must upgrade the cacti database:"
	einfo "1. Backup the old cacti database:"
	einfo "	 shell> mysqlhotcopy --suffix=_old cacti"
	einfo "2. Drop the old cacti database:"
	einfo "	 shell> mysqladmin -p drop cacti"
	einfo "3. Create the new cacti database"
	einfo "	 shell> mysqladmin --user=root create cacti"
	einfo "4. Import the default cacti database:"
	einfo "	 shell> mysql cacti < ${webserver_root}/${PN}/cacti.sql"
	einfo "5. Edit ${webserver_root}/${PN}/include/config.php."
	einfo " + Modify the MySQL user, password and database for your"
	einfo "	  cacti configuration."
	einfo "		\$database_default = \"cacti\";"
	einfo "		\$database_hostname = \"localhost\";"
	einfo "		\$database_username = \"cactiuser\";"
	einfo "		\$database_password = \"cacti\";"
	einfo "6. Point your web browser to:  http://your-server/cacti/"
	einfo " Select \"Upgrade\"."
	einfo " Make sure to fill in all of the path variables carefully and"
	einfo " correctly on the following screen."
	einfo "7. Test your upgraded installation. When all is fine you can"
	einfo "drop the cacti_old database like so:"
	einfo "	 shell> mysqladmin -p drop cacti_old"
	einfo
	einfo "Either new or upgrading, make sure you have a cron job -"
	einfo "Add this line to your /etc/crontab file:"
	einfo "	  */5 * * * * ${VHOST_DEFAULT_GID} php ${webserver_root}/${PN}/poller.php > /dev/null 2>&1"
	einfo
	einfo "FINALLY, you must have these settings in your php.ini:"
	einfo " register_globals = On"
	einfo " register_argc_argv = On"
	einfo
	ewarn "Note that you should use poller.php as the cronjob"
	ewarn "instead of cmd.php (as it was with earlier version)"
	ewarn "to enable you to switch between cmd.php and cactid."

	webapp_pkg_postinst
}
