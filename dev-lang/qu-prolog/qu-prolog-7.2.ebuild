# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/qu-prolog/qu-prolog-7.2.ebuild,v 1.1 2006/04/07 20:56:23 keri Exp $

inherit eutils flag-o-matic

MY_P=qp${PV}

DESCRIPTION="Qu-Prolog is an extended Prolog supporting quantifiers, object-variables and substitutions"
HOMEPAGE="http://www.itee.uq.edu.au/~pjr/HomePages/QuPrologHome.html"
SRC_URI="http://www.itee.uq.edu.au/~pjr/HomePages/QPFiles/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="doc qt threads"

DEPEND="qt? ( =x11-libs/qt-3* )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
	epatch "${FILESDIR}"/${P}-CXXFLAGS.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch

	sed -i -e "s:head -1:head -n 1:" configure
}

src_compile() {
	append-flags -fno-strict-aliasing

	econf \
		$(use_enable threads multiple-threads) \
		|| die "econf failed"
	emake || die "emake failed"

	if use qt ; then
		cd "${S}"/src/xqp
		"${QTDIR}"/bin/qmake || die "qmake xqp failed"
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

	dodoc INSTALL README

	if use doc ; then
		docinto reference-manual
		dodoc doc/manual/*.html
		docinto user-guide
		dodoc doc/user/main.ps
		docinto examples
		dodoc examples/*.ql examples/README
	fi
}
