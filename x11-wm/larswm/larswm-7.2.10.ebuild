# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/larswm/larswm-7.2.10.ebuild,v 1.2 2003/11/04 15:55:22 tseng Exp $

DESCRIPTION="larswm is a hack for 9wm, adding for instance automatic window tiling and virtual desktops"
HOMEPAGE="http://www-personal.umich.edu/~larsb/larswm/"
SRC_URI="http://www-personal.umich.edu/~larsb/larswm/${P}.tar.gz"
LICENSE="9wm"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE=""
DEPEND="virtual/x11"
S=${WORKDIR}/${P}

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
