# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer Michael Nazaroff <naz@gentoo.org> 
# /space/gentoo/cvsroot/gentoo-x86/media-sound/flite/flite-1.0.ebuild,

S=${WORKDIR}/${PN}
DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/flite-1.0/${P}-beta.tar.gz"

DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install () {
	cd ${S}/bin
	dobin flite flite_time
}
