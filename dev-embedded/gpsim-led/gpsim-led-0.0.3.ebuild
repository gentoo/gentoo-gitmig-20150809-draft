# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-led/gpsim-led-0.0.3.ebuild,v 1.4 2004/03/23 18:20:26 dragonheart Exp $

inherit eutils

MY_PN="${PN/gpsim-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="7 Segment LED module for gpsim"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html#modules"
SRC_URI="http://www.dattalo.com/gnupic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-embedded/gpsim-0.20*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tar.gz
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile(){
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	cp -ra ${S}/examples ${D}/usr/share/doc/${PF}
	find ${D}/usr/share/doc/${PF} -name 'Makefile*' -exec rm -f \{} \;
}
