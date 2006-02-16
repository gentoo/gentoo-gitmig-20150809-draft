# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/packit/packit-1.0.ebuild,v 1.12 2006/02/15 23:45:21 jokey Exp $

inherit eutils

DESCRIPTION="network auditing tool that allows you to monitor, manipulate, and inject customized IPv4 traffic"
HOMEPAGE="http://www.packetfactory.net/projects/packit/"
SRC_URI="http://www.packetfactory.net/projects/packit/downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc-macos"
IUSE=""

DEPEND=">=net-libs/libnet-1.1.2
	net-libs/libpcap"

src_unpack(){
	unpack ${A}
	sed -i 's:net/bpf.h:pcap-bpf.h:g' "${S}"/src/{globals.h,main.h} || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc VERSION docs/*
}
