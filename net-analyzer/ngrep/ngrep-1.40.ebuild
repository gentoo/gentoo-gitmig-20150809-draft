# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.40.ebuild,v 1.16 2004/07/01 20:11:05 squinky86 Exp $

S=${WORKDIR}/${PN}
IUSE=""
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/libc
	>=net-libs/libpcap-0.5.2"

RDEPEND="virtual/libc"

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
