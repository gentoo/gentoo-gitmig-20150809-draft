# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-basicimage/squeak-basicimage-3.6.5429.ebuild,v 1.4 2006/03/19 22:28:02 halcy0n Exp $

MY_P="Squeak3.6-5429"
DESCRIPTION="Squeak basic image file"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/3.6/${MY_P}-basic.zip
	ftp://st.cs.uiuc.edu/Smalltalk/Squeak/3.6/SqueakV3.sources.gz"

LICENSE="Apple"
SLOT="3.6"
KEYWORDS="~x86 ~ppc"
IUSE=""
PROVIDE="virtual/squeak-image"

RDEPEND=">=sys-apps/sed-4"
DEPEND="${RDEPEND}
	app-arch/unzip"

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

	einfo "Squeak ${PV} image/changes now installed"
}
