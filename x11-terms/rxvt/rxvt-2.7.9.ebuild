# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt/rxvt-2.7.9.ebuild,v 1.2 2003/03/07 08:09:31 drobbins Exp $

inherit eutils

IUSE="motif"
S=${WORKDIR}/${P}
DESCRIPTION="rxvt -- nice small x11 terminal"
SRC_URI="ftp://ftp.rxvt.org/pub/rxvt/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
#This ebuild has problems compiling, and die doesn't detect the error.
#some UTMP issue, and rxvt doesn't compile. So zapping this for now (drobbins, 07 Mar 2003)
KEYWORDS="-*"
#KEYWORDS="~x86 ~ppc ~alpha ~sparc"

HOMEPAGE="http://www.rxvt.org"

DEPEND="virtual/glibc
	virtual/x11
	motif? ( x11-libs/openmotif )"


src_unpack() {
	unpack ${A}
	cd ${S}
	
	use motif && epatch ${FILESDIR}/${P}-azz4.diff
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-rxvt-scroll \
		--enable-transparency \
		--enable-xpm-background \
		--enable-utmp \
		--enable-wtmp \
		--enable-mousewheel \
		--enable-slipwheeling \
		--enable-smart-resize \
		--enable-menubar \
		--enable-languages \
		--enable-xim \
		--enable-shared \
		--enable-keepscrolling || die

	emake || die
}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
	install || die
	
	cd ${S}/doc
	dodoc README* *.txt BUGS FAQ
	dohtml *.html
}
