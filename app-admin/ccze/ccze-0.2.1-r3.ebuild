# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ccze/ccze-0.2.1-r3.ebuild,v 1.3 2010/10/31 22:23:39 joker Exp $

inherit fixheadtails autotools eutils toolchain-funcs

DESCRIPTION="A flexible and fast logfile colorizer"
HOMEPAGE="http://dev.gentoo.org/~joker/ccze/ccze.txt"
SRC_URI="mirror://gentoo/${P}.tar.gz"

RESTRICT="test"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libpcre"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/ccze-fbsd.patch || die "epatch ccze-fbsd.patch failed"
	epatch "${FILESDIR}"/ccze-segfault.patch || die "epatch ccze-segfault.patch"
	epatch "${FILESDIR}"/ccze-ldflags.patch || die "epatch ccze-ldflags.patch"

	# GCC 4.x fixes
	sed -e 's/-Wswitch -Wmulticharacter/-Wswitch/' \
	    -i src/Makefile.in
	sed -e '/AC_CHECK_TYPE(error_t, int)/d' \
	    -i configure.ac

	eautoreconf

	ht_fix_file Rules.mk.in
}

src_compile() {
	# Bug #243314
	tc-export CC
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog ChangeLog-0.1 NEWS THANKS README FAQ
}
