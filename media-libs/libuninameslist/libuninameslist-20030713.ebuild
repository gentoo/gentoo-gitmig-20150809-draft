# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libuninameslist/libuninameslist-20030713.ebuild,v 1.3 2004/06/24 23:15:24 agriffis Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="Library of unicode annotation data"
SRC_URI="mirror://sourceforge/libuninameslist/${PN}_src-${PV:2:6}.tgz"
HOMEPAGE="http://libuninameslist.sourceforge.net/"

RESTRICT="nomirror"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86 ppc alpha"
DEPEND="virtual/glibc"
IUSE=""

src_compile () {
	econf || die
	emake || die
}


src_install() {
	einstall || die
}
