# Copyright 2002, Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-it/ispell-it-2001.ebuild,v 1.1 2002/12/03 07:15:39 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Loris Palmerini - Italian dictionary for ispell."
HOMEPAGE="http://members.xoom.virgilio.it/trasforma/ispell/"
SRC_URI="http://members.xoom.virgilio.it/trasforma/ispell/${PN}${PV}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-text/ispell"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins italian.hash italian.aff

	dodoc collab.txt AUTHORS CAMBI CHANGES COPYNG DA-FARE.txt FUSIONE.txt INSTALL
}
