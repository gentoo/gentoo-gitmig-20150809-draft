# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cjkcodecs/cjkcodecs-1.0.ebuild,v 1.3 2004/06/25 01:27:28 agriffis Exp $

inherit distutils

DESCRIPTION="Python Codecs for CJK Encodings. Aimed at replaced ChineseCodecs, JapaneseCodecs and KoreanCodecs"
SRC_URI="mirror://sourceforge/koco/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/koco"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.1"
DOCS="doc/*"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/tests
	doins tests/*
}
