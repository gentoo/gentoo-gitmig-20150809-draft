# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-sql/tcl-sql-20000114.ebuild,v 1.1 2004/08/08 15:10:00 cardoe Exp $

inherit eutils

DESCRIPTION="A generic Tcl interface to SQL databases."
HOMEPAGE="http://www.parand.com/tcl-sql/"
SRC_URI="mirror://sourceforge/tcl-sql/${PN}-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/tcl
	dev-db/mysql"

S=${WORKDIR}/${PN}

src_compile() {
	chmod +w sql-mysql.cc

	epatch ${FILESDIR}/fix-const.patch

	sed -i -e 's|(int resHandle=0)|(int resHandle)|g' sql-mysql.cc || die "sed failed"
	sed -i -e 's|char \*msg = mysql_error|char \*msg = (char *)mysql_error|' sql-mysql.cc || die "sed failed"
	echo '#define USE_OLD_FUNCTIONS' > sql-mysql.cc.temp
	cat sql-mysql.cc >> sql-mysql.cc.temp
	mv sql-mysql.cc.temp sql-mysql.cc
	emake || die
}

src_install() {
	mkdir -p ${D}/usr/lib/tcl-sql
	cp sql.so ${D}/usr/lib/tcl-sql/libtcl-sql.so
	dodoc CHANGES.txt CODE_DESCRIPTION.txt LICENSE.txt docs/sample.full.txt docs/sample.simple.txt
	dohtml README.html docs/api.html
}

