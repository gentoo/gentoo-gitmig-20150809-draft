# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-tools/madwifi-tools-0.1_pre20050107.ebuild,v 1.2 2005/01/19 13:24:09 solar Exp $

DESCRIPTION="Wireless tools for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"
SRC_URI="http://madwifi.otaku42.de/${PV:7:4}/${PV:11:2}/madwifi-cvs-snapshot-${PV:7:4}-${PV:11:2}-${PV:13:2}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~amd64"
KEYWORDS="-*"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/madwifi/tools

pkg_setup() {
	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	export TARGET
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/err(1, ifr.ifr_name);/err(1, "%s", ifr.ifr_name);'/g tools/athstats.c
}

src_install() {
	dobin 80211debug 80211stats athchans athctrl athdebug athkey athstats
}
