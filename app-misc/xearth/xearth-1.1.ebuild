# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
HOMEPAGE="http://www.cs.colorado.edu/~tuna/xearth/"
DESCRIPTION="Xearth sets the X root window to an image of the Earth"
SRC_URI="ftp://cag.lcs.mit.edu/pub/tuna/xearth-${PV}.tar.gz
		ftp://ftp.cs.colorado.edu/users/tuna/xearth-${PV}.tar.gz"

SLOT="0"
LICENSE="xearth"
KEYWORDS="x86"

DEPEND="virtual/x11"
RDEPEND="virtual/x11"

src_compile() {
	cd ${S}
	xmkmf || die
	mv Makefile Makefile.orig
	sed -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
			Makefile.orig > Makefile
	emake || die
}

src_install() {
	doman xearth.man
	dobin xearth
	dodoc BUILT-IN GAMMA-TEST HISTORY INSTALL README
}
