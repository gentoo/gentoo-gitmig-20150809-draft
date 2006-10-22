# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.ebuild,v 1.22 2006/10/22 21:18:37 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools flag-o-matic

DESCRIPTION="An application that translates joystick events to keyboard events"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/joy2key/${P}.tar.gz"
HOMEPAGE="http://interreality.org/~tetron/technology/joy2key/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE="X"

DEPEND="X? ( || ( x11-libs/libX11 virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix-configure.in.diff fix issue with blank -L blocking -lX11
	# Thanks to Joshua Baergen in bug #82685

	epatch "${FILESDIR}/fix-configure.in.diff"
	eautoreconf
}

src_compile() {
	local myconf
	use X || myconf="--disable-X"

	filter-flags -O?
	econf ${myconf} || die "econf failed"
	emake || die
}

src_install() {
	dobin joy2key
	doman joy2key.1
	dodoc README joy2keyrc.sample AUTHORS NEWS TODO
}
