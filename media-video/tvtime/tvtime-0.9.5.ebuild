# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="High quality television application for use with video capture cards."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://tvtime.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

IUSE=""

DEPEND="virtual/x11"

src_compile() {

	econf || die
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS NEWS README
}

pkg_postinst() {
	einfo
	einfo "Detailed information on ${PN} setup can be"
	einfo "found at ${HOMEPAGE}help.html"
	einfo
}
