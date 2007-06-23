# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ccze/ccze-0.2.1-r2.ebuild,v 1.5 2007/06/23 15:57:16 angelos Exp $

inherit fixheadtails autotools eutils

DESCRIPTION="A flexible and fast logfile colorizer"
HOMEPAGE="http://bonehunter.rulez.org/software/ccze/"
SRC_URI="ftp://bonehunter.rulez.org/pub/ccze/stable/${P}.tar.gz"

RESTRICT="test"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libpcre"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/ccze-fbsd.patch || die "epatch ccze-fbsd.patch failed"
	epatch "${FILESDIR}"/ccze-segfault.patch || die "epatch ccze-segfault.patch"

	# GCC 4.x fixes
	sed -e 's/-Wswitch -Wmulticharacter/-Wswitch/' \
	    -i src/Makefile.in
	sed -e '/AC_CHECK_TYPE(error_t, int)/d' \
	    -i configure.ac

	eautoreconf

	ht_fix_file Rules.mk.in
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog ChangeLog-0.1 NEWS THANKS README FAQ
}
