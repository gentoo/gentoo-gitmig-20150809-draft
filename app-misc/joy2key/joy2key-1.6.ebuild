# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.ebuild,v 1.14 2004/03/28 18:27:15 karltk Exp $

DESCRIPTION="An application that translates joystick events to keyboard events"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/joy2key/${P}.tar.gz"
HOMEPAGE="http://interreality.org/~tetron/technology/joy2key/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	local myconf
	use X || myconf="--disable-X"

	CFLAGS=${CFLAGS/-O?/}
	econf ${myconf}
	make || die
}

src_install() {
	dobin joy2key
	doman joy2key.1
	dodoc README joy2keyrc.sample AUTHORS NEWS TODO
}
