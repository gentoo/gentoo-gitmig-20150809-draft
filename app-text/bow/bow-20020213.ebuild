# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bow/bow-20020213.ebuild,v 1.1 2003/06/19 09:26:36 pvdabeel Exp $

DESCRIPTION="Bag of words library - Statistical language modeling, text retrieval, Classification and clustering"
HOMEPAGE="http://www-2.cs.cmu.edu/~mccallum/bow/"
SRC_URI="http://www-2.cs.cmu.edu/~mccallum/bow/src/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}

src_compile() {
	econf --prefix=${D}/usr --datadir=${D}/usr/share || die
}

src_install() {
	make prefix=${D}/usr install
}
