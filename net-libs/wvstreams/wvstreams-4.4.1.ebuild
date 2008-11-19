# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-4.4.1.ebuild,v 1.3 2008/11/19 19:30:33 loki_val Exp $

EAPI=1

WANT_AUTOCONF=latest
WANT_AUTOMAKE=none

inherit eutils fixheadtails autotools qt3

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://alumnit.ca/wiki/?WvStreams"
SRC_URI="http://wvstreams.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="qt3 qdbm pam slp doc debug"

RESTRICT="test"

RDEPEND=">=sys-libs/db-4
	sys-libs/zlib
	dev-libs/openssl
	dev-libs/xplc
	qt3? ( x11-libs/qt:3 )
	qdbm? ( dev-db/qdbm )
	pam? ( sys-libs/pam )
	slp? ( net-libs/openslp )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-linux-serial.patch"
	epatch "${FILESDIR}/${P}-wireless-user.patch"
	epatch "${FILESDIR}/${P}-uniconfd-ini.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-type-punned.patch"
	epatch "${FILESDIR}/${P}-sigaction.patch"
	epatch "${FILESDIR}/${P}-wvconfemu.patch"
	epatch "${FILESDIR}/${P}-external-xplc.patch"
	use qt3 && epatch "${FILESDIR}/${P}-MOC-fix.patch"
	epatch "${FILESDIR}/${P}-valgrind.patch"
	epatch "${FILESDIR}/${P}-gnulib.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"

	ht_fix_file "${S}/configure.ac"

	cd "${S}"

	sed -r -i \
		-e '/AC_DEFINE.*__EXTENSIONS__/d' \
		gnulib/m4/extensions.m4
	sed -i -n \
		 -e :a -e '1,10!{P;N;D;};N;ba' \
		 configure.ac
	#needed by xplc, as-needed and gnulib patch
	AT_M4DIR="gnulib/m4" eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf \
		`use_with qdbm` \
		`use_with pam` \
		`use_with slp openslp` \
		`use_with qt3 qt` \
		`use_enable debug` \
		--disable-optimization \
		--without-tcl \
		--without-swig \
		--with-xplc \
		--enable-verbose \
		--with-bdb \
		--with-zlib \
		--with-openssl \
		|| die "configure failed"
	emake CXXOPTS="-fPIC -DPIC" COPTS="-fPIC -DPIC" || die "compile failed"
	use doc && doxygen
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if use doc ; then
		#the list of files is too big for dohtml -r Docs/doxy-html/*
		cd Docs/doxy-html
		dohtml -r *
	fi
}
