# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-1.5.ebuild,v 1.12 2011/06/02 19:14:36 dilfridge Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="X Printing Panel"
SRC_URI="mirror://sourceforge/cups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/xpp/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=net-print/cups-1.1.14
	x11-libs/fltk:1
	virtual/jpeg
	>=media-libs/libpng-1.4
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/xpp-gcc4.patch \
		"${FILESDIR}"/xpp-glibc-2.10.patch
}

src_configure() {
	export CXX="$(tc-getCXX)"
	export LDFLAGS="-L/usr/lib/fltk-1 -lfltk"
	export CPPFLAGS="-I/usr/include/fltk-1"

	STRIP=/bin/echo econf
}

src_compile() {
	emake -j1
}

src_install() {
	einstall
	dodoc ChangeLog README
}
