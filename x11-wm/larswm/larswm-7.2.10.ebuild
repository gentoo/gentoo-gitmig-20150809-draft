# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/larswm/larswm-7.2.10.ebuild,v 1.6 2004/07/15 01:13:30 agriffis Exp $

DESCRIPTION="larswm is a hack for 9wm, adding for instance automatic window tiling and virtual desktops"
HOMEPAGE="http://www.fnurt.net/larswm/"
SRC_URI="http://www.fnurt.net/larswm/${P}.tar.gz"
LICENSE="9wm"

SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE=""
DEPEND="virtual/x11"

src_compile() {
	xmkmf -a
	emake || die

	mv larsclock.man larsclock.1
	mv larsremote.man larsremote.1
	mv larswm.man larswm.1
}

src_install() {
	make DESTDIR=${D} install || die

	doman *.1
	dodoc *.ms ChangeLog README* sample.*
}
