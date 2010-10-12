# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.2.ebuild,v 1.4 2010/10/12 16:55:46 armin76 Exp $

inherit autotools

DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://ktown.kde.org/~seli/numlockx"
SRC_URI="http://ktown.kde.org/~seli/numlockx/${P}.tar.gz"

SLOT="0"
LICENSE="EDB"
KEYWORDS="alpha amd64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^K_.*$/d' configure.in || die
	sed -i -e 's,@X_[_A-Z]\+@,,g' Makefile.am || die
	eautoreconf
}

src_install(){
	dobin numlockx
	dodoc AUTHORS README
}

pkg_postinst(){
	elog
	elog "add 'numlockx' to your X startup programs to have numlock turn on when X starts"
	elog
}
