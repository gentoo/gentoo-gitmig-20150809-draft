# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-1.3.1.ebuild,v 1.13 2003/04/28 15:56:01 mholzer Exp $

IUSE="X tetex"

S=${WORKDIR}/${P}
DESCRIPTION="A Type 1 Rasterizer Library for UNIX/X11"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="ftp://metalab.unc.edu/pub/Linux/libs/graphics"

DEPEND="X? ( virtual/x11 )
	tetex? ( >=app-text/tetex-1.0.7 )"

SLOT="0"
LICENSE="LGPL-2 GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

src_unpack() {
	unpack ${A}

	cd ${S}/doc
	mv Makefile.in Makefile.in-orig
	sed -e "s:dvips:#dvips:" Makefile.in-orig>Makefile.in

}

src_compile() {

	local myconf
	local myopt

	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
	
	use tetex \
		|| myopt="without_doc"
	echo `pwd`	
	econf ${myconf} || die
	make ${myopt} || die
}

src_install() {

	cd lib
	insinto /usr/include
	doins t1lib.h

	use X && ( \
		doins t1libx.h
		ln -s -f libt1x.lai .libs/libt1x.la
		dolib .libs/libt1x.{la,a,so.1.3.1}
		dosym libt1x.so.1.3.1 /usr/lib/libt1x.so.1
		dosym libt1x.so.1.3.1 /usr/lib/libt1x.so
	)

	ln -s -f libt1.lai .libs/libt1.la
	dolib .libs/libt1.{la,a,so.1.3.1}
	dosym libt1.so.1.3.1 /usr/lib/libt1.so.1
	dosym libt1.so.1.3.1 /usr/lib/libt1.so
	insinto /etc/t1lib
	doins t1lib.config

	cd ..
	dodoc Changes LGPL LICENSE README*
	cd doc
	insinto /usr/share/doc/t1lib-1.3.1/
	doins *.pdf *.dvi

}
