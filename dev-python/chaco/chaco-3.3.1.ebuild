# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-3.3.1.ebuild,v 1.2 2010/07/07 16:09:39 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="Chaco"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco http://pypi.python.org/pypi/Chaco"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/enable-3.3.1
	>=dev-python/enthoughtbase-3.0.5
	dev-python/numpy"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/setupdocs )
	test? (
		dev-python/coverage
		>=dev-python/nose-0.10.3
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="enthought"

src_prepare() {
	# "${S}/enthought/chaco2/tests does not exist.
	sed -e "s:,enthought/chaco2/tests::" -i setup.cfg || die "sed setup.cfg failed"

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_docs --formats=html,pdf || die "Generation of documentation failed"
	fi
}

src_test() {
	maketype="distutils_src_test" virtualmake
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
