# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xpm/xpm-3.4k.ebuild,v 1.7 2002/12/09 04:26:14 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XPM image library"
SRC_URI="ftp://ftp.x.org/contrib/libraries/xpm-3.4k.tar.gz"
HOMEPAGE="http://koala.ilog.fr/lehors/xpm.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11"

src_compile() {
	
	xmkmf -a
    emake || die
}

src_install() {

    make DESTDIR=${D} install
	make install.sdk

	doman cxpm/cxpm.man sxpm/sxpm.man
	dohtml -r ./
	dodoc CHANGES COPYRIGHT FILES README.{AMIGA,MSW}
}
