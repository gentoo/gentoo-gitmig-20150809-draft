# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-20030510.ebuild,v 1.1 2003/05/25 08:31:56 robbat2 Exp $

DESCRIPTION="Basic authentication for Apache using a MySQL database"
HOMEPAGE="http://modauthmysql.sourceforge.net/"

S=${WORKDIR}/${PN}
SRC_URI="mirror://sourceforge/modauthmysql/${PN}.tgz"
DEPEND="dev-db/mysql =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

if [ -n "`use apache2`" ]; then
	APXS="apxs2 -D APACHE2"
else
	APXS="apxs -D APACHE1"
fi

src_compile() {
	$APXS -c ${PN}.c -I/usr/include/mysql -lmysqlclient -lm -lz || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/12_mod_auth_mysql.conf
	cat mod_auth_mysql.c | head -81 \
		| cut -c 4- > mod_auth_mysql.txt
	dodoc ${FILESDIR}/12_mod_auth_mysql.conf \
		README
}

pkg_postinst() {
	einfo "Please add '-D AUTH_MYSQL' to your /etc/conf.d/apache2 APACHE2_OPTS setting"
}
