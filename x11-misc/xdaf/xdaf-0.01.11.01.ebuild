# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaf/xdaf-0.01.11.01.ebuild,v 1.2 2004/01/26 17:03:03 pyrania Exp $

MY_P=${P/-0/-A}
DESCRIPTION="Small tool to provide visual feedback of local disks activity by changing the default X11 mouse pointer"
HOMEPAGE="http://ezix.sourceforge.net/software/xdaf.html"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11"

S=${WORKDIR}/${MY_P}

src_compile() {
	xmkmf || die
	emake CDEBUGFLAGS="${CFLAGS}" || die
}

src_install () {
	make DESTDIR=${D} install || die
	newman xdaf.man xdaf.1
	dodoc COPYING README INSTALL
}
