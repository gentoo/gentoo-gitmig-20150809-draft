# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <georges@its.caltech.edu>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-1.01.ebuild,v 1.2 2002/04/27 23:08:36 bangert Exp $


S="${WORKDIR}/${P}"
DESCRIPTION="A Perl module to manipulate/fetch info from MP3 files"
SRC_URI="http://prdownloads.sourceforge.net/mp3-info/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/mp3-info/"

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
	dodoc README
}
