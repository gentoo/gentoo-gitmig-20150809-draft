# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/xpm/xpm-3.4k.ebuild,v 1.1 2002/03/16 18:02:31 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XPM image library"
SRC_URI="ftp://ftp.x.org/contrib/libraries/xpm-3.4k.tar.gz"
HOMEPAGE="http://koala.ilog.fr/lehors/xpm.html"

DEPEND="virtual/glibc
	virtual/xfree"

src_compile() {
	
	xmkmf -a
    emake || die
}

src_install() {

    make DESTDIR=${D} install
	make install.sdk

	doman cxpm/cxpm.man sxpm/sxpm.man
	dohtml cxpm/cxpm.1x.html sxpm/sxpm.1x.html FAQ.html
	dodoc CHANGES COPYRIGHT FILES README*
}

