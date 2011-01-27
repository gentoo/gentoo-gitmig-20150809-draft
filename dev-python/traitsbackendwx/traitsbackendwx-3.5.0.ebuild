# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendwx/traitsbackendwx-3.5.0.ebuild,v 1.5 2011/01/27 10:01:57 hwoarang Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="TraitsBackendWX"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WxPython backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui http://pypi.python.org/pypi/TraitsBackendWX"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-python/wxpython:2.8"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
}
