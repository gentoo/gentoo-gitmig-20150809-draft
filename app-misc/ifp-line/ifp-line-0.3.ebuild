# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ifp-line/ifp-line-0.3.ebuild,v 1.3 2007/01/28 05:13:44 genone Exp $

inherit eutils

DESCRIPTION="iRiver iFP open-source driver"
HOMEPAGE="http://ifp-driver.sourceforge.net/"
SRC_URI="mirror://sourceforge/ifp-driver/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND="dev-libs/libusb"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-fix-warnings.patch
}

src_install() {
	dobin ifp || die
	dodoc NEWS README TIPS ChangeLog
	doman ifp.1

	exeinto /usr/share/${PN}
	doexe nonroot.sh
}

pkg_postinst() {
	elog
	elog "To enable non-root usage of ${PN}, you use any of the following"
	elog "methods."
	elog
	elog " 1. Merge media-sound/libifp-module and add the module to"
	elog "    /etc/modules.autoload.d/kernel-2.X (X being 4 or 6 depending"
	elog "    on what kernel you use."
	elog
	elog " 2. Follow the instructions in"
	elog "      /usr/share/doc/${PF}/TIPS.gz"
	elog
	elog " 3. Run /usr/share/${PN}/nonroot.sh"
	elog
}
