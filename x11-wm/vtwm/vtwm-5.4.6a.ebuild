# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/vtwm/vtwm-5.4.6a.ebuild,v 1.10 2006/06/11 12:09:07 nelchael Exp $

IUSE=""

DESCRIPTION="VTWM, one of many TWM descendants and implements a Virtual Desktop"
HOMEPAGE="http://www.visi.com/~hawkeyd/vtwm.html"
SRC_URI="ftp://ftp.visi.com/users/hawkeyd/X/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXmu
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-misc/imake
		app-text/rman
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

src_compile() {
	xmkmf || die "xmkmf failed"
	emake || die "emake failed"
}

src_install() {
	cp ${FILESDIR}/vtwmrc system.vtwmrc
	make BINDIR=/usr/bin \
		LIBDIR=/etc/X11 \
		MANPATH=/usr/share/man \
		DESTDIR=${D} install || die "make install failed"

	echo "#!/bin/sh" > vtwm
	echo "xsetroot -cursor_name left_ptr &" >> vtwm
	echo "/usr/bin/vtwm" >> vtwm
	exeinto /etc/X11/Sessions
	doexe vtwm
	cd doc
	dodoc 4.6.* CHANGELOG BUGS DEVELOPERS HISTORY SOUND WISHLIST
}
