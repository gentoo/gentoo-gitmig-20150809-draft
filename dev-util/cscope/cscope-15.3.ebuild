# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.3.ebuild,v 1.8 2002/07/23 10:38:06 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"
HOMEPAGE="http://cscope.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_compile() {                           

	econf || die
	make clean || die
	emake || die
}

src_install() {                               
	einstall || die

	dodoc NEWS AUTHORS TODO COPYING Changelog INSTALL README*
}
