# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.6_beta4.ebuild,v 1.1 2009/08/29 18:58:49 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

MY_P=${P/_beta/b}
DESCRIPTION="A Python package to parse and build CSS Cascading Style Sheets."
HOMEPAGE="http://code.google.com/p/cssutils"
SRC_URI="http://cssutils.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/setuptools-0.6_rc7-r1"
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="3*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-fix_setup.py.patch"
}

src_install() {
	distutils_src_install

	rm -fr "${D}"usr/lib*/python*/site-packages/tests
}
