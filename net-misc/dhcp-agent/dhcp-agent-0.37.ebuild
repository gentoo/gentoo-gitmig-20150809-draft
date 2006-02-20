# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcp-agent/dhcp-agent-0.37.ebuild,v 1.12 2006/02/20 20:43:49 jokey Exp $

DESCRIPTION="dhcp-agent is a portable UNIX Dynamic Host Configuration suite"
HOMEPAGE="http://dhcp-agent.sourceforge.net/"
SRC_URI="mirror://sourceforge/dhcp-agent/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND=">=dev-libs/libdnet-1.4
		net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:net/bpf.h:pcap-bpf.h:' dhcp-net.c || die "sed failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README THANKS TODO UPGRADING CAVEATS
}
