# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arpstar/arpstar-0.5.5-r1.ebuild,v 1.2 2006/08/08 10:13:00 phreak Exp $

inherit eutils linux-mod

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-2.6.16.patch
}

src_install() {
	linux-mod_src_install

	dodoc arpstar.README
}
