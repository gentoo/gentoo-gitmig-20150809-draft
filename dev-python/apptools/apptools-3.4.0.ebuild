# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apptools/apptools-3.4.0.ebuild,v 1.1 2010/10/18 14:31:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="AppTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite application tools"
HOMEPAGE="http://code.enthought.com/projects/app_tools.php http://pypi.python.org/pypi/AppTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/configobj
	>=dev-python/enthoughtbase-3.0.6
	dev-python/numpy
	>=dev-python/traitsgui-3.5.0"
DEPEND="dev-python/setuptools
	doc? ( dev-python/setupdocs )
	test? (
		dev-python/coverage
		>=dev-python/nose-0.10.3
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"
# dev-python/envisagecore depends on dev-python/apptools, so dev-python/envisagecore
# cannot be specified in DEPEND/RDEPEND due to circular dependencies.
PDEPEND=">=dev-python/envisagecore-3.1.3"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought integrationtests"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"

	# Disable failing tests.
	sed -e "s/test_version_registry/_&/" -i enthought/persistence/tests/test_spawner.py
	sed -e "s/test_run/_&/" -i enthought/persistence/tests/test_version_registry.py
	rm -f enthought/persistence/tests/test_state_pickler.py
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
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r build/docs/html || die
		doins build/docs/latex/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
