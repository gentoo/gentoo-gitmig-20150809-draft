# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.42.ebuild,v 1.12 2004/11/02 15:11:27 vapier Exp $

inherit eutils

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ppc-macos s390 sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=net-libs/libpcap-0.5.2
	sys-devel/autoconf"
RDEPEND="virtual/libc"

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
	dodoc BUGS CHANGES CREDITS README TODO USAGE
}
