# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traits/traits-3.5.0.ebuild,v 1.2 2010/12/05 20:24:15 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Traits"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite explicitly typed attributes for Python"
HOMEPAGE="http://code.enthought.com/projects/traits http://pypi.python.org/pypi/Traits"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/numpy-1.1
	>=dev-python/enthoughtbase-3.0.6"
DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )
	test? (
		>=dev-python/nose-0.10.3
		>=dev-python/numpy-1.1
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_docs --formats=html || die "Generation of documentation failed"
	fi
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		doins docs/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
