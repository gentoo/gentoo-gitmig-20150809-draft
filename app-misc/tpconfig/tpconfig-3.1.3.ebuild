# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tpconfig/tpconfig-3.1.3.ebuild,v 1.12 2007/04/22 15:20:02 phreak Exp $

DESCRIPTION="Touchpad config for ALPS and Synaptics TPs. Controls tap/click behaviour"
HOMEPAGE="http://www.compass.com/synaptics/"
SRC_URI="http://www.compass.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_install() {
	dobin tpconfig || die "dobin failed!"
	dodoc README AUTHORS NEWS INSTALL
	doinitd "${FILESDIR}"/tpconfig
	newconfd "${FILESDIR}"/tpconfig.conf tpconfig
}
