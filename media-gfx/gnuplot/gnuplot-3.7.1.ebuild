# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-3.7.1.ebuild,v 1.1 2001/10/23 15:34:18 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Quick and useful plotting program"
SRC_URI="ftp://ftp.gnuplot.org/pub/gnuplot/${P}.tar.gz"
HOMEPAGE="http://www.gnuplot.org"

DEPEND="media-libs/libpng"

src_compile() {
	local myvar
	#myvar=" --with-png --without-gd --with-lasergnu"
	myvar=" --with-png --without-gd"
	if [ -z "`use X`" ]
	then
		myvar="${myvar} --without-x"
	else
		myvar="${myvar} --with-x"
	fi
	if [ -z "`use readline`" ]
	then
		#use the built-in readline
		myvar="${myvar} --with-readline"
	else
		#use gnu readline
		myvar="${myvar} --with-readline=gnu"
	fi
	./configure \
		${myvar} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--datadir=/usr/share/gnuplot \
		--mandir=/usr/share/man || die
	mv Makefile Makefile.orig
	sed -e 's/datadir = \/usr/datadir = ${prefix}/'  \
	    -e 's/mandir = \/usr/mandir = ${prefix}/' \
	    Makefile.orig > Makefile
	cd docs
	mv Makefile Makefile.orig
	sed -e 's/datadir = \/usr/datadir = ${prefix}/' Makefile.orig > Makefile
	cd ..
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
}
