# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mecab-python/mecab-python-0.98.ebuild,v 1.3 2012/03/28 07:41:54 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-*}/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=app-text/mecab-${PV}"
RDEPEND="${DEPEND}"

DOCS="test.py"
PYTHON_MODNAME="MeCab.py"

src_install() {
	distutils_src_install
	dohtml bindings.html || die
}
