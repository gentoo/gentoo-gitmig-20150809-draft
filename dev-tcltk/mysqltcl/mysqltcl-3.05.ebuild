# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-3.05.ebuild,v 1.2 2010/03/24 21:30:28 robbat2 Exp $

inherit multilib

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.1.0
	>=virtual/mysql-4.1"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README README-msqltcl ChangeLog
	dohtml doc/mysqltcl.html
	prepalldocs
}

src_compile() {
	econf --with-mysql-lib=/usr/$(get_libdir)/mysql || die
	emake || die
}
