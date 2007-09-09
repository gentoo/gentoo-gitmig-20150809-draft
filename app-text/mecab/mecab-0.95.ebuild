# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.95.ebuild,v 1.4 2007/09/09 10:22:45 hattya Exp $

IUSE="unicode"

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 sparc x86"
SLOT="0"
RESTRICT="test"

DEPEND="dev-lang/perl"
PDEPEND=">=app-dicts/mecab-ipadic-2.7.0.20060707"

src_compile() {

	local myconf

	use unicode && myconf="${myconf} --with-charset=utf8"

	econf ${myconf} || die
	emake || die

}

src_install() {

	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README || die
	dohtml -r doc || die

}
