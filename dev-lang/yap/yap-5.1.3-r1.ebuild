# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yap/yap-5.1.3-r1.ebuild,v 1.3 2009/01/24 21:24:09 keri Exp $

inherit autotools eutils java-pkg-opt-2

MY_P="Yap-${PV}"

DESCRIPTION="YAP is a high-performance Prolog compiler."
HOMEPAGE="http://www.ncc.up.pt/~vsc/Yap/"
SRC_URI="http://www.ncc.up.pt/~vsc/Yap/current/Yap-5.1.3.tar.gz"

LICENSE="Artistic LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug doc examples gmp java mpi mysql odbc readline static tk threads"

DEPEND="gmp? ( dev-libs/gmp )
	java? ( >=virtual/jdk-1.4 )
	mpi? ( virtual/mpi )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	readline? ( sys-libs/readline )
	doc? ( app-text/texi2html )"

RDEPEND="${DEPEND}
	tk? ( dev-lang/tk )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-config.h.patch
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-multilib.patch
	epatch "${FILESDIR}"/${P}-parallel-make.patch
	epatch "${FILESDIR}"/${P}-dynamic-lib.patch
	epatch "${FILESDIR}"/${P}-bootdir.patch
	epatch "${FILESDIR}"/${P}-chr.patch
	epatch "${FILESDIR}"/${P}-clpbn-examples.patch
	epatch "${FILESDIR}"/${P}-tkyap.patch

	eautoconf
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir) \
		--enable-cut-c \
		$(use_enable !static dynamic-loading) \
		$(use_enable threads) \
		$(use_enable threads pthread-locking) \
		$(use_enable debug debug-yap) \
		$(use_enable debug low-level-tracer) \
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

	if use doc ; then
		emake html || die "emake html failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."

	if use tk ; then
		exeinto /usr/bin
		doexe misc/tkyap
	fi

	dodoc changes*.html README

	if use doc ; then
		dodoc yap.html
	fi

	if use examples ; then
		docinto examples/clpbn
		dodoc CLPBN/clpbn/examples/*.yap
		docinto examples/clpbn/school
		dodoc CLPBN/clpbn/examples/School/*.yap
		if use mpi ; then
			docinto examples/mpi
			dodoc library/mpi/examples/*.pl
		fi
	fi
}
