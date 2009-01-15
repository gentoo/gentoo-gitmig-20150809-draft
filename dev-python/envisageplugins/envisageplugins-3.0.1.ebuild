# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisageplugins/envisageplugins-3.0.1.ebuild,v 1.2 2009/01/15 11:21:39 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="EnvisagePlugins"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite plugins for the Envisage framework"
HOMEPAGE="http://code.enthought.com/projects/envisage_plugins.php"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/apptools
	dev-python/envisagecore
	dev-python/traitsgui"

DEPEND="dev-python/setuptools
	test? ( >=dev-python/nose-0.10.3
			dev-python/apptools
			dev-python/enthoughtbase )"

# tests need an X display
RESTRICT=test
S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=build/lib ${python} setup.py test || die "tests failed"
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}
