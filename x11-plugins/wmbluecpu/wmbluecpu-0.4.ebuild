# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbluecpu/wmbluecpu-0.4.ebuild,v 1.5 2004/09/02 18:22:40 pvdabeel Exp $

IUSE=""

DESCRIPTION="A blue WMaker DockApp to see CPU usage."
HOMEPAGE="http://misuceldestept.go.ro/wmbluecpu/"
SRC_URI="ftp://ftp.ibiblio.org/pub/linux/X11/xutils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_compile()
{
	FLAGS=${CFLAGS} make -e || die "Compilation failed"
}

src_install()
{
	dobin wmbluecpu
	doman wmbluecpu.1
	dodoc ChangeLog TODO WMS INSTALL README THANKS
}
