# Copyright 2002-2003, Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2.
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-it/ispell-it-2001.ebuild,v 1.2 2003/02/12 13:29:28 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Loris Palmerini - Italian dictionary for ispell."
HOMEPAGE="http://members.xoom.virgilio.it/trasforma/ispell/"
SRC_URI="http://members.xoom.virgilio.it/trasforma/ispell/${PN}${PV}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="app-text/ispell"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins italian.hash italian.aff

	dodoc collab.txt AUTHORS CAMBI CHANGES DA-FARE.txt FUSIONE.txt
}
