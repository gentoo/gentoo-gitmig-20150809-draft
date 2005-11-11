# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmsens/wmmsens-0.29.6.ebuild,v 1.4 2005/11/11 09:34:27 s4t4n Exp $

inherit eutils

S="${WORKDIR}/${P/_/-}"
HOMEPAGE="http://www.digressed.net/wmmsens/"
DESCRIPTION="Window Maker dock app for monitoring your motherboard's hardware sensors"
SRC_URI="http://www.digressed.net/wmmsens/src//${P/_/-}.tar.gz"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64"
DEPEND="virtual/x11"
IUSE=""

src_compile() {
	cd src
	# remove depends at end of Makefile that cause problems
	mv Makefile Makefile.old
	sed -e "/DELETE/q" Makefile.old > Makefile

	emake OPTFLAGS="${CXXFLAGS}" || die
}

src_install() {
	cd ${S}
	dodoc CREDITS ChangeLog README TODO

	cd src
	mkdir -p ${D}/usr/bin
	emake INSTDIR=${D}/usr/bin install || die
}
