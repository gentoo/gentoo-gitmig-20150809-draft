# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-3.02.ebuild,v 1.3 2008/04/10 18:31:56 fmccor Exp $

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.1.0
	>=virtual/mysql-4.1"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS COPYING README README-msqltcl ChangeLog
	dohtml doc/mysqltcl.html
	prepalldocs
}
