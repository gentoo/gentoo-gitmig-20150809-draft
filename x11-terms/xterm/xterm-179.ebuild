# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/xterm/xterm-179.ebuild,v 1.1 2003/05/31 02:23:10 seemant Exp $

IUSE="X gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Terminal Emulator for X Windows"
HOMEPAGE="http://dickey.his.com/xterm/"
SRC_URI="ftp://invisible-island.net/${PN}/${P}.tgz"

SLOT="0"
LICENSE="X11"
KEYWORDS="~x86"

DEPEND="virtual/x11"


src_compile() {
	econf \
		--libdir=/etc || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
