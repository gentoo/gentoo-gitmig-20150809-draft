# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# John Stalker <stalker@math.princeton.edu>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/accessx/accessx-0950-r1.ebuild,v 1.7 2003/05/16 18:51:36 utx Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Interface to the XKEYBOARD extension in X11"
SRC_URI="http://cmos-eng.rehab.uiuc.edu/accessx/software/${PN}${PV}.tar.gz"
HOMEPAGE="http://cmos-eng.rehab.uiuc.edu/accessx/"

DEPEND="virtual/x11
	dev-lang/tk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/access-gcc3-gentoo.patch || die
}

src_compile() {
	make || die
}

src_install () {
	into /usr
	dobin accessx ax || die
	dodoc README INSTALL CHANGES
}
