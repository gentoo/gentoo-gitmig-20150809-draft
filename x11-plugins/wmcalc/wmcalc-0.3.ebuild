# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcalc/wmcalc-0.3.ebuild,v 1.7 2004/01/21 20:08:37 tseng Exp $

DESCRIPTION="A WindowMaker DockApp calculator"
HOMEPAGE="http://members.cox.net/ehf_dockapps/wmcalc/whatis.html"
SRC_URI="mirror://debian/pool/main/w/wmcalc/${PN}_${PV}.orig.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
DEPEND="x11-base/xfree"

S=${WORKDIR}/${P}.orig

IUSE=""

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	emake || die
}

src_install () {
	dobin wmcalc

	dodoc README COPYING

	newman ${FILESDIR}/wmcalc.man wmcalc.1

	insinto /etc
	newins .wmcalc wmcalc.conf

	insinto /etc/skel
	doins .wmcalc
}
