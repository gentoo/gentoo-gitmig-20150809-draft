# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.40.ebuild,v 1.18 2005/02/20 20:09:24 ka0ttic Exp $

S=${WORKDIR}/${PN}
IUSE=""
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/libc
	virtual/libpcap"

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
