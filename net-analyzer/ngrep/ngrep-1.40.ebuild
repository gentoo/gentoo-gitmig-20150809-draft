# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.40.ebuild,v 1.12 2003/09/05 23:40:10 msterret Exp $

S=${WORKDIR}/ngrep
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.gz"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2"

RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc ~alpha"

src_compile() {

	econf || die
	make || die
}

src_install() {

	into /usr
	dobin ngrep
	doman ngrep.8
	dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}



