# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-basicimage/squeak-basicimage-3.6.5429.ebuild,v 1.1 2004/04/28 17:09:36 jhhudso Exp $

MY_P="Squeak3.6-5429"
DESCRIPTION="Squeak basic image file"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${PV/_*}/${MY_P}-basic.zip
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
	gzip ${MY_P}-basic.image || die
	gzip ${MY_P}-basic.changes || die
	einfo "done!"
}

src_install() {
	dodoc ReadMe.txt
	insinto /usr/lib/squeak
	doins ${MY_P}-basic.changes.gz
	doins ${MY_P}-basic.image.gz
	doins SqueakV3.sources
	dosym /usr/lib/squeak/${MY_P}-basic.changes.gz \
		/usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/${MY_P}-basic.image.gz \
		/usr/lib/squeak/squeak.image.gz

	einfo "Squeak ${PV/_p/-} image/changes now installed"
}
