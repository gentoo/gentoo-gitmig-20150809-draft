# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/aria/aria-2.2_p2.ebuild,v 1.1 2010/02/06 21:50:40 jlec Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS="1"
PYTHON_USE_WITH="tk"

inherit base python eutils versionator

MY_P="${PN}$(get_version_component_range 1-2 ${PV})"

DESCRIPTION="Software for automated NOE assignment and NMR structure calculation."
HOMEPAGE="http://aria.pasteur.fr/"
SRC_URI="http://aria.pasteur.fr/archives/${MY_P}.tar.gz"

SLOT="0"
LICENSE="cns"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="
	dev-python/numpy
	dev-python/matplotlib[tk]
	sci-chemistry/cns[aria,openmp]
	>=dev-lang/tk-8.3
	>=dev-python/scientificpython-2.7.3
	>=sci-chemistry/ccpn-2.0.5
	>=dev-tcltk/tix-8.1.4"
DEPEND="${RDEPENED}"
RESTRICT_PYTHON_ABIS="3.*"

RESTRICT="fetch"

S="${WORKDIR}/${PN}2.2"

src_prepare() {
	epatch "${FILESDIR}"/sa_ls_cool2.patch
	epatch "${FILESDIR}"/${PV}-numpy.patch
	epatch "${FILESDIR}"/${PV}-test.patch
	python_copy_sources --no-link
}

pkg_nofetch(){
	einfo "Go to ${HOMEPAGE}, download ${A}"
	einfo "and place it in ${DISTDIR}"
}

src_test(){
	test() {
		export CCPNMR_TOP_DIR="${EPREFIX}"/$(python_get_sitedir)
		export PYTHONPATH=.:${CCPNMR_TOP_DIR}/ccpn/python
		$(PYTHON) check.py || die
	}
	python_execute_function -s test
}

src_install(){
	installation() {
		insinto "$(python_get_sitedir)/${PN}"
		doins -r src aria2.py || die "failed to install ${PN}"
		insinto "$(python_get_sitedir)/${PN}"/cns
		doins -r cns/{protocols,toppar,src/helplib} || die "failed to install cns part"
	}
	python_execute_function -s installation

	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples
	fi

	# ENV
	cat >> "${T}"/20aria <<- EOF
	ARIA2="${EPREFIX}/$(python_get_sitedir -f)/${PN}"
	EOF

	doenvd "${T}"/20aria

	# Launch Wrapper
	cat >> "${T}"/aria <<- EOF
	#!/bin/sh
	export CCPNMR_TOP_DIR="${EPREFIX}/$(python_get_sitedir -f)"
	export PYTHONPATH="${EPREFIX}/$(python_get_sitedir -f)/ccpn/python"
	exec "$(PYTHON -f)" -O "\${ARIA2}"/aria2.py \$@
	EOF

	dobin "${T}"/aria || die "failed to install wrapper"
	dosym aria /usr/bin/aria2

	dodoc README || die
}
