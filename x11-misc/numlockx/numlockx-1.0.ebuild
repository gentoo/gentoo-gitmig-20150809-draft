# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.0.ebuild,v 1.10 2004/03/12 14:42:13 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://dforce.sh.cvut.cz/~seli/en/numlockx"
SRC_URI="http://dforce.sh.cvut.cz/~seli/en/numlockx/${P}.tar.gz"

SLOT="0"
LICENSE="EDB"
KEYWORDS="x86 sparc amd64"

DEPEND="virtual/x11"


src_compile(){
	./configure \
		--prefix=/usr/X11R6 \
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
