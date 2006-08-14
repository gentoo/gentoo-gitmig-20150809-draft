# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scli/scli-0.2.12.ebuild,v 1.5 2006/08/14 09:41:21 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="SNMP Command Line Interface"
HOMEPAGE="http://www.ibr.cs.tu-bs.de/projects/scli/"
SRC_URI="ftp://ftp.ibr.cs.tu-bs.de/pub/local/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="debug"

RDEPEND="virtual/libc
	=dev-libs/glib-1.2*
	>=sys-libs/ncurses-5
	>=sys-libs/readline-4
	dev-libs/libxml2
	sys-libs/zlib
	debug? ( dev-libs/dmalloc )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-configure.diff
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_compile() {
	WANT_AUTOCONF=2.5 autoconf || die "autoconf failed"

	append-flags -I/usr/include/libxml2

	econf \
		--enable-warnings \
		$(use_enable debug dmalloc) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS NEWS TODO ChangeLog PORTING
}
