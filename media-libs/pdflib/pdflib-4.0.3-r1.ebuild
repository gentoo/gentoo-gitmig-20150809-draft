# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/pdflib/pdflib-4.0.3-r1.ebuild,v 1.8 2003/05/21 14:08:04 lu_zero Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for generating PDF on the fly"
SRC_URI="http://www.pdflib.com/pdflib/download/${P}.tar.gz
	http://www.pdflib.com/pdflib/download/PHP-4.3.0/pdf.c"
HOMEPAGE="http://www.pdflib.com"
IUSE="tcltk perl python java"
SLOT="4"
LICENSE="Aladdin"
KEYWORDS="x86 ~ppc sparc hppa ~alpha"

DEPEND="tcltk? ( >=dev-lang/tk-8.2 )
	perl? ( >=dev-lang/perl-5.1 )
	python? ( =dev-lang/python-2.2* )
	java? ( >=virtual/jdk-1.3 )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	# updated file for compatibility with php-4.3.0
	cp ${DISTDIR}/pdf.c ${S}/bind/php/ext/pdf/
}

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
	use tcltk || myconf="--with-tcl=no"

	use perl || myconf="${myconf} --with-perl=no"

	use python \
		&& myconf="${myconf} --with-py=/usr --with-pyincl=/usr/include/python2.2" \
		|| myconf="${myconf} --with-py=no"

	use java \
		&& myconf="${myconf} --with-java=${JAVA_HOME}" \
		|| myconf="${myconf} --with-java=no"
		
	# libpng-1.2.5 needs to be linked against stdc++ and zlib
	cp configure configure.old
	sed -e 's:-lpng:-lpng -lz -lstdc++:' configure.old > configure

	econf \
		--enable-cxx \
		${myconf} || die
		
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
	if [ ! -z "`use perl`" ] && [ -x /usr/bin/perl ] ; then
		local perlmajver="`/usr/bin/perl -v |grep 'This is perl' \
			|cut -d ' ' -f 4 |cut -d '.' -f 1`"
		local perlver="`/usr/bin/perl -v |grep 'This is perl' \
			|cut -d ' ' -f 4`"
		local perlarch="`/usr/bin/perl -v |grep 'This is perl' \
			|cut -d ' ' -f 7`"
		dodir /usr/lib/perl${perlmajver/v/}/site_perl/${perlver/v/}/${perlarch}
	fi
	if [ ! -z "`use python`" ] && [ -x /usr/bin/python ] ; then
		local pyver="`/usr/bin/python -V 2>&1 \
			|cut -d ' ' -f 2 |cut -d '.' -f 1,2`"
		dodir /usr/lib/python${pyver}/lib-dynload
	fi
	#next line required for proper install
	dodir /usr/bin
	make prefix=${D}/usr \
		install || die

	dodoc readme.txt doc/*

	# karltk: This is definitely NOT how it should be done!
	# we need this to create pdflib.jar (we will not have the source when
	# this is a binary package ...)
	if [ "`use java`" ]
	then
		insinto /usr/share/pdflib
		doins ${S}/bind/java/pdflib.java
	
		mkdir -p com/pdflib
		mv ${S}/bind/java/pdflib.java com/pdflib
		javac com/pdflib/pdflib.java
	
		jar cf pdflib.jar com/pdflib/*.class
	
		dojar pdflib.jar
	fi
}
