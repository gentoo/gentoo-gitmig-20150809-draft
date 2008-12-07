# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fspanel/fspanel-0.8_beta1-r3.ebuild,v 1.1 2008/12/07 13:04:53 coldwind Exp $

inherit eutils

MY_P=${P/_beta/beta}

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
	dev-util/pkgconfig
	x11-proto/xproto"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
}

myuse() {
	use $1 && echo yes || echo no
}

src_compile() {
	export USE_XFT=$(myuse xft)
	export USE_XPM=$(myuse xpm)

	./configure || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	dobin fspanel
	dodoc README
}
