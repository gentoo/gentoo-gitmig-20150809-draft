# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_vdbh/mod_vdbh-1.0.2-r1.ebuild,v 1.1 2003/08/17 23:03:21 robbat2 Exp $

DESCRIPTION="An Apache2 DSO for mass virtual hosting using a MySQL database"
HOMEPAGE="http://www.synthemesc.com/mod_vdbh/"

S=${WORKDIR}/${P}
SRC_URI="http://www.synthemesc.com/downloads/${PN}/${P}.tar.gz"
DEPEND="=net-www/apache-2* >=dev-db/mysql-3.23* >=sys-libs/zlib-1.1.4"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE=""
SLOT="0"

src_compile() {
	apxs2 -DHAVE_STDDEF_H -I/usr/include/mysql -Wl,-lmysqlclient \
		-c ${PN}.c || die
}

src_install() {
	exeinto /usr/lib/apache2-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache2/conf/modules.d
	doins ${FILESDIR}/21_mod_vdbh.conf
	dodoc ${FILESDIR}/21_mod_vdbh.conf AUTHORS COPYING README TODO
}
