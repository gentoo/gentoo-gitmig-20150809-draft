# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.8.3-r1.ebuild,v 1.2 2004/04/03 01:48:43 pylon Exp $

inherit flag-o-matic

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="mirror://sourceforge/tcpdump/${P}.tar.gz
	http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"
HOMEPAGE="http://www.tcpdump.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~mips ~hppa ~ia64 ~amd64"

DEPEND=">=net-libs/libpcap-0.8.3-r1
	ssl? ( >=dev-libs/openssl-0.9.6m )"

src_compile() {
	replace-flags -O[3-9] -O2

	econf `use_with ssl crypto` `use_enable ipv6` || die
	make CCOPT="$CFLAGS" || die
}

src_install() {
	into /usr
	dosbin tcpdump
	doman tcpdump.1
	dodoc *.awk
	dodoc README FILES VERSION CHANGES
}
