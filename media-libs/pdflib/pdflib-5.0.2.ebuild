# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/pdflib/pdflib-5.0.2.ebuild,v 1.12 2004/01/26 16:32:54 scandium Exp $

IUSE="tcltk perl python java"

MY_PN=${PN/pdf/PDF}-Lite
MY_P=${MY_PN}-${PV}-Unix-src
S=${WORKDIR}/${MY_P}
PYVER="$(/usr/bin/python -V 2>&1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2)"
DESCRIPTION="A library for generating PDF on the fly"
HOMEPAGE="http://www.pdflib.com/"
SRC_URI="http://www.pdflib.com/products/pdflib/download/${MY_P}.tar.gz"

SLOT="5"
LICENSE="Aladdin"
KEYWORDS="x86 ppc sparc alpha hppa ~mips ~arm amd64 ia64 ~ppc64"

DEPEND=">=sys-apps/sed-4
	tcltk? ( >=dev-lang/tk-8.2 )
	perl? ( >=dev-lang/perl-5.1 )
	python? ( >=dev-lang/python-2.2 )
	java? ( >=virtual/jdk-1.3 )"

src_compile() {

	# fix sandbox violations
	# NOTE: the basic theory is to not compile pdflib.java during
	# src_compile() or src_install(), but rather in pkg_postinstall(),
	# and then install it where it can be found.
	sed -i \
		-e "s/all:\t\$(SWIG_LIB) pdflib.jar/all:\t\$(SWIG_LIB)/" \
		-e "s/install: \$(SWIG_LIB) pdflib.jar/install: \$(SWIG_LIB)/" \
		${S}/bind/java/Makefile.in

	local myconf=
	use tcltk || myconf="--with-tcl=no"

	use perl || myconf="${myconf} --with-perl=no"

	use python \
		&& myconf="${myconf} --with-py=/usr --with-pyincl=/usr/include/python${PYVER}" \
		|| myconf="${myconf} --with-py=no"

	use java \
		&& myconf="${myconf} --with-java=${JAVA_HOME}" \
		|| myconf="${myconf} --with-java=no"

	# libpng-1.2.5 needs to be linked against stdc++ and zlib
#	sed -i -e 's:-lpng:-lpng -lz -lstdc++:' configure

	econf \
		--enable-cxx \
		${myconf} || die

	emake || die
}

src_install() {

	# fix sandbox violations
	# NB: do this *after* build, otherwise we will get linker problems.
	# all we basically do here is modify the install path for Makefiles that
	# need it.
#	sed -i -e "s:^\(LANG_LIBDIR\).*= \(.*\):\1\t = ${D}/\2:" \
#		${S}/bind/pdflib/java/Makefile

	sed -i -e "s:^\(LANG_LIBDIR\).*= \(.*\):\1\t = ${D}/\2:" \
		${S}/bind/pdflib/perl/Makefile

	sed -i -e "s:^\(LANG_LIBDIR\).*= \(.*\):\1\t = ${D}/\2:" \
		${S}/bind/pdflib/python/Makefile

	sed -i -e "s:^\(LANG_LIBDIR\).*= \(.*\):\1\t = ${D}/\2:" \
		${S}/bind/pdflib/tcl/Makefile

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
		dodir /usr/lib/python${PYVER}/lib-dynload
	fi
	#next line required for proper install
	dodir /usr/bin
	einstall || die

	dodoc readme.txt doc/*

	# seemant: seems like the makefiles for pdflib generate the .jar file
	# anyway
	use java && dojar bind/pdflib/java/pdflib.jar

	# karltk: This is definitely NOT how it should be done!
	# we need this to create pdflib.jar (we will not have the source when
	# this is a binary package ...)
#	if [ "`use java`" ]
#	then
#		insinto /usr/share/pdflib
#		doins ${S}/bind/pdflib/java/pdflib.java
#
#		mkdir -p com/pdflib
#		mv ${S}/bind/pdflib/java/pdflib.java com/pdflib
#		javac com/pdflib/pdflib.java
#
#		jar cf pdflib.jar com/pdflib/*.class
#
#		dojar pdflib.jar
#	fi
}
