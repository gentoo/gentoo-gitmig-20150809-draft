# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-sql/tcl-sql-20000114.ebuild,v 1.3 2004/08/30 23:36:11 dholm Exp $

inherit eutils

DESCRIPTION="A generic Tcl interface to SQL databases."
HOMEPAGE="http://www.parand.com/tcl-sql/"
SRC_URI="mirror://sourceforge/tcl-sql/${PN}-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="dev-lang/tcl
	dev-db/mysql"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	chmod +w sql-mysql.cc
	epatch ${FILESDIR}/fix-const.patch
}

src_compile() {
	emake || die
}

src_install() {
	mkdir -p ${D}/usr/lib/tcl-sql
	cp sql.so ${D}/usr/lib/tcl-sql/libtcl-sql.so
	dodoc CHANGES.txt CODE_DESCRIPTION.txt LICENSE.txt docs/sample.full.txt docs/sample.simple.txt
	dohtml README.html docs/api.html
}

