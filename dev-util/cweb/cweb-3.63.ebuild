# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Hanno Boeck <hanno@gmx.de>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S=${WORKDIR}
DESCRIPTION="Knuth's and Levy's C/C++ documenting system"
SRC_URI="ftp://labrea.stanford.edu/pub/cweb/cweb.tar.gz"
HOMEPAGE="http://www-cs-faculty.standorf.edu/~knuth/cweb.html"
DEPEND=""

src_compile() {
	#emake won't work, because cweave needs ctangle to compile
	make all CFLAGS="${CFLAGS}" LINKFLAGS="-s" || die
}

src_install () {
	dobin ctangle cweave
	doman cweb.1
	dodoc README
}
