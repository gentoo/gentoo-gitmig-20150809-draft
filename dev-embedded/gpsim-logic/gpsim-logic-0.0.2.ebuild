# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim-logic/gpsim-logic-0.0.2.ebuild,v 1.1 2003/10/21 05:45:15 robbat2 Exp $

inherit eutils

MY_PN="${PN/gpsim-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple example module library for gpsim that contains a 2-input AND gate and a 2-input OR gate"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html#modules"
SRC_URI="http://www.dattalo.com/gnupic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-embedded/gpsim-0.20*"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

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
