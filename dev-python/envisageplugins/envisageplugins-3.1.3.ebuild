# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/envisageplugins/envisageplugins-3.1.3.ebuild,v 1.1 2010/10/18 14:38:00 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="EnvisagePlugins"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite plugins for the Envisage framework"
HOMEPAGE="http://code.enthought.com/projects/envisage_plugins.php http://pypi.python.org/pypi/EnvisagePlugins"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND=">=dev-python/envisagecore-3.1.3
	>=dev-python/traitsgui-3.5.0"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		dev-python/coverage
		>=dev-python/nose-0.10.3
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

src_test() {
	maketype="distutils_src_test" virtualmake
}

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die
	fi
}
