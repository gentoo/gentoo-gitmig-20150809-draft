# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.7.2.ebuild,v 1.8 2004/02/22 22:36:16 agriffis Exp $

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="mirror://sourceforge/tcpdump/${P}.tar.gz
	http://www.tcpdump.org/release/${P}.tar.gz
	http://www.jp.tcpdump.org/release/${P}.tar.gz"
HOMEPAGE="http://www.tcpdump.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha mips hppa ia64"

DEPEND=">=net-libs/libpcap-0.6.1
	ssl? ( >=dev-libs/openssl-0.6.9 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sctp.patch
}

src_compile() {
	local myconf

	use ssl || myconf="--without-crypto"
	econf \
		--enable-ipv6 \
		${myconf} || die
	make CCOPT="$CFLAGS" || die
}

src_install() {
	into /usr
	dosbin tcpdump
	doman tcpdump.1
	dodoc *.awk
	dodoc README FILES VERSION CHANGES
}
