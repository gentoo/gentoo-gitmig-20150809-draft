# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mecab/mecab-0.81.ebuild,v 1.1 2005/05/22 15:50:53 usata Exp $

inherit eutils

# need one of ipadic-2.4.4/2.5.0/2.5.1 
MY_IPADIC="ipadic-2.5.1"

DESCRIPTION="Yet Another Part-of-Speech and Morphological Analyzer"
HOMEPAGE="http://chasen.org/~taku/software/mecab/"
SRC_URI="http://chasen.org/~taku/software/mecab/src/${P}.tar.gz
	http://chasen.naist.jp/stable/ipadic/${MY_IPADIC}.tar.gz
	http://chasen.naist.jp/stable/ipadic/${MY_IPADIC}.1.diff"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~ppc64"
IUSE="unicode"

DEPEND="dev-lang/perl"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}/dic
	unpack ${MY_IPADIC}.tar.gz
	epatch ${DISTDIR}/${MY_IPADIC}.1.diff
}

src_compile() {
	econf $(use_with unicode charset utf8) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
