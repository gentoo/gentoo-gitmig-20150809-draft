# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-fullimage/squeak-fullimage-3.6_p5429.ebuild,v 1.1 2004/04/28 16:19:19 jhhudso Exp $

MY_P="Squeak${PV/_p/-}"
DESCRIPTION="Squeak full image file"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${PV/_*}/${MY_P}-full.zip
	ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${PV/_*}/SqueakV3.sources.gz"

LICENSE="Apple"
SLOT="${PV/_*}"
KEYWORDS="~x86 ~ppc"
IUSE=""
PROVIDE="virtual/squeak-image"

DEPEND=">=sys-apps/sed-4"

S=${WORKDIR}

src_compile() {
	einfo "Compressing Image/Changes files..."
	gzip ${MY_P}-full.image || die
	gzip ${MY_P}-full.changes || die
	einfo "done!"
}

src_install() {
	dodoc ReadMe.txt
	insinto /usr/lib/squeak
	doins ${MY_P}-full.changes.gz
	doins ${MY_P}-full.image.gz
	doins SqueakV3.sources
	dosym /usr/lib/squeak/${MY_P}-full.changes.gz \
		/usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/${MY_P}-full.image.gz \
		/usr/lib/squeak/squeak.image.gz

	einfo "Squeak ${PV/_p/-} image/changes now installed"
}
