# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.92.ebuild,v 1.3 2006/10/20 17:37:38 mcummings Exp $

IUSE="unicode"

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://mecab.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/20896/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

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
	dohtml doc/* || die

}
