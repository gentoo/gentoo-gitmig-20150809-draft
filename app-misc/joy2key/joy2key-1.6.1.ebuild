# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.1.ebuild,v 1.7 2009/09/07 15:44:52 vostorga Exp $

inherit eutils autotools flag-o-matic

DESCRIPTION="An application that translates joystick events to keyboard events"
HOMEPAGE="http://interreality.org/~tetron/technology/joy2key/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

DEPEND="X? ( x11-libs/libX11 )"
RDEPEND="$DEPEND
	x11-apps/xwininfo"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix-configure.in.diff fix issue with blank -L blocking -lX11
	# Thanks to Joshua Baergen in bug #82685

	epatch "${FILESDIR}/${PV}-fix-configure.diff"
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
	dodoc README joy2keyrc.sample rawscancodes AUTHORS NEWS TODO
}
