# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cjkcodecs/cjkcodecs-1.0.ebuild,v 1.4 2005/01/31 02:25:23 fserb Exp $

inherit distutils

DESCRIPTION="Python Codecs for CJK Encodings. Aimed at replaced ChineseCodecs, JapaneseCodecs and KoreanCodecs"
SRC_URI="mirror://sourceforge/koco/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/koco"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND=">=dev-lang/python-2.1"
DOCS="doc/*"

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/tests
	doins tests/*
}
