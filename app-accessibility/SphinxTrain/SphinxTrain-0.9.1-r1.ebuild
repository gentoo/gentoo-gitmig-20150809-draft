# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/SphinxTrain/SphinxTrain-0.9.1-r1.ebuild,v 1.8 2005/07/20 21:59:59 eradicator Exp $

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
	epatch ${FILESDIR}/gcc34.patch
}

src_install() {
	# dobin bin.*/* fails ... see bug #73586
	find bin.* -mindepth 1 -maxdepth 1 -type f -exec dobin '{}' \; || die

	dodoc README etc/*cfg
	dohtml doc/*[txt html sgml]
}

pkg_postinst() {
	einfo "Detailed usage and training instructions can be found at"
	einfo "http://www.speech.cs.cmu.edu/SphinxTrain/"
}
