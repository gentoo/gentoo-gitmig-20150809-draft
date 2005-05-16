# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbluecpu/wmbluecpu-0.6.ebuild,v 1.1 2005/05/16 10:07:43 s4t4n Exp $

IUSE=""

DESCRIPTION="A blue WMaker DockApp to see CPU usage."
HOMEPAGE="http://sheepmakers.ath.cx/utils/wmbluecpu/"
SRC_URI="http://litestep.boo.pl/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="virtual/x11"

src_compile()
{
	FLAGS=${CFLAGS} make -e || die "Compilation failed"
}

src_install()
{
	dobin wmbluecpu
	doman wmbluecpu.1
	dodoc ChangeLog TODO INSTALL README THANKS AUTHORS
}
