# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <georges@its.caltech.edu>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp


S="${WORKDIR}/${P}"
DESCRIPTION="Read the CDDB entry for an audio CD in your drive"
SRC_URI="http://armin.emx.at/cddb/${P}.tar.gz"
HOMEPAGE="http://armin.emx.at/cddb/"

DEPEND=""
RDEPEND="sys-devel/perl"


src_compile() {
	perl Makefile.PL && make || die 
}

src_install () {
    make \
    PREFIX=${D}/usr \
    INSTALLMAN3DIR=${D}/usr/share/man/man3 \
    INSTALLMAN1DIR=${D}/usr/share/man/man1 \
    install || die
	# Install documentation.
	dodoc Changes Copying README
}
