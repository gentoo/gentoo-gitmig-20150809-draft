# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.8.3.ebuild,v 1.2 2004/03/30 21:28:29 weeve Exp $

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
KEYWORDS="~x86 ~ppc sparc ~alpha ~mips ~hppa ~ia64 ~amd64"

DEPEND=">=net-libs/libpcap-0.6.1
	ssl? ( >=dev-libs/openssl-0.6.9 )"

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
