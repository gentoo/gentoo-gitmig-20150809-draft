# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.52.ebuild,v 1.2 2009/10/31 17:56:54 maekke Exp $

EAPI="2"

NEED_PYTHON=2.4
inherit distutils eutils base

DESCRIPTION="Biopython - Python modules for computational molecular biology"
LICENSE="as-is"
HOMEPAGE="http://www.biopython.org"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"

SLOT="0"
IUSE="mysql postgres"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"

DEPEND="dev-python/numpy
	>=dev-python/reportlab-2.0
	sys-devel/flex"

RDEPEND="${DEPEND}
	mysql? ( dev-python/mysql-python )
	postgres? ( dev-python/psycopg )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.51-flex.patch
)

src_compile() {
	distutils_src_compile
}

src_install() {
	DOCS="CONTRIB DEPRECATED NEWS README"
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

src_test() {
	cd "${S}/Tests"
	PYTHONPATH="${PYTHONPATH}:${S}" \
			python run_tests.py --no-gui || die "Tests failed."
}
