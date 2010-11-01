# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyid3lib/pyid3lib-0.5.1-r1.ebuild,v 1.9 2010/11/01 00:20:19 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Module for manipulating ID3 tags in Python"
HOMEPAGE="http://pyid3lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/id3lib"
RDEPEND="${DEPEND}"

PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	epatch "${FILESDIR}/${P}-gcc-4.4.patch"
	epatch "${FILESDIR}/${P}-py25.patch"
}

src_install() {
	distutils_src_install
	dohtml doc.html || die "dohtml failed"
}
