# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-1.0.0_beta2.ebuild,v 1.1 2004/01/25 07:30:23 brad_mssw Exp $

DESCRIPTION="LiveCD tools (autoconfig, net-setup)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~brad_mssw/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc hppa alpha"
#KEYWORDS="-* amd64 x86 sparc hppa"
RESTRICT="nomirror"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tar.bz2
}

src_install() {
	mkdir -p ${D}/etc/init.d
	mkdir -p ${D}/sbin
	cp ${S}/autoconfig ${D}/etc/init.d
	cp ${S}/net-setup ${D}/sbin
	chmod +x ${D}/sbin/net-setup
	chmod +x ${D}/etc/init.d/autoconfig
}
