# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xpm/xpm-3.4k-r1.ebuild,v 1.4 2002/10/04 05:51:02 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="XPM image library"
SRC_URI="ftp://ftp.x.org/contrib/libraries/xpm-3.4k.tar.gz"
HOMEPAGE="http://koala.ilog.fr/lehors/xpm.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/x11"

src_compile() {
	
	xmkmf -a
    emake CDEBUGFLAGS="${CFLAGS} -fno-strength-reduce" || die
}

src_install() {

    make DESTDIR=${D} install
	make install.sdk

	doman cxpm/cxpm.man sxpm/sxpm.man
	dohtml -r ./
	dodoc CHANGES COPYRIGHT FILES README.{AMIGA,MSW}
}
