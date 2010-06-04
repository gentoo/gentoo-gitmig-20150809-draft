# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fann/fann-2.1.0_beta.ebuild,v 1.4 2010/06/04 15:32:47 arfrever Exp $

EAPI=2
inherit eutils python autotools

MY_P=${P/_/}
DESCRIPTION="Fast Artificial Neural Network Library"
HOMEPAGE="http://leenissen.dk/fann/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc python"

RDEPEND="python? ( virtual/python )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	app-arch/unzip"

S="${WORKDIR}/${P/_beta/}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-python.patch
	epatch "${FILESDIR}"/${P}-benchmark.patch
	epatch "${FILESDIR}"/${P}-examples.patch
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_compile() {
	emake || die "emake failed"
	if use python; then
		cd "${S}"/python
		emake PYTHON_VERSION="$(python_get_version)" || die "emake python failed"
	fi
}

src_test() {
	cd "${S}"/examples
	emake CFLAGS="${CFLAGS} -I../src/include -L../src/.libs" \
		|| die "emake examples failed"
	LD_LIBRARY_PATH="../src/.libs" emake runtest || die "tests failed"
	emake clean
	if use python; then
		cd "${S}"/python
		emake test || die "failed tests for python wrappers"
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		dodoc doc/*.txt
		insinto /usr/share/doc/${PF}
		doins doc/fann_en.pdf || die "failed to install reference manual"
		doins -r examples || die "failed to install examples"
		doins -r benchmarks || die "failed to install benchmarks"
	fi

	if use python; then
		cd "${S}"/python
		emake install ROOT="${D}" || die "failed to install python wrappers"
		if use doc; then
			insinto /usr/share/doc/${PF}/examples/python
			doins -r examples || die "failed to install python examples"
		fi
	fi
}
