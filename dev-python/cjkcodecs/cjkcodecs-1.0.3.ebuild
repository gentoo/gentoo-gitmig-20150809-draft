# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cjkcodecs/cjkcodecs-1.0.3.ebuild,v 1.5 2005/01/31 02:25:23 fserb Exp $

inherit distutils

DESCRIPTION="Python Codecs for CJK Encodings. Aimed at replacing ChineseCodecs, JapaneseCodecs and KoreanCodecs"
SRC_URI="http://download.berlios.de/cjkpython/${P}.tar.bz2"
HOMEPAGE="http://cjkpython.i18n.org/"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~ppc ~x86 ppc64"

DEPEND=">=dev-lang/python-2.1"
DOCS="doc/*"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/tests
	doins tests/*
}
