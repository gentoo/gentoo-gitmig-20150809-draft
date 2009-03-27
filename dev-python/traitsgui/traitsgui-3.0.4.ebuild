# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsgui/traitsgui-3.0.4.ebuild,v 1.1 2009/03/27 10:49:37 bicatali Exp $

EAPI=2
inherit distutils

MY_PN="TraitsGUI"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Traits-capable windowing framework"
HOMEPAGE="http://code.enthought.com/projects/traits_gui"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples qt4 test wxwindows"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND=">=dev-python/traits-3.1
	qt4? ( >=dev-python/traitsbackendqt-3.1 )
	wxwindows? ( >=dev-python/traitsbackendwx-3.1 )
	!wxwindows? ( !qt4? ( >=dev-python/traitsbackendwx-3.1 ) )"

DEPEND="dev-python/setuptools"
# test needs X display
#	test? ( >=dev-python/nose-0.10.3
#			>=dev-python/traitsbackendwx-3.1 )
RESTRICT=test

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	sed -i -e "/self.run_command('build_docs')/d" setup.py || die
}

src_test() {
	PYTHONPATH=build/lib "${python}" setup.py test || die "tests failed"
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
