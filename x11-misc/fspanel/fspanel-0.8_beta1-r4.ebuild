# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fspanel/fspanel-0.8_beta1-r4.ebuild,v 1.2 2012/05/05 04:53:40 jdhore Exp $

EAPI=2
inherit eutils toolchain-funcs

MY_P=${P/_}

DESCRIPTION="F***ing Small Panel. Good (and small) replacement for gnome-panel"
HOMEPAGE="http://www.chatjunkies.org/fspanel"
SRC_URI="http://www.chatjunkies.org/fspanel/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="xft xpm"

RDEPEND="x11-libs/libX11
	xpm? ( x11-libs/libXpm )
	xft? ( x11-libs/libXft )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch \
		"${FILESDIR}"/${P}-workspace.patch
}

myuse() {
	use $1 && echo yes || echo no
}

src_configure() {
	tc-export CC

	export USE_XFT=$(myuse xft)
	export USE_XPM=$(myuse xpm)

	./configure || die
}

src_install() {
	dobin fspanel || die
	dodoc README
}
