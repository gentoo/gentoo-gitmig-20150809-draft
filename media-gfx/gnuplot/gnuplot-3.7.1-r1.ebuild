# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <g2boojum@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-3.7.1-r1.ebuild,v 1.1 2001/10/24 16:53:08 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Quick and useful plotting program"
SRC_URI="ftp://ftp.gnuplot.org/pub/gnuplot/${P}.tar.gz"
HOMEPAGE="http://www.gnuplot.org"

DEPEND="media-libs/libpng
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )"

src_compile() {
	local myvar
	#--with-lasergnu flag seems to be broken and I'm too lazy to fix now
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
	if [ -z "`use svga`" ]
	then
		myvar="${myvar} --without-linux-vga"
	else
		myvar="${myvar} --with-linux-vga"
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

pkg_postinst() {
	if [ "`use svga`" ]
	then
		echo
		echo "*****************************************************************"
		echo " In order to enable ordinary users to use SVGA console graphics"
		echo " gnuplot needs to be set up as setuid root.  Please note that"
		echo " this is usually considered to be a security hazard."
		echo " As root, manually chmod u+s /usr/bin/gnuplot"
		echo "*****************************************************************"
		echo
	fi
}


