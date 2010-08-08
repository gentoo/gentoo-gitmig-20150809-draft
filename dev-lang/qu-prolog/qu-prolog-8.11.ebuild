# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/qu-prolog/qu-prolog-8.11.ebuild,v 1.3 2010/08/08 03:25:30 phajdan.jr Exp $

EAPI=1

inherit eutils

MY_P=qp${PV}

DESCRIPTION="Qu-Prolog is an extended Prolog supporting quantifiers, object-variables and substitutions"
HOMEPAGE="http://www.itee.uq.edu.au/~pjr/HomePages/QuPrologHome.html"
SRC_URI="http://www.itee.uq.edu.au/~pjr/HomePages/QPFiles/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="debug doc examples pedro qt4 threads"

RDEPEND="!dev-util/mpatch
	!dev-util/rej
	qt4? ( x11-libs/qt-gui:4 )
	pedro? ( net-misc/pedro )"

DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-portage.patch
	epatch "${FILESDIR}"/${P}-print-atom.patch
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable threads multiple-threads) \
		|| die "econf failed"
	emake || die "emake failed"

	if use qt4; then
		cd "${S}"/src/xqp
		qmake || die "qmake xqp failed"
		emake || die "emake xqp failed"
	fi
}

src_install() {
	exeinto /usr/bin
	doexe bin/qa bin/qdeal bin/qem bin/ql
	doexe bin/qc bin/qc1.qup bin/qecat bin/qg bin/qp bin/qppp
	doexe bin/kq

	if use qt4; then
		doexe src/xqp/xqp
	fi

	insinto /usr/$(get_libdir)/${PN}/bin
	doins prolog/qc1/qc1.qx \
		prolog/qecat/qecat.qx \
		prolog/qg/qg.qx \
		prolog/qp/qp.qx

	insinto /usr/$(get_libdir)/${PN}/library
	doins prolog/library/*.qo

	insinto /usr/$(get_libdir)/${PN}/compiler
	doins prolog/compiler/*.qo

	doman doc/man/man1/*.1

	dodoc README

	if use doc ; then
		docinto reference-manual
		dodoc doc/manual/*.html
		docinto user-guide
		dodoc doc/user/main.pdf
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.ql
		docinto examples
		dodoc examples/README
	fi
}
