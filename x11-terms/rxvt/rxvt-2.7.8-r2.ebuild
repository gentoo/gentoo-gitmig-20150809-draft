# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.7.8-r2.ebuild,v 1.4 2002/09/21 04:29:03 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rxvt -- nice small x11 terminal"
SRC_URI="ftp://ftp.rxvt.org/pub/rxvt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

HOMEPAGE="http://www.rxvt.org"

DEPEND="virtual/glibc
	virtual/x11"


src_compile() {
	./configure \
		--host=${CHOST}	\
		--prefix=/usr \
		--mandir=/usr/share/man	\
		--enable-rxvt-scroll \
		--enable-transparency \
		--enable-xpm-background \
		--enable-utmp \
		--enable-wtmp \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-smart-resize \
		--enable-menubar \
		--enable-shared \
		--enable-keepscrolling || die

	emake || die
}

src_install() {
	make 	\
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die

	cd ${S}/doc
	dodoc README* *.txt BUGS FAQ
	dohtml *.html
}
