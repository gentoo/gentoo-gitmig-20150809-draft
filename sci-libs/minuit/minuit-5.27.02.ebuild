# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/minuit/minuit-5.27.02.ebuild,v 1.4 2010/11/14 16:26:19 jlec Exp $

EAPI=2
inherit autotools eutils toolchain-funcs

MY_PN=Minuit2

DESCRIPTION="A C++ physics analysis tool for function minimization"
HOMEPAGE="http://seal.web.cern.ch/seal/MathLibs/Minuit2/html/index.html"

SRC_URI="http://seal.web.cern.ch/seal/MathLibs/${MY_PN}/${MY_PN}-${PV}.tar.gz
	doc? ( http://seal.cern.ch/documents/minuit/mnusersguide.pdf
		   http://seal.cern.ch/documents/minuit/mntutorial.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc openmp"
DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	if use openmp && ! tc-has-openmp; then
		ewarn "You are using gcc built without openmp"
		ewarn "Switch CXX to an OpenMP capable compiler"
		die "Need openmp"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	rm config/m4/ac_openmp.m4
	AT_M4DIR="config/m4" eautoreconf
}

src_configure() {
	econf $(use_enable openmp)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		emake docs || die "emake docs failed"
	fi
}

src_test() {
	emake check || die "emake check failed"
	# make check only compiles the tests. run them
	for d in test/Mn*; do
		cd "${S}"/${d}
		for t in test_*; do
			./${t} || die "${t} failed"
		done
	done
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto /usr/share/doc/${PF}/MnTutorial
	doins test/MnTutorial/*.{h,cxx}
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}"/mn*.pdf || die "doins failed"
		dohtml -r doc/html/* || die "dohtml failed"
	fi
}
