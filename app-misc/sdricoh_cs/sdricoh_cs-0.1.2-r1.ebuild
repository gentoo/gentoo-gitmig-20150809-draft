# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sdricoh_cs/sdricoh_cs-0.1.2-r1.ebuild,v 1.1 2008/02/14 13:41:53 hanno Exp $

inherit linux-mod

DESCRIPTION="Driver for Ricoh Bay1Controller found in some laptops"
HOMEPAGE="http://sdricohcs.sourceforge.net"
SRC_URI="mirror://sourceforge/sdricohcs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BUILD_TARGETS="default"
CONFIG_CHECK="MMC_BLOCK"
MODULE_NAMES="sdricoh_cs(mmc:)"
ERROR_MMC_BLOCK="${P} requires MMC block device support (CONFIG_MMC_BLOCK)."
MODULESD_SDRICOH_CS_DOCS="ChangeLog README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/sdricoh_cs-2.6.24.diff" || die "epatch failed"
}
