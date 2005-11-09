# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-tools/madwifi-tools-0.1_pre20051031.ebuild,v 1.1 2005/11/09 05:57:45 latexer Exp $

MADWIFI_SVN_REV="1227"
DESCRIPTION="Wireless tools for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"
SRC_URI="http://snapshots.madwifi.org/madwifi-trunk-r${MADWIFI_SVN_REV}-${PV:7:8}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/madwifi-trunk-r${MADWIFI_SVN_REV}-${PV:7:8}/tools

pkg_setup() {
	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	export TARGET
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/err(1, ifr.ifr_name);/err(1, "%s", ifr.ifr_name);'/g ${S}/athstats.c
}

src_install() {
	dobin 80211debug 80211stats athchans athctrl athdebug athkey athstats
}
