# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tpconfig/tpconfig-3.1.3.ebuild,v 1.9 2004/06/24 22:36:31 agriffis Exp $

DESCRIPTION="Touchpad config for ALPS and Synaptics TPs. Controls tap/click behaviour"
HOMEPAGE="http://www.compass.com/synaptics/"
SRC_URI="http://www.compass.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	econf || die "econf failed"
	emake || die "Failed emake"
}

src_install() {
	dobin tpconfig
	dodoc README AUTHORS NEWS INSTALL COPYING
	exeinto /etc/init.d ; doexe ${FILESDIR}/tpconfig
	insinto /etc/conf.d ; newins ${FILESDIR}/tpconfig.conf tpconfig
}
