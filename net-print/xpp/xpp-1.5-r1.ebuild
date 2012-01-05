# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-1.5-r1.ebuild,v 1.2 2012/01/05 17:25:33 ssuominen Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="X Printing Panel"
HOMEPAGE="http://cups.sourceforge.net/xpp/"
SRC_URI="mirror://sourceforge/cups/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/libpng-1.2:0
	net-print/cups
	sys-libs/zlib
	virtual/jpeg
	>=x11-libs/fltk-1.3:1
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/xpp-gcc4.patch \
		"${FILESDIR}"/xpp-glibc-2.10.patch \
		"${FILESDIR}"/xpp-fltk-1.3.0.patch
}

src_configure() {
	tc-export CXX
	export LDFLAGS="-L/usr/lib/fltk-1 -lfltk"
	export CPPFLAGS="-I/usr/include/fltk-1"

	STRIP="$(type -P true)" econf
}

src_compile() {
	emake -j1
}

src_install() {
	einstall
	dodoc ChangeLog README
}
