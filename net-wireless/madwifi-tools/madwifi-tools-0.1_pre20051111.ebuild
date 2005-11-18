# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-tools/madwifi-tools-0.1_pre20051111.ebuild,v 1.2 2005/11/18 20:59:58 cryos Exp $

MADWIFI_SVN_REV="1325"
DESCRIPTION="Wireless tools for Atheros chipset a/b/g cards"
HOMEPAGE="http://www.madwifi.org"
SRC_URI="http://snapshots.madwifi.org/madwifi-trunk-r${MADWIFI_SVN_REV}-${PV:7:8}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~ppc ~x86"
IUSE=""
DEPEND="virtual/libc"

S=${WORKDIR}/madwifi-trunk-r${MADWIFI_SVN_REV}-${PV:7:8}/tools

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:err(1, ifr.ifr_name);:err(1, "%s", ifr.ifr_name);:g' athstats.c
	sed -i "s:CFLAGS=:CFLAGS+=:" Makefile
	sed -i "s:LDFLAGS=:LDFLAGS+=:" Makefile
}

src_install() {
	make install DESTDIR=${D} BINDIR=/usr/bin MANDIR=/usr/share/man || die "make install failed"
	dodir /sbin
	mv ${D}/usr/bin/wlanconfig ${D}/sbin
}
