# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-vm/squeak-vm-3.2.4956.ebuild,v 1.4 2004/03/14 02:40:38 mr_bones_ Exp $

DESCRIPTION="Highly-portable Smalltalk-80 implementation VM image"
HOMEPAGE="http://www.squeak.org/"
NV=3.2-4956

SRC_URI="ftp://st.cs.uiuc.edu/Smalltalk/Squeak/3.2/Squeak${NV}.zip
	ftp://st.cs.uiuc.edu/Smalltalk/Squeak/3.2/SqueakV3.sources.gz"
LICENSE="Apple"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-lang/squeak-3.2*"

src_compile() {
	cd ${WORKDIR}
	gzip Squeak${NV}.image
	gzip Squeak${NV}.changes
}

src_install() {
	cd ${WORKDIR}
	dodoc ReadMe.txt
	insinto /usr/lib/squeak
	doins	Squeak${NV}.changes.gz \
		Squeak${NV}.image.gz \
		SqueakV3.sources
	dosym /usr/lib/squeak/Squeak${NV}.changes.gz /usr/lib/squeak/squeak.changes.gz
	dosym /usr/lib/squeak/Squeak${NV}.image.gz /usr/lib/squeak/squeak.image.gz
}
