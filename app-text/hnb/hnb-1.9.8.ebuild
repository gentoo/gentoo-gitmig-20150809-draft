# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/${P}
DESCRIPTION="hnb is a program to organize many kinds of data in one place, including addresses, TODO lists, ideas, book reviews, brainstorming, speech outlines, etc. It stores data in XML format, and is capable of native export to ASCII and HTML."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://hnb.sourceforge.net/"

SLOT="0"
LICENSE="GPL-1"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=""

src_compile() {

	make || die	

}

src_install() {
	
	dodoc README doc/hnbrc
	doman doc/hnb.1
	dobin src/hnb

}
