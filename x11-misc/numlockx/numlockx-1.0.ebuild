# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.0.ebuild,v 1.2 2002/07/17 00:04:10 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://dforce.sh.cvut.cz/~seli/en/numlockx"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

SLOT="0"
LICENSE="EDB"
KEYWORDS="x86"

DEPEND="virtual/x11"


src_compile(){
	./configure			 \
		--prefix=/usr/X11R6	 \
		--host=${CHOST} || die
	emake || die
}

src_install(){
	dodoc AUTHORS INSTALL LICENSE README

	into /usr/X11R6
	dobin numlockx
}

pkg_postinst(){
	einfo ""
	einfo "add 'numlockx' to your X startup programs to have numlock turn on when X starts"
	einfo ""
}
