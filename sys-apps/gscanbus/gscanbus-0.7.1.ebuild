# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gscanbus/gscanbus-0.7.1.ebuild,v 1.10 2008/05/06 14:08:43 drac Exp $

inherit eutils

DESCRIPTION="a little bus scanning, testing, and topology visualizing tool for the Linux IEEE1394 subsystem"
HOMEPAGE="http://gscanbus.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tgz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/libraw1394-0.9.0
	=x11-libs/gtk+-1.2*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/gscanbus-0.71-gcc33.patch
}

src_install() {
	dobin gscanbus || die
	insinto /etc
	doins guid-resolv.conf oui-resolv.conf
	dodoc README
}
