# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendqt/traitsbackendqt-3.0.3.ebuild,v 1.1 2009/01/15 10:11:26 bicatali Exp $

inherit distutils

MY_PN="TraitsBackendQt"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Qt4 backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/PyQt4"
DEPEND="dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"


src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
}
