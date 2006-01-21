# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fspanel/fspanel-0.8_beta1-r2.ebuild,v 1.6 2006/01/21 12:03:15 nelchael Exp $

S=${WORKDIR}/fspanel-0.8beta1
DESCRIPTION="F***ing Small Panel. Good (and small) replacement for gnome-panel"
SRC_URI="http://www.chatjunkies.org/fspanel/fspanel-0.8beta1.tar.gz"
HOMEPAGE="http://www.chatjunkies.org/fspanel"

SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE=""
LICENSE="GPL-2"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXpm
		x11-libs/libXft )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )
	dev-util/pkgconfig"

src_compile() {

	if pkg-config xft
	then
		CFLAGS="${CFLAGS} -I/usr/include/freetype2"
	fi
	./configure
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe ${S}/fspanel

	dodoc README
}
