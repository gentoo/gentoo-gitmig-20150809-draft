# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/reaim/reaim-0.8.ebuild,v 1.2 2004/06/18 20:14:19 dholm Exp $

DESCRIPTION="AIM transport proxy over NAT firewalls"
HOMEPAGE="http://reaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/reaim/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=sys-apps/sed-4"
RDEPEND="net-firewall/iptables"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:-g -Wall:${CFLAGS} -g -Wall:g' Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/sbin
	insopts -o root -g root -m 0750 ; doins reaim

	doman reaim.8
	dodoc html/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/reaim reaim
}

pkg_postinst() {
	einfo "In order to use reaim, run the rc script in /etc/init.d."
	einfo
	einfo "To start:"
	einfo "  /etc/init.d/reaim start"
	einfo "To stop:"
	einfo "  /etc/init.d/reaim stop"
	einfo
	einfo "To have reaim start at each system startup, run the following:"
	einfo "  rc-update add reaim default"
}
