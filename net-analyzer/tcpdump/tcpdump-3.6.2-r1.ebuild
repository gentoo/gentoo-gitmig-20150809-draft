# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-3.6.2-r1.ebuild,v 1.5 2002/07/21 20:52:37 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Tool for network monitoring and data acquisition"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
	 http://www.jp.tcpdump.org/release/${P}.tar.gz"
HOMEPAGE="http://www.tcpdump.org/"

DEPEND=">=net-libs/libpcap-0.6.2
	ssl? ( >=dev-libs/openssl-0.6.9 )"


LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
	cd ${S}
	# http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=49294
	patch -p1 < ${FILESDIR}/${P}-afsprinting.patch
	
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
	dobin tcpdump
	doman tcpdump.1
	dodoc README FILES VERSION CHANGES
}
