# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.41.ebuild,v 1.6 2004/02/06 14:22:56 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2
	sys-devel/autoconf"

RDEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha ~amd64"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${P}-libpcap-include.patch
	epatch ${FILESDIR}/${P}-fix-HAVE_DUMB_UDPHDR-test.patch
}

src_compile() {
	autoconf

	econf || die
	make || die
}

src_install() {
	into /usr
	dobin ngrep
	doman ngrep.8
	dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}
