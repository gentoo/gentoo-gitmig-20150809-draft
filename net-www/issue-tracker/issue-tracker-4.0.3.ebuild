# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/issue-tracker/issue-tracker-4.0.3.ebuild,v 1.1 2004/03/28 15:29:37 karltk Exp $

inherit webapp-apache

DESCRIPTION="Issue tracking system"
HOMEPAGE="http://www.issue-tracker.com/"
SRC_URI="mirror://sourceforge/issue-tracker/issue-tracker-4.0.3.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND="virtual/php
	|| ( dev-db/mysql dev-db/postgresql )"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	file ${S}/conf/const.php
	cp ${S}/conf/const.php ${S}/conf/const.php.b0rken || die
	sed -r 's/(Could not.*_URL_.*manually.*)\"\);/\1\";/' \
		< ${S}/conf/const.php.b0rken \
		> ${S}/conf/const.php || die
}

pkg_setup() {
	webapp-detect || export NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_install() {
	webapp-detect
	webapp-mkdirs

	dodir "${HTTPD_ROOT}/issue-tracker"
	cp -a * "${D}/${HTTPD_ROOT}/issue-tracker/"
	rm -rf "${D}/${HTTPD_ROOT}/issue-tracker/docs"

	dodoc docs/*

	chown -R "${HTTPD_USER}:${HTTPD_GROUP}" "${D}/${HTTPD_ROOT}/issue-tracker/"
	chmod 0755 "${D}/${HTTPD_ROOT}/issue-tracker"
	find "${D}/${HTTPD_ROOT}/issue-tracker/" -type d | xargs chmod 2775
	find "${D}/${HTTPD_ROOT}/issue-tracker/" -type f | xargs chmod 0664

}

pkg_postinst() {
	webapp-detect

	einfo "You will need to configure issue-tracker for a particular database"
	einfo ""
	einfo "(1) First, you must decide on:"
	einfo " - a database username, <it-username>"
	einfo " - a database name in the database, <it-dbname>"
	einfo ""
	einfo "(2) Next, you must create the database"
	einfo ""
	einfo "For MySQL:"
	einfo "mysqladmin -p -u <it-username> create <it-dbname>"
	einfo "mysql -p -u <it-username> <it-dbname> \\"
	einfo "      < ${HTTPD_ROOT}/issue-tracker/setup/schema.mysql"
	einfo "mysql -p -u <it-username> <it-dbname> \\"
	einfo "      < ${HTTPD_ROOT}/issue-tracker/setup/data.sql"
	einfo "mysql -p -u <it-username> <it-dbname> \\"
	einfo "      < ${HTTPD_ROOT}/issue-tracker/setup/indexes.sql"
	einfo ""
	einfo "For PostgreSQL:"
	einfo "createdb -U <it-username> <it-dbname>"
	einfo "psql -U <it-username> \\"
	einfo "     < ${HTTPD_ROOT}/issue-tracker/setup/schema.pgsql"
	einfo "psql -U <it-username> \\"
	einfo "     < ${HTTPD_ROOT}/issue-tracker/setup/data.sql"
	einfo "psql -U <it-username> \\"
	einfo "     < ${HTTPD_ROOT}/issue-tracker/setup/indexes.sql"
	einfo ""
	einfo "(3) Next, you will need to configure issue-tracker"
	einfo "cp ${HTTPD_ROOT}/issue-tracker/conf/config.php-default \\"
	einfo "   ${HTTPD_ROOT}/issue-tracker/conf/config.php"
	einfo ""
	einfo "Edit ${HTTPD_ROOT}/issue-tracker/conf/config.php"
	einfo "with name=<it-dbname>, user=<it-username> and the correct db info"
	einfo ""
	ewarn "Make sure you don't just edit the commented-out example;)"
	einfo ""
	ewarn "(4) Finally, you must log in to the issue-tracker as admin/demo, and"
	ewarn "change the password in Preferences."
}
