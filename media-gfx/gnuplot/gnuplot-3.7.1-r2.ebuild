# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnuplot/gnuplot-3.7.1-r2.ebuild,v 1.2 2002/07/11 06:30:27 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Quick and useful plotting program"
SRC_URI="ftp://ftp.gnuplot.org/pub/gnuplot/${P}.tar.gz"
HOMEPAGE="http://www.gnuplot.org"

DEPEND="media-libs/libpng
	plotutils? ( media-libs/plotutils )
	readline? ( sys-libs/readline )
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )"

src_compile() {
	local myvar
	#--with-lasergnu flag seems to be broken and I'm too lazy to fix now
	#myvar=" --with-png --without-gd --with-lasergnu"
	myvar=" --with-png --without-gd --with-plot=/usr/lib"
	#--with-plot enables the Gnu plotutils library
	#need to specify path to differentiate from Unix plot
	if [ -z "`use plotutils`" ]
	then
		myvar="${myvar} --without-plot"
	else
		myvar="${myvar} --with-plot=/usr/lib"
	fi
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
		einfo ""	
		einfo "*****************************************************************"
		einfo " In order to enable ordinary users to use SVGA console graphics"
		einfo " gnuplot needs to be set up as setuid root.  Please note that"
		einfo " this is usually considered to be a security hazard."
		einfo " As root, manually chmod u+s /usr/bin/gnuplot"
		einfo "*****************************************************************"
		einfo
	fi
}


