# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Paul Belt <gaarde@yahoo.com> 
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccache/ccache-1.8.ebuild,v 1.1 2002/05/01 05:56:02 rphillips Exp $

DESCRIPTION="ccache is a fast compiler cache. It is used as a front end to your
compiler to safely cache compilation output. When the same code is compiled
again the cached output is used giving a significant speedup."
SRC_URI="http://ccache.samba.org/ftp/ccache/${P}.tar.gz"
HOMEPAGE="http://ccache.samba.org/"

src_compile() {
	./configure \
		--prefix=${D}/usr || die
	make || die
}

src_install () {
	dobin ccache
	doman ccache.1
	dodoc COPYING README    
}
