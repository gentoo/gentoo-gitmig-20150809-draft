# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-20030510-r1.ebuild,v 1.2 2004/01/05 23:28:33 robbat2 Exp $

DESCRIPTION="Basic authentication for Apache using a MySQL database"
HOMEPAGE="http://modauthmysql.sourceforge.net/"

S=${WORKDIR}/${PN}
SRC_URI="mirror://sourceforge/modauthmysql/${PN}.tgz"
DEPEND="dev-db/mysql
		net-www/apache
		apache2? ( >=net-www/apache-2* )"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE="apache2"
SLOT="0"

if use apache2 ; then
	APXS="apxs2 -D APACHE2"
	DESTDIR=/usr/lib/apache2-extramodules
	CONFDIR=/etc/apache2/conf/modules.d
else
	APXS="apxs -D APACHE1"
	DESTDIR=/usr/lib/apache-extramodules
	CONFDIR=/etc/apache/conf/addon-modules
fi

src_compile() {
	$APXS -c ${PN}.c -I/usr/include/mysql -lmysqlclient -lm -lz || die
}

src_install() {
	exeinto $DESTDIR
	doexe ${PN}.so
	insinto ${CONFDIR}
	doins ${FILESDIR}/mod_auth_mysql.conf
	cat mod_auth_mysql.c | head -n81 \
		| cut -c 4- > mod_auth_mysql.txt
	dodoc ${FILESDIR}/mod_auth_mysql.conf \
		README
}

pkg_postinst() {
	if use apache2; then
		einfo "Please add '-D AUTH_MYSQL' to your /etc/conf.d/apache2 APACHE2_OPTS setting"
	else
		einfo "Please add '-D AUTH_MYSQL' to your /etc/conf.d/apache APACHE_OPTS setting"
	fi
}
