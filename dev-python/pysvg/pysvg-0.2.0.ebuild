# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvg/pysvg-0.2.0.ebuild,v 1.2 2010/02/07 21:05:34 pva Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

MY_PN="pySVG"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python SVG document creation library"
HOMEPAGE="http://codeboje.de/pysvg/"
SRC_URI="http://www.codeboje.de/downloads/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_PN}"

pkg_postinst() {
	distutils_pkg_postinst

	ewarn "If you want to use pysvg to make a profit or in a corporate environment,"
	ewarn "then contact Kerim Mansour <kmansour@web.de>."
	ebeep 6
}
