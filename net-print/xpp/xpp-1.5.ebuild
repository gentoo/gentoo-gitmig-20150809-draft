# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xpp/xpp-1.5.ebuild,v 1.9 2009/12/16 18:00:44 flameeyes Exp $

EAPI="1"
inherit eutils

DESCRIPTION="X Printing Panel"
SRC_URI="mirror://sourceforge/cups/${P}.tar.gz"
HOMEPAGE="http://cups.sourceforge.net/xpp/"

KEYWORDS="x86 amd64 ~ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=net-print/cups-1.1.14
	x11-libs/fltk:1.1
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/xpp-gcc4.patch \
		"${FILESDIR}"/xpp-glibc-2.10.patch
}

src_compile() {
	export CXX=g++
	export LDFLAGS="-L/usr/lib/fltk-1.1 -lfltk"
	export CPPFLAGS="-I/usr/include/fltk-1.1"

	econf || die "configure failed"

	# bug #297200
	emake -j1 || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc ChangeLog README
}
