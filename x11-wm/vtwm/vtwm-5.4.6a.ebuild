# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/vtwm/vtwm-5.4.6a.ebuild,v 1.7 2004/06/19 02:43:36 weeve Exp $

IUSE=""

DESCRIPTION="VTWM, one of many TWM descendants and implements a Virtual Desktop"
HOMEPAGE="http://www.visi.com/~hawkeyd/vtwm.html"
SRC_URI="ftp://ftp.visi.com/users/hawkeyd/X/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 alpha ~ppc sparc"
DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	make || die
}

src_install() {
	cp ${FILESDIR}/vtwmrc system.vtwmrc
	make BINDIR=/usr/bin \
		LIBDIR=/etc/X11 \
		MANPATH=/usr/share/man \
		DESTDIR=${D} install || die

	echo "#!/bin/sh" > vtwm
	echo "xsetroot -cursor_name left_ptr &" >> vtwm
	echo "/usr/bin/vtwm" >> vtwm
	exeinto /etc/X11/Sessions
	doexe vtwm
	cd doc
	dodoc 4.6.* CHANGELOG BUGS DEVELOPERS HISTORY SOUND WISHLIST
}
