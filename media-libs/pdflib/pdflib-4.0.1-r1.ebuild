# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Grant Goodyear <g2boojum@hotmail.com>
# $Header: /var/cvsroot/gentoo-x86/media-libs/pdflib/pdflib-4.0.1-r1.ebuild,v 1.1 2002/01/14 00:50:51 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for generating PDF on the fly"
SRC_URI="http://www.pdflib.com/pdflib/download/${P}.tar.gz"
HOMEPAGE="http://www.pdflib.com"

DEPEND="tcltk? ( >=dev-lang/tcl-tk-8.2 )
	perl? ( >=sys-devel/perl-5.1 )
	python? ( >=dev-lang/python-2.0 )
	java? ( >=virtual/jdk-1.3 )"


[ -n "`use java`" ] && PATH=${PATH}:${JAVA_HOME}/bin

src_compile() {

	# fix sandbox violations
	# NOTE: the basic theory is to not compile pdflib.java during
	# src_compile() or src_install(), but rather in pkg_postinstall(),
	# and then install it where it can be found.
	cp ${S}/bind/java/Makefile.in ${S}/bind/java/Makefile.in.orig
	sed -e "s/all:\t\$(SWIG_LIB) pdflib.jar/all:\t\$(SWIG_LIB)/" \
		-e "s/install: \$(SWIG_LIB) pdflib.jar/install: \$(SWIG_LIB)/" \
		${S}/bind/java/Makefile.in.orig > ${S}/bind/java/Makefile.in

	local myconf
	if [ -z "`use tcltk`" ] ; then
		myconf="--with-tcl=no"
	fi
	if [ -z "`use perl`" ] ; then
		myconf="$myconf --with-perl=no"
	fi
	if [ -z "`use python`" ] ; then
		myconf="$myconf --with-py=no"
	elif [ -x /usr/bin/python ] ; then
		
		local pyver="`/usr/bin/python -V 2>&1 \
			|cut -d ' ' -f 2 |cut -d '.' -f 1,2`"
		myconf="$myconf --with-pyincl=/usr/include/python${pyver}"
	fi
	if [ "`use java`" ] ; then
		myconf="$myconf --with-java=/opt/java"
	else
		myconf="$myconf --with-java=no"
	fi
	
	./configure --prefix=/usr \
		--host=${CHOST} \
		--enable-cxx \
		--disable-php \
		$myconf || die
		
	emake || die
}

src_install() {

	# fix sandbox violations
	# NB: do this *after* build, otherwise we will get linker problems.
	# all we basically do here is modify the install path for Makefiles that
	# needs it.
	cp ${S}/bind/java/Makefile ${S}/bind/java/Makefile.orig
	sed -e "s:LANG_LIBDIR \t\= :LANG_LIBDIR\t\= ${D}:" \
		${S}/bind/java/Makefile.orig > ${S}/bind/java/Makefile
	cp ${S}/bind/perl/Makefile ${S}/bind/perl/Makefile.orig
	sed -e "s:LANG_LIBDIR \t\= :LANG_LIBDIR\t\= ${D}:" \
		${S}/bind/perl/Makefile.orig > ${S}/bind/perl/Makefile
	cp ${S}/bind/python/Makefile ${S}/bind/python/Makefile.orig
	sed -e "s:LANG_LIBDIR \t\= :LANG_LIBDIR\t\= ${D}:" \
		${S}/bind/python/Makefile.orig > ${S}/bind/python/Makefile
	cp ${S}/bind/tcl/Makefile ${S}/bind/tcl/Makefile.orig
	sed -e "s:LANG_LIBDIR \t\= :LANG_LIBDIR\t\= ${D}:" \
		${S}/bind/tcl/Makefile.orig > ${S}/bind/tcl/Makefile

	# ok, this should create the correct lib dirs for perl and python.
	# yes, i know it is messy, but as i see it, a ebuild should be generic
	# ... ie. you should be able to just use cp to update it
	if [ -n "`use perl`" ] && [ -x /usr/bin/perl ] ; then
		local perlmajver="`/usr/bin/perl -v |grep 'This is perl' \
			|cut -d ' ' -f 4 |cut -d '.' -f 1`"
		local perlver="`/usr/bin/perl -v |grep 'This is perl' \
			|cut -d ' ' -f 4`"
		local perlarch="`/usr/bin/perl -v |grep 'This is perl' \
			|cut -d ' ' -f 7`"
		dodir /usr/lib/perl${perlmajver/v/}/site_perl/${perlver/v/}/${perlarch}
	fi
	if [ -n "`use python`" ] && [ -x /usr/bin/python ] ; then
		local pyver="`/usr/bin/python -V 2>&1 \
			|cut -d ' ' -f 2 |cut -d '.' -f 1,2`"
		dodir /usr/lib/python${pyver}/lib-dynload
	fi

	make prefix=${D}/usr \
		install || die

	dodoc readme.txt doc/*

	# we need this to create pdflib.jar (we will not have the source when
	# this is a binary package ...)
	insinto /usr/share/pdflib
	doins ${S}/bind/java/pdflib.java
}

pkg_postinst() {

	# now compile and install the pdflib.jar
	cd ${T}
	jar cvf /usr/share/pdflib/pdflib.jar /usr/share/pdflib/pdflib.class
	rm -rf /usr/share/pdflib/pdflib.class

	echo
	echo "******************************************************"
	echo "* Add /usr/share/pdflib to you $CLASSPATH, or copy   *"
	echo "* /usr/share/pdflib/pdflib.jar to a directory in     *"
	echo "* your $CLASSPATH.                                   *"
	echo "******************************************************"
	echo
}
