# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arpstar/arpstar-0.5.5.ebuild,v 1.1 2005/03/06 18:44:20 genstef Exp $

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
CONFIG_CHECK="NETFILTER"

src_install() {
	linux-mod_src_install

	dodoc arpstar.README
}
