# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/pdflib/pdflib-4.0.1-r3.ebuild,v 1.3 2002/07/23 00:12:55 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A library for generating PDF on the fly"
SRC_URI="http://www.pdflib.com/pdflib/download/${P}.tar.gz"
HOMEPAGE="http://www.pdflib.com"

SLOT="4"
LICENSE="Aladdin"
KEYWORDS="x86"

DEPEND="tcltk? ( >=dev-lang/tk-8.2 )
	perl? ( >=sys-devel/perl-5.1 )
	python? ( >=dev-lang/python-2.0 )
	java? ( >=virtual/jdk-1.3 )"


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

	use python && ( \
		if [ -x /usr/bin/python ]
		then
			local pyver="`/usr/bin/python -V 2>&1 \
			|cut -d ' ' -f 2 |cut -d '.' -f 1,2`"
			myconf="${myconf} --with-pyincl=/usr/include/python${pyver}"
		fi 
	) || ( \
		myconf="${myconf} --with-py=no"
	)

	use java \
		&& myconf="${myconf} --with-java=${JAVA_HOME}" \
		|| myconf="${myconf} --with-java=no"
	
	econf \
		--enable-cxx \
		--disable-php \
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
