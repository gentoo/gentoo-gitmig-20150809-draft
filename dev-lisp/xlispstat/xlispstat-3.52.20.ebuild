# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/xlispstat/xlispstat-3.52.20.ebuild,v 1.1 2003/12/21 06:02:30 mkennedy Exp $

DESCRIPTION="XLISP-STAT is a statistical environment based on a dialect of the Lisp language called XLISP."
HOMEPAGE="http://www.stat.uiowa.edu/~luke/xls/xlsinfo/xlsinfo.html"
SRC_URI="ftp://ftp.stat.umn.edu/pub/xlispstat/current/xlispstat-${PV//./-}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
DEPEND="X? ( virtual/x11 )"

S=${WORKDIR}/${P//./-}

src_compile() {
	local opts=''
	use X && opts='--with-x' || opts='--without-x'
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${opts} || die "./configure failed"
	make UCFLAGS="${CFLAGS} -mieee-fp" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/lib/xlispstat
	make prefix=${D}/usr/ install || die
	dodoc COPYING INSTALL README* RELEASE
	dodoc doc/xlispins.doc doc/xlispdoc.{ps,txt}
}
