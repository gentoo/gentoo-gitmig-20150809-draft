# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xosview/xosview-1.7.3-r1.ebuild,v 1.3 2002/07/11 06:30:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X11 operating system viewer"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/status/xstatus/${P}.tar.gz"
HOMEPAGE=""

DEPEND="virtual/x11"

src_compile() {

	econf || die
	make || die

}

src_install () {

	exeinto /usr/bin
	doexe xosview
	insinto /usr/lib/X11
	cp Xdefaults XOsview
	doins XOsview
	into /usr
	doman *.1

}
