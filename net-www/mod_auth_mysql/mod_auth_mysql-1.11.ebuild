# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-1.11.ebuild,v 1.5 2004/01/05 23:28:33 robbat2 Exp $

DESCRIPTION="Basic authentication for Apache2 using a MySQL database"
HOMEPAGE="ftp://ftp.kciLink.com/pub/"

S=${WORKDIR}/${P}
SRC_URI="mirror://gentoo/mod_auth_mysql-1.11-gentoo.tar.bz2"
DEPEND="=dev-db/mysql-3* =net-www/apache-2*"
LICENSE="Apache-1.1"
KEYWORDS="x86"
IUSE=""
SLOT="0"

src_compile() {
	apxs2 -c ${PN}.c -I/usr/include/mysql -Wl,-lmysqlclient || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/12_mod_auth_mysql.conf
	cat mod_auth_mysql.c | tail -n +84 | head -n 101 \
		| cut -c 4- > mod_auth_mysql.txt
	dodoc ${FILESDIR}/12_mod_auth_mysql.conf \
		mysql-group-auth.txt mod_auth_mysql.txt
}
