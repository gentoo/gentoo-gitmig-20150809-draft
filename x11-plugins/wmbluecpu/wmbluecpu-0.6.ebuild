# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbluecpu/wmbluecpu-0.6.ebuild,v 1.6 2007/07/22 05:21:10 dberkholz Exp $

IUSE=""

DESCRIPTION="A blue WMaker DockApp to see CPU usage."
HOMEPAGE="http://sheepmakers.ath.cx/utils/wmbluecpu/"
SRC_URI="http://litestep.boo.pl/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~sparc x86"

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_compile()
{
	FLAGS=${CFLAGS} make -e || die "Compilation failed"
}

src_install()
{
	dobin wmbluecpu
	doman wmbluecpu.1
	dodoc ChangeLog TODO README THANKS AUTHORS
}
