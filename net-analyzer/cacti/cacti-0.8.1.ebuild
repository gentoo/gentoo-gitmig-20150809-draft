# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.1.ebuild,v 1.3 2003/06/11 15:37:39 tad Exp $

DESCRIPTION="Cacti is a complete frondend to rrdtool"
HOMEPAGE="http://www.raxnet.net/products/cacti/"
SRC_URI="http://www.raxnet.net/downloads/${P}.tar.gz"

IUSE="snmp"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND=""
RDEPEND="net-www/apache
	snmp? ( virtual/snmp )
	net-analyzer/rrdtool
	dev-db/mysql
	dev-php/php
	dev-php/mod_php"

# Allow users to move the default data directory by setting the
# home directory of the 'apache' user elsewhere.
HTTPD_ROOT=`grep apache /etc/passwd | cut -d: -f6`/htdocs
[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"

INSTALL_DEST="${HTTPD_ROOT}/cacti"

src_install() {
	dohtml docs/{INSTALL,UPGRADE}.htm
	dodoc docs/{CHANGELOG,CONTRIB}
	dodoc LICENSE

	rm docs/{INSTALL,UPGRADE,INSTALL-WIN32}.htm
	rm docs/{README,CHANGELOG,CONTRIB}
	rm LICENSE README

	mv docs/manual .
	rm -fr docs

	dodir ${INSTALL_DEST}
	chown apache.apache * -R
	mv * ${D}/${INSTALL_DEST}/
}

pkg_postinst() {
	# check to see if we have a previous version installed
	minor_inst="$(ls -d /var/db/pkg/net-analyzer/cacti*|head -n 1|cut -d\. -f2)"
	rel_inst="$(ls -d /var/db/pkg/net-analyzer/cacti*|head -n 1|cut -d\. -f3)"
	if [ ${minor_inst}${rel_inst} -lt 81 ]
	then
		einfo
		einfo "The cacti has been installed to ${INSTALL_DEST}"
		einfo
		einfo "Before cacti works you must upgrade the cacti database:"
		einfo "1. Backup the old cacti database:"
		einfo "  shell> mysqlhotcopy --suffix=_old cacti"
		einfo "2. Drop the old cacti database:"
		einfo "  shell> mysqladmin -p drop cacti"
		einfo "3. Create the new cacti database"
		einfo "  shell> mysqladmin --user=root create cacti"
		einfo "4. Import the default cacti database:"
		einfo "  shell> mysql cacti < ${INSTALL_DEST}/cacti.sql"
		einfo "5. Edit ${INSTALL_DEST}/include/config.php."
		einfo " + Modify the MySQL user, password and database for your" 
		einfo "   cacti configuration."
		einfo "		\$database_default = \"cacti\";"
		einfo "		\$database_hostname = \"localhost\";"
		einfo "		\$database_username = \"cactiuser\";"
		einfo "		\$database_password = \"cacti\";"
		einfo "6. Point your web browser to:  http://your-server/cacti/"
		einfo " Select \"Upgrade\"."
		einfo " Make sure to fill in all of the path variables carefully and"
		einfo " correctly on the following screen."
		einfo
		einfo "FINALLY, you must have these settings in your php.ini:"
		einfo " register_globals = On"
		einfo " register_argc_argv = On"
		einfo
		einfo "Test your upgraded installation.  When all is fine you can"
		eingo "drop the cacti_old database like so:"
		einfo "  shell> mysqladmin -p drop cacti_old"
		einfo
	else
		einfo
		einfo "The cacti has been copied to ${INSTALL_DEST}"
		einfo
		einfo "Before cacti works you must:"
        einfo "1. Create the new cacti database"
		einfo "  shell> mysqladmin --user=root create cacti"
		einfo "2. Import the default cacti database:"
		einfo "  shell> mysql cacti < ${INSTALL_DEST}/cacti.sql"
		einfo "3. Optional: Create a MySQL username and password for cacti."
		einfo "  shell> mysql --user=root mysql"
		einfo "  mysql> GRANT ALL ON cacti.* TO cactiuser@localhost IDENTIFIED BY 'somepassword';"
		einfo "  mysql> flush privileges;"
		einfo "4. Edit ${INSTALL_DEST}/include/config.php."
		einfo " + Modify the MySQL user, password and database for your" 
		einfo "   cacti configuration."
		einfo "		\$database_default = \"cacti\";"
		einfo "		\$database_hostname = \"localhost\";"
		einfo "		\$database_username = \"cactiuser\";"
		einfo "		\$database_password = \"cacti\";"
		einfo "5. Point your web browser to:  http://your-server/cacti/"
		einfo " Make sure to fill in all of the path variables carefully and"
		einfo " correctly on the following screen."
		einfo
		einfo "FINALLY, you must have these settings in your php.ini:"
		einfo " register_globals = On"
		einfo " register_argc_argv = On"
		einfo
	fi
}
