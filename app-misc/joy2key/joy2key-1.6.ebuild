# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.ebuild,v 1.5 2002/07/25 17:20:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An application that translates joystick events to keyboard events"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/joy2key/${P}.tar.gz"
HOMEPAGE="http://www-unix.out.umass.edu/~tetron/technology/joy2key/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	local myconf
	use X || myconf="--disable-X"

	./configure ${myconf} || die
	make || die
}

src_install () {
	dobin joy2key
	doman joy2key.1
	dodoc README joy2keyrc.sample AUTHORS NEWS TODO
}
