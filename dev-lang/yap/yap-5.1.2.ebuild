# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yap/yap-5.1.2.ebuild,v 1.1 2007/11/21 06:25:28 keri Exp $

inherit autotools eutils java-pkg-opt-2

MY_P="Yap-${PV}"

DESCRIPTION="YAP is a high-performance Prolog compiler."
HOMEPAGE="http://www.ncc.up.pt/~vsc/Yap/"
SRC_URI="http://www.ncc.up.pt/~vsc/Yap/current/Yap-5.1.2.tar.gz"

LICENSE="Artistic LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc examples gmp java mpi mysql odbc readline static tk threads"

DEPEND="gmp? ( dev-libs/gmp )
	java? ( >=virtual/jdk-1.4 )
	mpi? ( virtual/mpi )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	readline? ( sys-libs/readline )"

RDEPEND="${DEPEND}
	tk? ( dev-lang/tk )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-multilib.patch
	epatch "${FILESDIR}"/${P}-parallel-make.patch
	epatch "${FILESDIR}"/${P}-SONAME.patch
	epatch "${FILESDIR}"/${P}-analyst.patch
	epatch "${FILESDIR}"/${P}-tabling.patch
	epatch "${FILESDIR}"/${P}-chr.patch
	epatch "${FILESDIR}"/${P}-jpl.patch
	epatch "${FILESDIR}"/${P}-tkyap.patch
}

src_compile() {
	eautoconf
	econf \
		--libdir=/usr/$(get_libdir) \
		--enable-low-level-tracer \
		--enable-rational-trees \
		--enable-coroutining \
		--enable-myddas-stats \
		--disable-tabling \
		--disable-eam \
		--disable-depth-limit \
		--disable-or-parallelism \
		$(use_enable threads) \
		$(use_enable threads pthread-locking) \
		$(use_enable threads use-malloc) \
		$(use_enable !static dynamic-loading) \
		$(use_enable debug debug-yap) \
		$(use_enable debug wam-profile) \
		$(use_enable mysql myddas-mysql) \
		$(use_enable mysql myddas-stats) \
		$(use_enable mysql myddas-top-level) \
		$(use_enable odbc myddas-odbc) \
		$(use_with gmp) \
		$(use_with readline) \
		$(use_with mpi) \
		$(use_with mpi mpe) \
		$(use_with java jpl) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."

	if use tk ; then
		exeinto /usr/bin
		doexe misc/tkyap
	fi

	dodoc changes*.html README

	if use doc ; then
		dodoc docs/yap.html
	fi

	if use examples ; then
		docinto examples
		dodoc CLPBN/clpbn/examples/cg.yap
		dodoc CLPBN/clpbn/examples/School/*
	fi
}
