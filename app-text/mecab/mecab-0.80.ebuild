# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.80.ebuild,v 1.1 2004/10/28 12:21:27 matsuu Exp $

# need one of ipadic-2.4.4/2.5.0/2.5.1 
MY_IPADIC="ipadic-2.5.1"

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://chasen.org/~taku/software/mecab/"
SRC_URI="http://chasen.org/~taku/software/mecab/src/${P}.tar.gz
	http://chasen.aist-nara.ac.jp/stable/ipadic/${MY_IPADIC}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="unicode"

DEPEND="virtual/libc
	dev-lang/perl"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}/dic
	unpack ${MY_IPADIC}.tar.gz
}

src_compile() {
	local myconf

	use unicode && myconf="${myconf} --with-charset=utf8"

	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
