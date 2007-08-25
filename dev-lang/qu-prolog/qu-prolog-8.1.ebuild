# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/qu-prolog/qu-prolog-8.1.ebuild,v 1.1 2007/08/25 22:07:35 keri Exp $

inherit eutils

MY_P=qp${PV}

DESCRIPTION="Qu-Prolog is an extended Prolog supporting quantifiers, object-variables and substitutions"
HOMEPAGE="http://www.itee.uq.edu.au/~pjr/HomePages/QuPrologHome.html"
SRC_URI="http://www.itee.uq.edu.au/~pjr/HomePages/QPFiles/qp8.1.tar.gz
	qt4? ( mirror://gentoo/qu-prolog-8.1-xqp-qt4.tar.gz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="debug doc examples qt3 qt4 threads"

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
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable threads multiple-threads) \
		|| die "econf failed"
	emake || die "emake failed"

	if use qt4; then
		cd "${S}"/src/xqp/qt4
		qmake || die "qmake xqp failed"
		emake || die "emake xqp failed"
	elif use qt3; then
		cd "${S}"/src/xqp
		"${QTDIR}"/bin/qmake || die "qmake xqp failed"
		emake || die "emake xqp failed"
	fi
}

src_install() {
	exeinto /usr/bin
	doexe src/qa src/qdeal src/qem src/ql
	doexe bin/qc bin/qc1.qup bin/qecat bin/qg bin/qp bin/qppp

	if use qt4; then
		doexe src/xqp/qt4/xqp
	elif use qt3; then
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
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.ql
		docinto examples
		dodoc examples/README
	fi
}
