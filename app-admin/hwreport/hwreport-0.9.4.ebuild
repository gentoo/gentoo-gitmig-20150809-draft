# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hwreport/hwreport-0.9.4.ebuild,v 1.2 2008/01/14 00:31:23 mr_bones_ Exp $

DESCRIPTION="Collect system informations for the hardware4linux.info site"
HOMEPAGE="http://hardware4linux.info/"
SRC_URI="http://hardware4linux.info/res/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/dmidecode-2.8 >=sys-apps/pciutils-2.2.0"

src_compile() {
	cc -o scan-printers scan-printers.c
}

src_install() {
	dobin hwreport
	dobin scan-printers
	einfo "You can now generate your reports and post them on $HOMEPAGE"
}
pkg_postinst() {
	elog "You can now generate your reports and post them on $HOMEPAGE"
}
