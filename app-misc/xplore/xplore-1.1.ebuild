# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/xplore/xplore-1.1.ebuild,v 1.2 2002/07/11 06:30:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="motif file manager for X."
SRC_URI="http://www.musikwissenschaft.uni-mainz.de/~ag/xplore/${P}.tar.bz2"
HOMEPAGE="http://www.musikwissenschaft.uni-mainz.de/~ag/xplore/"
DEPEND="virtual/x11"

#RDEPEND=""

src_compile() {

	xmkmf -a || die
   make || die
	
}

src_install () {
	
	# try make prefix=${D}/usr install

    try make DESTDIR=${D} install
	 dodoc README INSTALL ChangeLog  
}

