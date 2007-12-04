# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-dsv/python-dsv-1.4.0-r1.ebuild,v 1.1 2007/12/04 08:34:03 hawking Exp $

inherit distutils eutils

DESCRIPTION="Python module for importing and exporting DSV files"
HOMEPAGE="http://python-dsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/DSV-${PV}.tar.gz"

LICENSE="CNRI"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-python/wxpython-2.6*"

S="${WORKDIR}/DSV-${PV}"

src_unpack() {
	distutils_src_unpack
	epatch "${FILESDIR}"/${P}-wxversion.patch
}
