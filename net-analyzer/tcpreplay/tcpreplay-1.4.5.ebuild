# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-1.4.5.ebuild,v 1.2 2003/09/24 06:31:36 vapier Exp $

DESCRIPTION="replay saved tcpdump or snoop files at arbitrary speeds"
HOMEPAGE="http://www.sourceforge.net/projects/tcpreplay/"
SRC_URI="mirror://sourceforge/tcpreplay/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-libs/libnet-1.1.0-r3
	net-libs/libpcap"

src_compile() {
	econf || die
	sed -i 's:/usr/share:\${prefix}/share:g' Makefile
	make || die
}

src_install() {
	einstall || die
	dodoc Docs/*
}
