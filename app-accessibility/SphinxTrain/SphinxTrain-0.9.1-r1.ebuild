# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/SphinxTrain/SphinxTrain-0.9.1-r1.ebuild,v 1.7 2005/01/01 10:53:20 eradicator Exp $

inherit eutils

DESCRIPTION="Speech Recognition (Training Module)"
HOMEPAGE="http://www.speech.cs.cmu.edu/SphinxTrain/"
SRC_URI="http://www.speech.cs.cmu.edu/${PN}/${P}-beta.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc
	app-accessibility/sphinx2
	app-accessibility/festival"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc.patch
}

src_install() {
	dobin bin.*/* || die
	dodoc README etc/*cfg
	dohtml doc/*[txt html sgml]
}

pkg_postinst() {
	einfo "Detailed usage and training instructions can be found at"
	einfo "http://www.speech.cs.cmu.edu/SphinxTrain/"
}
