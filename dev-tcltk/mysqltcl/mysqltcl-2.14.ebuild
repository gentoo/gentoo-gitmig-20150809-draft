# Copyright 2000-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-2.14.ebuild,v 1.1 2003/06/05 06:51:07 robbat2 Exp $

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"

DEPEND="
	>=dev-lang/tcl-8.1.0
	>=dev-lang/tk-8.1.0
	dev-db/mysql"
RDEPEND="${DEPEND}"
IUSE=""
LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
        make DESTDIR=${D} install || die
		dodoc AUTHORS COPYING README README-msqltcl ChangeLog
		dohtml doc/mysqltcl.html
		prepalldocs
}
