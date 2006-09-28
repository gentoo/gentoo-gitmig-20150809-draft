# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kadslwatch/kadslwatch-01.00.06.ebuild,v 1.3 2006/09/28 11:32:23 deathwing00 Exp $

inherit kde eutils

DESCRIPTION="A universal CAPI based ADSL monitor for KDE."
HOMEPAGE="http://www.avm.de/de/Service/AVM_Service_Portale/Linux/CAPI_Tools/K_ADSL_Watch.html"
SRC_URI="ftp://ftp.avm.de/tools/k_adsl_watch.linux/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
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
