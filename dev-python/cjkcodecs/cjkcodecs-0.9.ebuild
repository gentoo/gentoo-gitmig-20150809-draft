# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cjkcodecs/cjkcodecs-0.9.ebuild,v 1.1 2003/06/27 23:46:01 liquidx Exp $

inherit distutils

DESCRIPTION="Python Codecs for CJK Encodings. Aimed at replaced ChineseCodecs, JapaneseCodecs and KoreanCodecs"
SRC_URI="mirror://sourceforge/koco/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/koco"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"

DEPEND=">=dev-lang/python-2.1"
DOCS="doc/*"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/tests
	doins tests/*
}
