# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cweb/cweb-3.63.ebuild,v 1.5 2002/08/16 04:04:41 murphy Exp $

S=${WORKDIR}
DESCRIPTION="Knuth's and Levy's C/C++ documenting system"
SRC_URI="ftp://labrea.stanford.edu/pub/cweb/cweb.tar.gz"
HOMEPAGE="http://www-cs-faculty.standorf.edu/~knuth/cweb.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	#emake won't work, because cweave needs ctangle to compile
	make all CFLAGS="${CFLAGS}" LINKFLAGS="-s" || die
}

src_install () {
	dobin ctangle cweave
	doman cweb.1
	dodoc README
}
