# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.54.ebuild,v 1.5 2010/10/10 18:44:11 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Biopython - Python modules for computational molecular biology"
HOMEPAGE="http://www.biopython.org http://pypi.python.org/pypi/biopython"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE="mysql postgres"

RDEPEND="dev-python/numpy
	>=dev-python/reportlab-2.0
	mysql? ( dev-python/mysql-python )
	postgres? ( dev-python/psycopg )"
DEPEND="${RDEPEND}
	sys-devel/flex"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="CONTRIB DEPRECATED NEWS README"
PYTHON_MODNAME="Bio BioSQL"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-1.51-flex.patch"
}

src_test() {
	testing() {
		cd Tests
		PYTHONPATH="$(ls -d ../build/lib.*)" "$(PYTHON)" run_tests.py
	}
	python_execute_function --nonfatal -s testing
}

src_install() {
	distutils_src_install

	dodir "/usr/share/doc/${PF}"
	cp -r Doc/* "${D}/usr/share/doc/${PF}/" || \
			die "Failed to install documentation."
	dodir "/usr/share/${PN}"
	rm -f Tests/*.pyc || \
			die "Failed to remove precompiled test files."
	cp -r --preserve=mode Scripts Tests "${D}/usr/share/${PN}/" || \
			die "Failed to install shared files."
}
