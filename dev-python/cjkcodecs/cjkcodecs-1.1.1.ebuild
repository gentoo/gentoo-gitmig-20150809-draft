# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cjkcodecs/cjkcodecs-1.1.1.ebuild,v 1.1 2004/10/06 08:10:07 usata Exp $

inherit distutils

DESCRIPTION="Python Codecs for CJK Encodings. Aimed at replacing ChineseCodecs, JapaneseCodecs and KoreanCodecs"
SRC_URI="http://download.berlios.de/cjkpython/${P}.tar.bz2"
HOMEPAGE="http://cjkpython.i18n.org/"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~ppc ~x86 ~ppc64"

DEPEND=">=dev-lang/python-2.1"
DOCS="doc/*"

src_test() {
	cd tests
	python testall.py || die "testall.py failed"
}
