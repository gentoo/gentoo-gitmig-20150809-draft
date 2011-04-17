# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pymol-plugins-dssp/pymol-plugins-dssp-110413.ebuild,v 1.1 2011/04/17 13:53:29 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit python

DESCRIPTION="DSSP Plugin for PyMOL"
HOMEPAGE="http://www.biotec.tu-dresden.de/~hongboz/dssp_pymol/dssp_pymol.html"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.py.xz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD pymol"
IUSE=""

RDEPEND="
	>=sci-biology/biopython-1.5.7
	sci-chemistry/dssp
	sci-chemistry/pymol"
DEPEND=""

src_prepare() {
	sed \
		-e "s:GENTOO_DSSP:${EPREFIX}/usr/bin/dssp:g" \
		-i ${P}.py || die
}

src_install() {
	installation() {
		insinto $(python_get_sitedir)/pmg_tk/startup
		doins ${P}.py
	}
	python_execute_function installation
}

pkg_postinst() {
	python_mod_optimize pmg_tk/startup/${P}.py
}

pkg_postrm() {
	python_mod_cleanup pmg_tk/startup/${P}.py
}
