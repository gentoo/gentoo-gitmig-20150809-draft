# Copyright 2000-2003 Gentoo Technologies, Inc
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-2.14.ebuild,v 1.3 2003/08/07 03:27:13 vapier Exp $

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/tcl-8.1.0
	>=dev-lang/tk-8.1.0
	dev-db/mysql"

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
