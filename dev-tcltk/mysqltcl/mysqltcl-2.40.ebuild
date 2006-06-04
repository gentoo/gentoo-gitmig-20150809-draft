# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-2.40.ebuild,v 1.5 2006/06/04 02:49:37 matsuu Exp $

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"
IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/tcl-8.1.0
	dev-db/mysql"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug 119873
	sed -i -e "s/relid'/relid/" configure tclconfig/tcl.m4 || die
}

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
