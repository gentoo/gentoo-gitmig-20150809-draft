# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/joy2key/joy2key-1.6.ebuild,v 1.4 2002/07/11 06:30:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An application that translates joystick events to keyboard events"
SRC_URI="http://www-unix.oit.umass.edu/~tetron/technology/joy2key/${P}.tar.gz"
HOMEPAGE="http://www-unix.out.umass.edu/~tetron/technology/joy2key/"

DEPEND="virtual/glibc
	X? ( virtual/x11 )"

src_compile() {

	local myconf
	if [ -z "`use X`" ] ; then
		myconf="--disable-X"
	fi

	./configure ${myconf} || die
	make || die

}

src_install () {

	dobin joy2key
	doman joy2key.1
	dodoc README joy2keyrc.sample

}
