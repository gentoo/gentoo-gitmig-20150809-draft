# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/hwreport/hwreport-0.9.4.ebuild,v 1.4 2008/01/18 14:57:41 fmccor Exp $

inherit toolchain-funcs

DESCRIPTION="Collect system informations for the hardware4linux.info site"
HOMEPAGE="http://hardware4linux.info"
SRC_URI="http://hardware4linux.info/res/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/dmidecode-2.8 >=sys-apps/pciutils-2.2.0"

src_compile() {
	$(tc-getCC) -o scan-printers scan-printers.c
}

src_install() {
	dobin hwreport scan-printers
	dodoc README
}

pkg_postinst() {
	elog "You can now generate your reports and post them on $HOMEPAGE"
}
