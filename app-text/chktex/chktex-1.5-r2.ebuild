# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/chktex/chktex-1.5-r2.ebuild,v 1.3 2002/08/02 17:42:49 phoenix Exp $

S=${WORKDIR}/${P}
SRC_URI="http://www.ibiblio.org/pub/linux/distributions/gentoo/${P}.tar.gz"

HOMEPAGE="http://www.ifi.uio.no/~jensthi/chktex/ChkTeX.html"
SLOT="0"
DESCRIPTION="Checks latex source for common mistakes"

DEPEND="app-text/tetex
	sys-devel/ld.so
	sys-devel/perl
	sys-apps/groff
	app-text/latex2html"

LICENSE="GPL-2"
KEYWORDS="x86 PPC"
src_compile() {
    
    myconf="--prefix=/usr --host=${CHOST}"
    [ -n "$DEBUG" ] && myconf="$myconf --enable-debug-info" || myconf="$myconf --disable-debug-info"
    
    econf ${myconf} || die
    
    emake || die

}

src_install () {

    einstall || die
	dodoc COPYING SCOPTIONS

}
