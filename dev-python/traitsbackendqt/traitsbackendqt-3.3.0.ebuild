# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traitsbackendqt/traitsbackendqt-3.3.0.ebuild,v 1.1 2010/03/23 05:17:41 bicatali Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="TraitsBackendQt"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Qt4 backend for Traits and TraitsGUI (Pyface)"
HOMEPAGE="http://code.enthought.com/projects/traits_gui"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/PyQt4[X]"
DEPEND="dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="enthought"

src_install() {
	find "${S}" -name \*LICENSE.txt -delete
	distutils_src_install
	dodoc docs/*.txt
}
