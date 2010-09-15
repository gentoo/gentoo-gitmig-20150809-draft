# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arping/arping-2.09-r1.ebuild,v 1.1 2010/09/15 01:33:35 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A utility to see if a specific IP address is taken and what MAC address owns it"
HOMEPAGE="http://www.habets.pp.se/synscan/programs.php?prog=arping"
SRC_URI="http://www.habets.pp.se/synscan/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.0-r3"

src_prepare() {
	rm -f Makefile
	# since we install as arping2, use arping2 in the man page
	sed \
		-e "s|\(${PN}\)|\12|g" \
		-e "s|\(${PN}\)\(\W\)|\12\2|g" \
		-e "s|${PN}2-|${PN}-|g" \
		-e "s|(${PN}2 2.*\.x only)||g" \
		-i doc/${PN}.8 || die "sed ${PN}.8 failed"
	sed \
		-e "s|\(${PN}\) |\12 |g" \
		-i extra/${PN}-scan-net.sh || die "sed ${PN}-scan-net.sh failed"
}

src_test() {
	einfo "Selftest only works as root"
	#make SUDO= HOST=`hostname` MAC=`ifconfig -a | fgrep HWaddr | sed 's/.*HWaddr //g'` test
}

src_install() {
	# since we install as arping2, we cannot use emake install
	newsbin src/${PN} ${PN}2 || die
	newman doc/${PN}.8 ${PN}2.8
	dodoc README extra/arping-scan-net.sh
}
