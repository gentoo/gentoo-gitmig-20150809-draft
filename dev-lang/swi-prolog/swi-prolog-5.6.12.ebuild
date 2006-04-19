# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog/swi-prolog-5.6.12.ebuild,v 1.1 2006/04/19 06:45:18 keri Exp $

inherit autotools eutils flag-o-matic

DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://gollem.science.uva.nl/cgi-bin/nph-download/SWI-Prolog/pl-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="berkdb doc gmp java minimal odbc readline ssl static tetex threads X"

DEPEND="sys-libs/ncurses
	odbc? ( dev-db/unixODBC )
	berkdb? ( sys-libs/db )
	readline? ( sys-libs/readline )
	gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	java? ( virtual/jdk )
	X? ( media-libs/jpeg
		|| ( (
			x11-libs/libX11
			x11-libs/libXft
			x11-libs/libXpm
			x11-libs/libXt
			x11-libs/libICE
			x11-libs/libSM
			x11-proto/xproto )
		virtual/x11 ) )"

S="${WORKDIR}/pl-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "s/man boot library/boot library/" src/Makefile.in
	epatch "${FILESDIR}"/${PN}-CFLAGS.patch
	epatch "${FILESDIR}"/${PN}-test.patch

	if ! use minimal ; then
		epatch "${FILESDIR}"/${PN}-packages-portage.patch
		epatch "${FILESDIR}"/${PN}-packages-cppproxy.patch
		epatch "${FILESDIR}"/${PN}-packages-db-db4.patch
		epatch "${FILESDIR}"/${PN}-packages-jpl-arch.patch
		epatch "${FILESDIR}"/${PN}-packages-ltx2htm.patch
		epatch "${FILESDIR}"/${PN}-packages-test-r1.patch
	fi
}

src_compile() {
	append-flags -fno-strict-aliasing

	einfo "Building SWI-Prolog compiler"
	cd "${S}"/src
	econf \
		$(use_enable gmp) \
		$(use_enable readline) \
		$(use_enable !static shared) \
		$(use_enable threads mt) \
		--disable-custom-flags \
		|| die "econf failed"
	emake -j1 || die "emake failed"

	if ! use minimal ; then
		einfo "Building SWI-Prolog additional packages"

		for package in clib cppproxy db jpl ltx2htm nlp odbc semweb sgml ssl table xpce/src
		do
			cd "${S}/packages/${package}"
			eautoreconf
		done

		cd "${S}/packages"
		econf \
			$(use_enable !static shared) \
			$(use_enable threads mt) \
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

		emake -j1 || die "packages emake failed"
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
