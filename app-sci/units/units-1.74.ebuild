# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $ Header: $

S=${WORKDIR}/${P}

DESCRIPTION="Units is a program for units conversion and units calculation."

SRC_URI="ftp://ftp.gnu.org/gnu/units/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/units/units.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=sys-libs/readline-4.1-r2
		>=sys-libs/ncurses-5.2-r3"


src_compile() {
    
#Note: the trailing / is required in the datadir path.
	./configure --infodir=/usr/share/info \
				--mandir=/usr/share/man \
				--datadir=/usr/share/${PN}/ \
				--prefix=/usr \
				--host=${CHOST} || die "./configure failed"
	
	emake || die

}

src_install () {
	
#Note: the trailing / is required in the datadir path.
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share/${PN}/ \
		install || die
	
dodoc COPYING ChangeLog INSTALL NEWS README 

}

