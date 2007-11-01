# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-3.2.1.ebuild,v 1.1 2007/11/01 12:11:14 pva Exp $

DESCRIPTION="replay saved tcpdump or snoop files at arbitrary speeds"
HOMEPAGE="http://tcpreplay.synfin.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug pcapnav"

DEPEND=">=net-libs/libnet-1.1.1
	net-libs/libpcap
	net-analyzer/tcpdump
	pcapnav? ( net-libs/libpcapnav )"

src_compile() {
	econf \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	whoami
	if hasq userpriv "${FEATURES}"; then
		ewarn "Some tested disabled due to FEATURES=userpriv"
		ewarn "For a full test as root - make -C ${S}/test"
		make -C test tcpprep || die "self test failed - see ${S}/test/test.log"
	else
		make test || \
			ewarn "Note, that some tests require eth0 iface to be UP."
			die "self test failed - see ${S}/test/test.log"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/usr/bin/man2html
	dodoc docs/{CHANGELOG,CREDIT,HACKING,TODO}
}
