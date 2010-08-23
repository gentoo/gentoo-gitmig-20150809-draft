# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysvg/pysvg-0.2.0.ebuild,v 1.3 2010/08/23 12:44:58 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit eutils distutils

MY_PN="pySVG"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python SVG document creation library"
HOMEPAGE="http://codeboje.de/pysvg/"
SRC_URI="http://www.codeboje.de/downloads/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_PN}"
