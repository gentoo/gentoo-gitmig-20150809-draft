# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-it/ispell-it-2001.ebuild,v 1.13 2008/11/01 12:16:08 pva Exp $

inherit multilib

DESCRIPTION="Loris Palmerini - Italian dictionary for ispell"
HOMEPAGE="http://members.xoom.virgilio.it/trasforma/ispell/"
SRC_URI="http://members.xoom.virgilio.it/trasforma/ispell/${PN}${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"

DEPEND="app-text/ispell"

S=${WORKDIR}/${PN}

src_compile() {
	make || die
}

src_install () {
	insinto /usr/$(get_libdir)/ispell
	doins italian.hash italian.aff || die
	dodoc collab.txt AUTHORS CAMBI CHANGES DA-FARE.txt FUSIONE.txt
}
