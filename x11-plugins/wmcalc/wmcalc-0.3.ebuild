# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcalc/wmcalc-0.3.ebuild,v 1.4 2003/09/06 05:45:17 msterret Exp $

DESCRIPTION="A WindowMaker DockApp calculator"
#The homepage is not working, but it is what the source lists
HOMEPAGE="http://members.access1.net/ehflora/"
SRC_URI="http://ftp.debian.org/debian/pool/main/w/wmcalc/${PN}_${PV}.orig.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="x11-base/xfree"

S=${WORKDIR}/${P}.orig

IUSE=""

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die

}

src_compile() {

	emake || die

}

src_install () {

	dobin wmcalc

	dodoc README COPYING

	newman ${FILESDIR}/wmcalc.man wmcalc.1

	insinto /etc
	newins wmcalc.conf

	insinto /etc/skel
	newins .wmcalc

}
