# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.ebuild,v 1.17 2004/07/10 13:29:01 slarti Exp $

DESCRIPTION="An application that translates joystick events to keyboard events"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/joy2key/${P}.tar.gz"
HOMEPAGE="http://interreality.org/~tetron/technology/joy2key/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_compile() {
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
