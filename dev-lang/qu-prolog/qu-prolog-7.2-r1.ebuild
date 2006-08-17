# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/qu-prolog/qu-prolog-7.2-r1.ebuild,v 1.7 2006/08/17 04:21:16 tsunam Exp $

inherit autotools eutils versionator

MY_P=qp${PV}

DESCRIPTION="Qu-Prolog is an extended Prolog supporting quantifiers, object-variables and substitutions"
HOMEPAGE="http://www.itee.uq.edu.au/~pjr/HomePages/QuPrologHome.html"
SRC_URI="http://www.itee.uq.edu.au/~pjr/HomePages/QPFiles/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="debug doc qt3 qt4 threads"

DEPEND="qt3? ( =x11-libs/qt-3* )
	qt4? ( >=x11-libs/qt-4.1.0 )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-debug.patch

	use qt4 && epatch "${FILESDIR}"/${P}-qt4.patch
}

src_compile() {
	eautoconf
	econf \
		--disable-elvin \
		--disable-icm \
		$(use_enable debug) \
		$(use_enable threads multiple-threads) \
		|| die "econf failed"
	emake || die "emake failed"

	if use qt3 || use qt4; then
		cd "${S}"/src/xqp
		if use qt4; then
			qmake || die "qmake xqp failed"
		else
			"${QTDIR}"/bin/qmake || die "qmake xqp failed"
		fi
		emake || die "emake xqp failed"
	fi
}

src_install() {
	exeinto /usr/bin
	doexe src/qa src/qdeal src/qem src/ql
	doexe bin/qc bin/qc1.qup bin/qecat bin/qg bin/qp bin/qppp

	if use qt3 || use qt4; then
		doexe src/xqp/xqp
	fi

	insinto /usr/lib/${PN}/bin
	doins prolog/qc1/qc1.qx \
		prolog/qecat/qecat.qx \
		prolog/qg/qg.qx \
		prolog/qp/qp.qx

	insinto /usr/lib/${PN}/library
	doins prolog/library/*.qo

	insinto /usr/lib/${PN}/compiler
	doins prolog/compiler/*.qo

	doman doc/man/man1/*.1

	dodoc README

	if use doc ; then
		docinto reference-manual
		dodoc doc/manual/*.html
		docinto user-guide
		dodoc doc/user/main.ps
		docinto examples
		dodoc examples/*.ql examples/README
	fi
}
