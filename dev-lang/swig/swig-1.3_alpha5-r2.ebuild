# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-1.3_alpha5-r2.ebuild,v 1.3 2001/11/10 11:31:53 hallski Exp $

P=swig1.3a5
S=${WORKDIR}/SWIG1.3a5
DESCRIPTION="Simplified wrapper and interface generator"
SRC_URI="http://download.sourceforge.net/swig/${P}.tar.gz"
HOMEPAGE="http://www.swig.org"

DEPEND="virtual/glibc >=sys-devel/gcc-2.95.2
	python? ( >=dev-lang/python-2.0 )
	java? ( >=dev-lang/jdk-1.3 )
	ruby? ( >=dev-lang/ruby-1.6.1 )
	guile? ( >=dev-util/guile-1.4 )
	tcltk? ( >=dev-lang/tcl-tk-8.4.2 )
	perl? ( >=sys-devel/perl-5.6.1 )"

src_compile() {
	local myconf

	if [ "`use python`" ] ; then
		myconf="--with-py"
	else
		myconf="--without-py"
	fi
	if [ "`use java`" ] ; then
		myconf="$myconf --with-java"
	else
		myconf="$myconf --without-java"
	fi	
	if [ -z "`use ruby`" ] ; then
		myconf="$myconf --without-ruby"
	fi
	if [ "`use guile`" ] ; then
		myconf="$myconf --with-guile"
	else
		myconf="$myconf --without-guile"
	fi
	if [ "`use tcltk`" ] ; then
		myconf="$myconf --with-tcl --with-tcllib=/usr/lib/tcl-8.4"
	else
		myconf="$myconf --without-tcltk"
	fi
	if [ "`use perl`" ]
	then
		myconf="$myconf --with-perl"
	else
		myconf="$myconf --without-perl"
	fi

	unset CXXFLAGS
	unset CFLAGS
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --with-doc=html					\
		    $myconf || die

	make || die
}

src_install () {
	make prefix=${D}/usr install || die
}
