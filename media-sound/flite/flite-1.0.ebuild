# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/flite/flite-1.0.ebuild,v 1.5 2003/06/12 20:49:22 msterret Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/flite-1.0/${P}-beta.tar.gz"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	cd ${S}/bin
	dobin flite flite_time
}
