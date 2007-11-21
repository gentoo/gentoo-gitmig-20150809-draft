# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/sdricoh_cs/sdricoh_cs-0.1.2.ebuild,v 1.1 2007/11/21 18:18:14 hanno Exp $

inherit linux-mod

DESCRIPTION="Driver for Ricoh Bay1Controller found in some laptops"
HOMEPAGE="http://sdricohcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdricohcs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

BUILD_TARGETS="default"
CONFIG_CHECK="MMC_BLOCK"
MODULE_NAMES="sdricoh_cs(mmc:)"
ERROR_MMC_BLOCK="${P} requires MMC block device support (CONFIG_MMC_BLOCK)."
MODULESD_SDRICOH_CS_DOCS="ChangeLog README"
