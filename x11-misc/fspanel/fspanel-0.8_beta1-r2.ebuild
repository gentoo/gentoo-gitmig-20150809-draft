# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fspanel/fspanel-0.8_beta1-r2.ebuild,v 1.11 2012/05/05 04:53:40 jdhore Exp $

MY_P=${P/_beta/beta}

DESCRIPTION="F***ing Small Panel. Good (and small) replacement for gnome-panel"
HOMEPAGE="http://www.chatjunkies.org/fspanel"
SRC_URI="http://www.chatjunkies.org/fspanel/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""
RESTRICT="strip"

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXft"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	sed -i -e 's,/X11R6,,g' "${S}/configure"
}

src_compile() {
	if pkg-config xft; then
		CFLAGS="${CFLAGS} -I/usr/include/freetype2"
	fi

	./configure || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	exeinto /usr/bin
	doexe "${S}/fspanel"

	dodoc README
}
