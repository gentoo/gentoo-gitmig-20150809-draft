# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ttfquery/ttfquery-1.0.4.ebuild,v 1.2 2010/12/26 15:47:06 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="TTFQuery"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Font metadata and glyph outline extraction utility library"
HOMEPAGE="http://ttfquery.sourceforge.net/ http://pypi.python.org/pypi/TTFQuery"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-python/fonttools
	dev-python/numpy"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"
