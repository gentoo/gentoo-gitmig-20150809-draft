# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/raccess/raccess-0.7.ebuild,v 1.8 2009/01/05 18:28:57 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Remote Access Session is an systems security analyzer"
HOMEPAGE="http://salix.org/raccess/"
SRC_URI="http://salix.org/raccess/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~amd64"
IUSE=""

DEPEND="net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/^BINFILES/s:@bindir@:/usr/lib/raccess:' src/Makefile.in
	sed -i '/^bindir/s:@bindir@/exploits:/usr/lib/raccess:' exploits/Makefile.in
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	econf --sysconfdir=/etc/raccess
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS PROJECT_PLANNING README
}
