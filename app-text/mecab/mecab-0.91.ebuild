# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.91.ebuild,v 1.1 2006/05/16 13:47:38 hattya Exp $

IUSE="unicode"

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://mecab.sourceforge.jp/"
SRC_URI="http://prdownloads.sourceforge.jp/${PN}/20027/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"

DEPEND="dev-lang/perl"
PDEPEND="app-dicts/mecab-ipadic"

src_compile() {

	local myconf

	use unicode && myconf="${myconf} --with-charset=utf8"

	econf ${myconf} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc AUTHORS README || die
	dohtml doc/* || die

}
