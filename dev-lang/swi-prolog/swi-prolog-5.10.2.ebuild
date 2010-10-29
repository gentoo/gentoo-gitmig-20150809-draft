# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog/swi-prolog-5.10.2.ebuild,v 1.1 2010/10/29 18:50:37 keri Exp $

inherit eutils flag-o-matic java-pkg-opt-2

PATCHSET_VER="0"

DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://www.swi-prolog.org/download/stable/src/pl-${PV}.tar.gz
	mirror://gentoo/${P}-gentoo-patchset-${PATCHSET_VER}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="berkdb debug doc gmp hardened java minimal odbc readline ssl static test zlib X"

RDEPEND="sys-libs/ncurses
	zlib? ( sys-libs/zlib )
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
		x11-libs/libSM )"

DEPEND="${RDEPEND}
	X? ( x11-proto/xproto )
	java? ( test? ( =dev-java/junit-3.8* ) )"

S="${WORKDIR}/pl-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_FORCE=yes
	EPATCH_SUFFIX=patch
	epatch "${WORKDIR}"/${PV}
}

src_compile() {
	append-flags -fno-strict-aliasing
	use hardened && append-flags -fno-unit-at-a-time
	use debug && append-flags -DO_DEBUG

	cd "${S}"/src
	econf \
		--libdir=/usr/$(get_libdir) \
		$(use_enable gmp) \
		$(use_enable readline) \
		$(use_enable !static shared) \
		--enable-custom-flags COFLAGS="${CFLAGS}"

	emake || die "emake failed"

	if ! use minimal ; then
		local jpltestconf
		if use java && use test ; then
			jpltestconf="--with-junit=$(java-config --classpath junit)"
		fi

		cd "${S}/packages"
		econf \
			--libdir=/usr/$(get_libdir) \
			--with-chr \
			--with-clib \
			--with-clpqr \
			--with-cpp \
			--with-cppproxy \
			$(use_with berkdb db) \
			--with-http \
			$(use_with java jpl) \
			${jpltestconf} \
			--with-nlp \
			$(use_with odbc) \
			--with-pldoc \
			--with-plunit \
			--with-protobufs \
			--with-R \
			--with-RDF \
			--with-semweb \
			--with-sgml \
			$(use_with ssl) \
			--with-table \
			--with-tipc \
			$(use_with X xpce) \
			$(use_with zlib) \
			COFLAGS='"${CFLAGS}"'

		emake || die "packages emake failed"
	fi
}

src_test() {
	cd "${S}/src"
	emake check || die "make check failed. See above for details."

	if ! use minimal ; then
		cd "${S}/packages"
		emake check || die "make check failed. See above for details."
	fi
}

src_install() {
	emake -C src DESTDIR="${D}" install || die "install src failed"

	if ! use minimal ; then
		emake -C packages DESTDIR="${D}" install || die "install packages failed"
		if use doc ; then
			emake -C packages DESTDIR="${D}" html-install || die "html-install failed"
			emake -C packages/cppproxy DESTDIR="${D}" install-examples || die "install-examples failed"
		fi
	fi

	dodoc ReleaseNotes/relnotes-5.10 INSTALL PORTING README VERSION || die
}
