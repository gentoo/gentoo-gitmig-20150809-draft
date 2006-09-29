# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kisdnwatch/kisdnwatch-01.00.10.ebuild,v 1.3 2006/09/29 13:24:20 deathwing00 Exp $

inherit kde eutils

DESCRIPTION="A CAPI-Monitor for KDE."
HOMEPAGE="http://www.avm.de/de/Service/AVM_Service_Portale/Linux/CAPI_Tools/K_ISDN_Watch.html"
SRC_URI="ftp://ftp.avm.de/tools/k_isdn_watch.linux/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="net-dialup/capi4k-utils"

RDEPEND="${DEPEND}"

need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch ${FILESDIR}/${P}-configure.patch
}

src_install() {
	kde_src_install
	dodoc *.lsm
}
