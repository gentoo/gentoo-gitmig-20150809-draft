# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendqt/traitsbackendqt-3.5.0.ebuild,v 1.4 2011/01/07 16:00:36 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="TraitsBackendQt"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qt4 backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui http://pypi.python.org/pypi/TraitsBackendQt"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="dev-python/PyQt4[X]"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_install() {
	find "${S}" -name "*LICENSE.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
}
