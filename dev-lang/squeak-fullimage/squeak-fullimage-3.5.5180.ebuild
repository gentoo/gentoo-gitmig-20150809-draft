# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-fullimage/squeak-fullimage-3.5.5180.ebuild,v 1.3 2004/07/14 13:53:25 agriffis Exp $

MAJOR=3
MINOR=5
RELEASE=5180

MM=${MAJOR}.${MINOR}
MMDOTR=${MM}.${RELEASE}
MMDASHR=${MM}-${RELEASE}

DESCRIPTION="Squeak image file"

HOMEPAGE="http://www.squeak.org/"

SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${MM}/Squeak${MMDASHR}.zip
	ftp://st.cs.uiuc.edu/Smalltalk/Squeak/${MM}/SqueakV3.sources.gz"

LICENSE="Apple"

SLOT="${MM}"

KEYWORDS="~x86"

IUSE=""

PROVIDE="virtual/squeak-image"

DEPEND=""

RDEPEND=""

S=${WORKDIR}

src_compile() {
	einfo "Compressing Image/Changes files..."
	gzip Squeak${MMDASHR}.image
	gzip Squeak${MMDASHR}.changes
	einfo "done!"
}

src_install() {
	dodoc ReadMe.txt
	insinto /usr/lib/squeak
	doins Squeak${MMDASHR}.changes.gz
	doins Squeak${MMDASHR}.image.gz
	doins SqueakV3.sources
	dosym /usr/lib/squeak/Squeak${MMDASHR}.changes.gz \
	      /usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/Squeak${MMDASHR}.image.gz   \
	      /usr/lib/squeak/squeak.image.gz

	einfo "Squeak 3.5-5180 image/changes now installed"
}
