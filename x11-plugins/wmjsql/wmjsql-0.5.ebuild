# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmjsql/wmjsql-0.5.ebuild,v 1.5 2004/11/22 10:12:46 s4t4n Exp $

IUSE=""

MY_P="${PN}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MySQL monitor dockapp"
SRC_URI="http://www.dockapps.org/download.php/id/73/${P}.tar.gz"
HOMEPAGE="http://www.dockapps.org/file.php/id/42"

DEPEND="virtual/x11
	>=dev-db/mysql-4.0.20"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {
	cd ${S}/src
	make clean
	emake CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install() {
	cd ${S}/src
	dobin wmjsql
	newdoc conf sample.wmjsql

	cd ${S}
	dodoc CREDITS INSTALL README TODO

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
