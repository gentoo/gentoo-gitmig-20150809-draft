# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mecab-python/mecab-python-0.92.ebuild,v 1.2 2007/07/11 06:19:47 mr_bones_ Exp $

inherit distutils

DESCRIPTION="Python Bindings for MeCab"
HOMEPAGE="http://mecab.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/mecab/20900/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-text/mecab-${PV}"

DOCS="test.py"

src_test() {
	python test.py || die "test.py failed"
}

src_install() {
	DOCS="test.py"
	distutils_src_install
	dohtml bindings.html || die "dohtml failed"
}
