# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yap/yap-5.1.1.ebuild,v 1.1 2006/04/24 08:13:26 keri Exp $

inherit autotools eutils

MY_P="Yap-${PV}"

DESCRIPTION="YAP is a high-performance Prolog compiler."
HOMEPAGE="http://www.ncc.up.pt/~vsc/Yap/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="Artistic LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug doc gmp java mpi mysql odbc readline static tcltk threads"

DEPEND="gmp? ( dev-libs/gmp )
	java? ( virtual/jdk )
	mpi? ( virtual/mpi )
	mysql? ( dev-db/mysql )
	odbc? ( dev-db/unixODBC )
	readline? ( sys-libs/readline )"

RDEPEND="${DEPEND}
	tcltk? ( dev-lang/tk )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-analyst.patch
	epatch "${FILESDIR}"/${P}-myddas.patch
	epatch "${FILESDIR}"/${P}-tabling.patch
	epatch "${FILESDIR}"/${P}-tkyap.patch
}

src_compile() {
	eautoconf
	econf \
		--enable-low-level-tracer \
		--enable-rational-trees \
		--enable-coroutining \
		--enable-myddas-stats \
		--enable-tabling \
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
	make DESTDIR="${D}" install || die "make install failed."

	if use tcltk ; then
		exeinto /usr/bin
		doexe misc/tkyap
	fi

	if use doc ; then
		dodoc docs/yap.html
		docinto examples
		dodoc CLPBN/clpbn/examples/cg.yap
		dodoc CLPBN/clpbn/examples/School/*
	fi

	doinfo docs/*.info*
	dodoc changes4.3.html INSTALL README
}
