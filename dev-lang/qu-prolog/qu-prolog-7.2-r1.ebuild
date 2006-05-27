# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/qu-prolog/qu-prolog-7.2-r1.ebuild,v 1.2 2006/05/27 08:05:28 keri Exp $

inherit autotools eutils versionator

MY_P=qp${PV}

DESCRIPTION="Qu-Prolog is an extended Prolog supporting quantifiers, object-variables and substitutions"
HOMEPAGE="http://www.itee.uq.edu.au/~pjr/HomePages/QuPrologHome.html"
SRC_URI="http://www.itee.uq.edu.au/~pjr/HomePages/QPFiles/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug doc qt threads"

DEPEND="qt? ( x11-libs/qt )"

S="${WORKDIR}"/${MY_P}

get_qt_ver() {
	qt_ver="$(best_version x11-libs/qt)"
	qt_ver=${qt_ver//*qt-}
	qt_ver=${qt_ver//-*}
	qt_ver=$(get_major_version ${qt_ver})
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-debug.patch

	get_qt_ver
	[[ ${qt_ver} -eq 4 ]] && epatch "${FILESDIR}"/${P}-qt4.patch
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

	if use qt ; then
		cd "${S}"/src/xqp
		if [ ${qt_ver} -eq 4 ] ; then \
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
	doexe bin/qc bin/qecat bin/qp bin/qppp

	use qt && doexe src/xqp/xqp

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
