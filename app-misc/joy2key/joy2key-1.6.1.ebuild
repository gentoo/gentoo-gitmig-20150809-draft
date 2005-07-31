# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.1.ebuild,v 1.2 2005/07/31 11:09:26 dholm Exp $

inherit eutils

DESCRIPTION="An application that translates joystick events to keyboard events"
HOMEPAGE="http://interreality.org/~tetron/technology/joy2key/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix-configure.in.diff fix issue with blank -L blocking -lX11
	# Thanks to Joshua Baergen in bug #82685

	epatch ${FILESDIR}/${PV}-fix-configure.diff
}

src_compile() {
	autoreconf --force

	local myconf
	use X || myconf="--disable-X"

	CFLAGS=${CFLAGS/-O?/}
	econf ${myconf} || die "econf failed"
	make || die
}

src_install() {
	dobin joy2key
	doman joy2key.1
	dodoc README joy2keyrc.sample AUTHORS NEWS TODO
}
