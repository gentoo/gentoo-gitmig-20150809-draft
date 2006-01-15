# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/accessx/accessx-0951.ebuild,v 1.8 2006/01/15 15:59:25 nelchael Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Interface to the XKEYBOARD extension in X11"
SRC_URI="http://cmos-eng.rehab.uiuc.edu/accessx/software/${PN}${PV}.tar.gz"
HOMEPAGE="http://cmos-eng.rehab.uiuc.edu/accessx/"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext )
	virtual/x11 )"

DEPEND="${RDEPEND}
		dev-lang/tk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

src_compile() {
	make || die
}

src_install () {
	into /usr
	dobin accessx ax || die
	dodoc README CHANGES
}
