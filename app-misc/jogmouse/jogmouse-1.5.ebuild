# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/jogmouse/jogmouse-1.5.ebuild,v 1.2 2002/07/11 06:30:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to use VAIO JogDial as a scrollwheel under X."
SRC_URI="http://nerv-un.net/~dragorn/jogmouse/${P}.tar.gz"

HOMEPAGE="http://nerv-un.net/~dragorn/jogmouse/"

DEPEND="virtual/glibc
	virtual/x11"


src_compile() {
	emake || die
}

src_install () {
	dobin jogmouse

	dodoc README
}
