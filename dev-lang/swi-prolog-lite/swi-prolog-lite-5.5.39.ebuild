# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog-lite/swi-prolog-lite-5.5.39.ebuild,v 1.4 2006/01/14 18:41:38 grobian Exp $

inherit eutils

DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://gollem.science.uva.nl/cgi-bin/nph-download/SWI-Prolog/BETA/pl-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~sparc ~x86"
IUSE="berkdb gmp odbc readline ssl static tetex threads X"

DEPEND="sys-libs/ncurses
	odbc? ( dev-db/unixODBC )
	berkdb? ( sys-libs/db )
	readline? ( sys-libs/readline )
	gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	X? ( || ( (
		x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXpm
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-proto/xproto )
		virtual/x11 ) )"

S=${WORKDIR}/pl-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-packages-mp-DESTDIR.patch
	epatch "${FILESDIR}"/${P}-packages-semweb-64bit.patch
	epatch "${FILESDIR}"/${P}-packages-ltx2htm-DESTDIR.patch
}

src_compile() {
	cd src
	econf \
		$(use_enable gmp) \
		$(use_enable readline) \
		$(use_enable !static shared) \
		$(use_enable threads mt) \
		--disable-custom-flags \
		|| die "econf dev failed"
	emake || die "make dev failed"

	cd ../packages
	econf \
		--without-C-sicstus \
		--with-chr \
		--with-clib \
		--with-clpr \
		--with-cpp \
		$(use_with berkdb db) \
		--with-http \
		--without-jasmine \
		--with-jpl \
		$(use_with tetex ltx2htm) \
		$(use_with gmp mp) \
		$(use_with odbc) \
		$(use_with ssl) \
		--with-table \
		$(use_with X xpce) \
		|| die
	make || die
}

src_install() {
	make -C src DESTDIR="${D}" install || die "install src failed"
	make -C packages DESTDIR="${D}" install || die "install packages failed"
	dodoc ANNOUNCE ChangeLog INSTALL INSTALL.notes PORTING README VERSION
}
