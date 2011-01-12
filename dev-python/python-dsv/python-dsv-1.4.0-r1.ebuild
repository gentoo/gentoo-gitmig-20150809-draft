# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dsv/python-dsv-1.4.0-r1.ebuild,v 1.2 2011/01/12 14:57:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Python module for importing and exporting DSV files"
HOMEPAGE="http://python-dsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/DSV-${PV}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/wxpython:2.6"
RDEPEND="${DEPEND}"

S="${WORKDIR}/DSV-${PV}"

PYTHON_MODNAME="DSV"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-wxversion.patch"
}
