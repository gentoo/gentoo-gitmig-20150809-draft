# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.42.ebuild,v 1.2 2004/07/27 02:53:04 j4rg0n Exp $

inherit eutils

IUSE=""
DESCRIPTION="A grep for network layers"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://ngrep.sourceforge.net"

DEPEND="virtual/libc
	>=net-libs/libpcap-0.5.2
	sys-devel/autoconf"

RDEPEND="virtual/libc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 macos"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-libpcap-include.patch
}

src_compile() {
	WANT_AUTOCONF=2.5 autoconf

	econf || die
	make || die
}

src_install() {
	into /usr
	dobin ngrep
	doman ngrep.8
	dodoc BUGS CHANGES COPYRIGHT CREDITS README TODO USAGE
}
