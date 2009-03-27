# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisageplugins/envisageplugins-3.1.0.ebuild,v 1.1 2009/03/27 10:40:37 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="EnvisagePlugins"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Enthought Tool Suite plugins for the Envisage framework"
HOMEPAGE="http://code.enthought.com/projects/envisage_plugins.php"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/envisagecore-3.1
	>=dev-python/traitsgui-3.0.4"

DEPEND="dev-python/setuptools"
# tests need an X display
#	test? ( >=dev-python/nose-0.10.3
#			>=dev-python/enthoughtbase-3.0.2 )"
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
