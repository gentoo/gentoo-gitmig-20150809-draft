# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/accessx/accessx-0951.ebuild,v 1.9 2007/07/22 02:43:59 coldwind Exp $


DESCRIPTION="Interface to the XKEYBOARD extension in X11"
HOMEPAGE="http://cmos-eng.rehab.uiuc.edu/accessx/"
SRC_URI="http://cmos-eng.rehab.uiuc.edu/accessx/software/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	dev-lang/tk"

S=${WORKDIR}/${PN}

src_install () {
	dobin accessx ax || die
	dodoc README CHANGES
}
