# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog/swi-prolog-5.6.37.ebuild,v 1.4 2007/08/14 07:24:07 keri Exp $

inherit eutils flag-o-matic java-pkg-opt-2

PATCHSET_VER="2"

DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://gollem.science.uva.nl/cgi-bin/nph-download/SWI-Prolog/pl-${PV}.tar.gz
	mirror://gentoo/${P}-gentoo-patchset-${PATCHSET_VER}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="berkdb debug doc gmp java minimal odbc readline ssl static tetex threads zlib X"

DEPEND="!dev-lang/swi-prolog-lite
	sys-libs/ncurses
	zlib? ( sys-libs/zlib )
	odbc? ( dev-db/unixODBC )
	berkdb? ( sys-libs/db )
	readline? ( sys-libs/readline )
	gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	java? ( >=virtual/jdk-1.4
		dev-java/junit )
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

	epatch "${WORKDIR}"/${PV}/1000-cflags.patch
	epatch "${WORKDIR}"/${PV}/1001-multilib.patch
	epatch "${WORKDIR}"/${PV}/2100-thread-sandbox.patch
	epatch "${WORKDIR}"/${PV}/2101-thread-signal.patch
	epatch "${WORKDIR}"/${PV}/2102-rl-errno.patch
	epatch "${WORKDIR}"/${PV}/2103-free-stacks.patch
	epatch "${WORKDIR}"/${PV}/2104-setjmp-debug.patch
	epatch "${WORKDIR}"/${PV}/2105-pl-profile-va-debug.patch
	epatch "${WORKDIR}"/${PV}/2800-mandir.patch
	epatch "${WORKDIR}"/${PV}/2900-thread-library.patch
	epatch "${WORKDIR}"/${PV}/3029-clib-test.patch
	epatch "${WORKDIR}"/${PV}/3059-ssl-test.patch
	epatch "${WORKDIR}"/${PV}/3069-semweb-test.patch
	epatch "${WORKDIR}"/${PV}/3150-jpl-env.patch
	epatch "${WORKDIR}"/${PV}/3151-jpl-ppc-arch.patch
	epatch "${WORKDIR}"/${PV}/3152-jpl-junit.patch
	epatch "${WORKDIR}"/${PV}/3153-jpl-jni-object-to-term.patch
	epatch "${WORKDIR}"/${PV}/3159-jpl-test.patch
	epatch "${WORKDIR}"/${PV}/3160-xpce-parallel-build.patch
	epatch "${WORKDIR}"/${PV}/3139-sgml-test.patch
	epatch "${WORKDIR}"/${PV}/3149-sgml-RDF-test.patch
	epatch "${WORKDIR}"/${PV}/3169-xpce-test.patch
	epatch "${WORKDIR}"/${PV}/3199-ltx2htm.patch
	epatch "${WORKDIR}"/${PV}/3229-zlib-test.patch
}

src_compile() {
	einfo "Building SWI-Prolog compiler"

	use debug && append-flags -DO_DEBUG

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
			--with-pldoc \
			--with-plunit \
			--with-semweb \
			--with-sgml \
			--with-sgml/RDF \
			$(use_with ssl) \
			--with-table \
			$(use_with X xpce) \
			$(use_with zlib) \
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
