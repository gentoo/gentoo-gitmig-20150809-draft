# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ttt/ttt-1.8.ebuild,v 1.6 2005/01/29 05:12:52 dragonheart Exp $

inherit eutils

DESCRIPTION="Tele Traffic Taper (ttt) - Real-time Graphical Remote Traffic Monitor"
SRC_URI="ftp://ftp.csl.sony.co.jp/pub/kjc/${P}.tar.gz"
HOMEPAGE="http://www.csl.sony.co.jp/person/kjc/kjc/software.html"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"
IUSE="ipv6"

DEPEND="virtual/libc
	virtual/x11
	dev-lang/tcl
	dev-lang/tk
	>=dev-tcltk/blt-2.4
	virtual/libpcap
	sys-apps/grep"

src_unpack() {
	unpack ${A}

	cd ${S}
	grep -q 'pcap_lookupnet.*const' /usr/include/pcap.h &&
		epatch ${FILESDIR}/${P}-pcap.patch

	epatch ${FILESDIR}/${P}-linux-sll.patch
}

src_compile() {
	local myconf
	use ipv6 && myconf="${myconf} --enable-ipv6"

	econf ${myconf} || die "./configure failed"

	emake || die "make failed"
}

src_install() {
	dodoc README
	dodir /usr/bin
	dodir /usr/lib/ttt
	dodir /usr/share/man/man1
	einstall exec_prefix=${D}/usr install-man || die "make install failed"
	prepall
}
