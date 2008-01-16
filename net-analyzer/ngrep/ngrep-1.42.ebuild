# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.42.ebuild,v 1.16 2008/01/16 20:42:01 grobian Exp $

inherit eutils

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

RDEPEND="virtual/libc
	net-libs/libpcap"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-libpcap-include.patch
}

src_compile() {
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"

	econf || die "econf failed"
	make || die "make failed"
}

src_install() {
	dobin ngrep
	doman ngrep.8
	dodoc BUGS CHANGES CREDITS INSTALL LICENSE README README.pcre TODO
}
