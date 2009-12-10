# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arping/arping-2.08-r1.ebuild,v 1.1 2009/12/10 17:51:34 jer Exp $

inherit toolchain-funcs

DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=arping"
SRC_URI="ftp://ftp.habets.pp.se/pub/synscan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.0-r3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile
	# since we install as arping2, use arping2 in the man page
	sed -i -e "s|\(${PN}\)|\12|g" ${PN}.8 || die "sed ${PN}.8 failed"
	sed -i -e "s|\(${PN}\) |\12 |g" ${PN}-scan-net.sh || \
		die "sed ${PN}-scan-net.sh failed"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		LDLIBS="-lpcap -lnet" \
		arping-2/arping \
		|| die
}

src_test() {
	einfo "Selftest only works as root"
	#make SUDO= HOST=`hostname` MAC=`ifconfig -a | fgrep HWaddr | sed 's/.*HWaddr //g'` test
}

src_install() {
	newsbin ${PN}-2/${PN} ${PN}2 || die
	newman ${PN}.8 ${PN}2.8
	dodoc README
	newdoc ${PN}{,2}-scan-net.sh
}
