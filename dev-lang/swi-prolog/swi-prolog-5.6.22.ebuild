# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog/swi-prolog-5.6.22.ebuild,v 1.1 2006/10/18 06:17:04 keri Exp $

inherit eutils

DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://gollem.science.uva.nl/cgi-bin/nph-download/SWI-Prolog/pl-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~sparc ~x86"
IUSE="berkdb doc gmp java minimal odbc readline ssl static tetex threads X"

DEPEND="!dev-lang/swi-prolog-lite
	sys-libs/ncurses
	odbc? ( dev-db/unixODBC )
	berkdb? ( sys-libs/db )
	readline? ( sys-libs/readline )
	gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	java? ( >=virtual/jdk-1.4 )
	X? (
		media-libs/jpeg
		x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXpm
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-proto/xproto )"

S="${WORKDIR}/pl-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/man boot library/boot library/" src/Makefile.in
	epatch "${FILESDIR}"/${PN}-portage-r1.patch
	epatch "${FILESDIR}"/${PN}-CFLAGS-r2.patch
	epatch "${FILESDIR}"/${PN}-PLBASE-r2.patch
	epatch "${FILESDIR}"/${PN}-cppproxy-r1.patch
	epatch "${FILESDIR}"/${PN}-jpl-LDPATH.patch
	epatch "${FILESDIR}"/${PN}-ltx2htm.patch
	epatch "${FILESDIR}"/${PN}-SGML_CATALOG_FILES.patch
	epatch "${FILESDIR}"/${PN}-thread-tests.patch
	epatch "${FILESDIR}"/${PN}-xpce-parallel-build.patch
	epatch "${FILESDIR}"/${PN}-xpce-test.patch
}

src_compile() {
	einfo "Building SWI-Prolog compiler"

	local threadconf
	if use java && ! use minimal || use threads ; then
		threadconf="--enable-mt"
	else
		threadconf="--disable-mt"
	fi

	cd "${S}"/src
	econf \
		--libdir=/usr/$(get_libdir) \
		${threadconf} \
		$(use_enable gmp) \
		$(use_enable readline) \
		$(use_enable !static shared) \
		--disable-custom-flags \
		|| die "econf failed"
	emake || die "emake failed"

	if ! use minimal ; then
		einfo "Building SWI-Prolog additional packages"

		cd "${S}/packages"
		econf \
			--libdir=/usr/$(get_libdir) \
			${threadconf} \
			$(use_enable !static shared) \
			--without-C-sicstus \
			--with-chr \
			--with-clib \
			--with-clpqr \
			--with-cpp \
			--with-cppproxy \
			$(use_with berkdb db) \
			--with-http \
			--without-jasmine \
			$(use_with java jpl) \
			$(use_with tetex ltx2htm) \
			--with-nlp \
			$(use_with odbc) \
			--with-semweb \
			--with-sgml \
			--with-sgml/RDF \
			$(use_with ssl) \
			--with-table \
			$(use_with X xpce) \
			|| die "packages econf failed"

		emake || die "packages emake failed"
	fi
}

src_install() {
	make -C src DESTDIR="${D}" install || die "install src failed"

	if ! use minimal ; then
		make -C packages DESTDIR="${D}" install || die "install packages failed"
		if use doc ; then
			make -C packages DESTDIR="${D}" html-install || die "html-install failed"
			make -C packages/cppproxy DESTDIR="${D}" install-examples || die "install-examples failed"
		fi
	fi

	dodoc ANNOUNCE ChangeLog INSTALL INSTALL.notes PORTING README README.GUI VERSION
}

src_test() {
	cd "${S}/src"
	make check || die "make check failed. See above for details."

	if ! use minimal ; then
		cd "${S}/packages"
		make check || die "make check failed. See above for details."
	fi
}
