# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemfree/wmmemfree-0.7.ebuild,v 1.3 2004/09/02 18:22:40 pvdabeel Exp $

IUSE=""

DESCRIPTION="A blue WMaker DockApp to see memory usage (for 2.4 kernels)."
HOMEPAGE="http://misuceldestept.go.ro/wmmemfree/"
SRC_URI="ftp://ftp.ibiblio.org/pub/linux/X11/xutils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"

DEPEND="virtual/x11"

src_compile()
{
	FLAGS=${CFLAGS} make -e || die "Compilation failed"
}

src_install()
{
	dobin wmmemfree
	doman wmmemfree.1
	dodoc ChangeLog TODO WMS COPYING INSTALL README THANKS
}
