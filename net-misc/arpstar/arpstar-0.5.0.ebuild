# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arpstar/arpstar-0.5.0.ebuild,v 1.1 2005/03/04 13:32:32 genstef Exp $

inherit linux-mod

DESCRIPTION="ARPStar kernel module for protection against arp poisoning."
HOMEPAGE="http://arpstar.sourceforge.net"
SRC_URI="mirror://sourceforge/arpstar/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}

MODULE_NAMES="arpstar(net:)"
BUILD_TARGETS=" "
BUILD_PARAMS="KDIR=${KV_DIR}"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is gt 2 6 10 || kernel_is lt 2 6 9
	then
		einfo "This module does not build for kernels >2.6.10 or <2.6.9"
		die "Kernel too new .."
	fi
}
