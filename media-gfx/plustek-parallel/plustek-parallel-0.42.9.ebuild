# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/plustek-parallel/plustek-parallel-0.42.9.ebuild,v 1.4 2004/02/16 15:50:34 spock Exp $

IUSE=""

inherit eutils

DESCRIPTION="Scanner Access Now Easy - Plustek module for parallel port scanners"
HOMEPAGE="http://www.gjaeger.de/scanner/plustek.html"
DEPEND="=virtual/linux-sources-2.4*
	>=media-gfx/sane-backends-1.0.8"
SRC_URI="http://www.gjaeger.de/scanner/current/plustek-module-0_42_9.tar.gz"
S="${WORKDIR}/plustek_driver"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	epatch ${FILESDIR}/${P}.patch
	make all || die
}

src_install () {
	make install || die
	mkdir -p ${D}etc/modules.d
	cat >${D}etc/modules.d/pt_drv <<END
alias char-major-40 pt_drv
options pt_drv port=0x378 forceMode=0 lOffonEnd=1 mov=0 warmup=15 slowIO=0 lampoff=180
END
}

pkg_postinst () {
	# this is necessary for most programs to be able to use the scanner
	ln -s /dev/scanner/pt_drv0 /dev/pt_drv

	einfo Some default configuration values have been written to /etc/modules.d/pt_drv
	einfo Make sure you check them before actually using your scanner.
	einfo You can get more info about them in: man sane-plustek.
	einfo NOTE: Remember to use modules-update after checking your configuration.
	einfo
	einfo If you want this module to be loaded automatically at system boot,
	einfo add 'pt_drv' to /etc/modules.autoload.d/kernel-$(uname -r | sed 's/\([0-9].[0-9]\).*/\1/')

	ewarn "Please note that this program is DEPRECATED and will be removed from Portage"
	ewarn "in the nearest future. It is recommended that you install the latest"
	ewarn "sane-backends (1.0.13 or newer) instead."
}

