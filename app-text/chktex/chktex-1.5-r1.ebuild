# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/chktex/chktex-1.5-r1.ebuild,v 1.2 2002/07/16 03:42:10 owen Exp $

S=${WORKDIR}/${P}
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/${P}.tar.gz"

HOMEPAGE="http://www.ifi.uio.no/~jensthi/chktex/ChkTeX.html"
DESCRIPTION="Checks latex source for common mistakes"

DEPEND="app-text/tetex
	virtual/glibc
	sys-devel/ld.so
	sys-devel/perl
	sys-apps/groff
	app-text/latex2html"

KEYWORDS="x86 ppc"

src_compile() {
    
    myconf="--prefix=/usr --host=${CHOST}"
    [ -n "$DEBUG" ] && myconf="$myconf --enable-debug-info" || myconf="$myconf --disable-debug-info"
    
    ./configure ${myconf} || die
    
    emake || die

}

src_install () {

    make prefix=${D}/usr install || die

}

