# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MP3-Info/MP3-Info-1.01.ebuild,v 1.5 2002/07/25 04:13:26 seemant Exp $


S="${WORKDIR}/${P}"
DESCRIPTION="A Perl module to manipulate/fetch info from MP3 files"
SRC_URI="mirror://sourceforge/mp3-info/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://sourceforge.net/projects/mp3-info/"

SLOT="0"
DEPEND=""
RSLOT="0"
DEPEND="sys-devel/perl"


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
