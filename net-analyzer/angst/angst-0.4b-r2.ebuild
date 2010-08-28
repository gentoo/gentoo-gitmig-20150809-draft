# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/angst/angst-0.4b-r2.ebuild,v 1.1 2010/08/28 15:52:56 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="an active sniffer that provides methods for aggressive sniffing on switched LANs"
HOMEPAGE="http://angst.sourceforge.net/"
SRC_URI="http://angst.sourceforge.net/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="net-libs/libpcap
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"

src_prepare() {
cp -av Makefile.linux{,.orig}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
	sed -i Makefile.linux \
		-e 's|^CC =|CC ?=|g' \
		-e '/ -o angst /s|$(OBJS)|$(LDFLAGS) &|g' \
		|| die "sed Makefile.linux"
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" \
		-f Makefile.linux || die
}

src_install() {
	dosbin angst
	doman angst.8
	dodoc README LICENSE TODO ChangeLog
}
