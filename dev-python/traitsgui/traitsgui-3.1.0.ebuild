# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsgui/traitsgui-3.1.0.ebuild,v 1.2 2009/09/05 22:55:20 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="TraitsGUI"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Traits-capable windowing framework"
HOMEPAGE="http://code.enthought.com/projects/traits_gui"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples qt4 wxwidgets"
#IUSE="doc examples qt4 test wxwidgets"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/traits-3.2.0
	qt4? ( >=dev-python/traitsbackendqt-3.2.0 )
	wxwidgets? ( >=dev-python/traitsbackendwx-3.2.0 )
	!wxwidgets? ( !qt4? ( >=dev-python/traitsbackendwx-3.2.0 ) )"
DEPEND="dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"
# test needs X display
#	test? ( >=dev-python/nose-0.10.3
#			>=dev-python/traitsbackendwx-3.2.0 )
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

DOCS="CHANGELOG.txt"

src_prepare() {
	sed -i -e "s/self.run_command('build_docs')/pass/" setup.py || die
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" test
	}
	python_execute_function testing
}

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r docs/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
}
