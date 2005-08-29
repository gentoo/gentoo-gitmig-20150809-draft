# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-mccp/tcl-mccp-0.6.ebuild,v 1.3 2005/08/29 19:49:56 dang Exp $

DESCRIPTION="mccp extension to TCL"
HOMEPAGE="http://tcl-mccp.sf.net/"
SRC_URI="mirror://sourceforge/tcl-mccp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/tcl"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
