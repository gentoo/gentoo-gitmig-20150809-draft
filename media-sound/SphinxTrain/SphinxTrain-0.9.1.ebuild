# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/SphinxTrain/SphinxTrain-0.9.1.ebuild,v 1.3 2003/06/12 20:47:57 msterret Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="SphinxTrain - Speech Recognition (Training Module)" 
HOMEPAGE="http://www.speech.cs.cmu.edu/SphinxTrain/"
SRC_URI="http://www.speech.cs.cmu.edu/${PN}/${P}-beta.tar.gz"
SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	media-sound/sphinx2
	media-sound/festival"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	dodoc etc/*cfg
	dobin bin.*/*	
	dodoc README
	dohtml doc/*[txt html sgml]
}

pkg_postinst() {
	einfo
	einfo "Detailed usage and training instructions can be found at"
	einfo "http://www.speech.cs.cmu.edu/SphinxTrain/"
	einfo
}
