
# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Sebastian Werner <sebastian@werner-productions.de>

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.gz
	ftp://ftp.gnu.org/pub/gnu/gcc/${P}/${P}.tar.gz"

S=${WORKDIR}/${P}
T=/usr

DESCRIPTION="GNU Compiler Collection (C/C++/Java/Fortran) 3.0.1"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
if [ -z "`use build`" ] ; then
  if [ "`use bootstrap`" ] ; then
	DEPEND="nls? ( sys-devel/gettext )"
  else
	DEPEND="nls? ( sys-devel/gettext ) sys-apps/texinfo"
  fi
fi

src_unpack() {

    unpack ${P}.tar.gz
    cd ${S}
}

src_compile() {

    local myconf
    local buildlang
   
    buildlang="c"

    if [ -z "`use build`" ]; then
      if [ "`use gcc_java`" ]; then
        buildlang="$buildlang,java"
      fi

      if [ "`use gcc_objc`" ]; then
        buildlang="$buildlang,objc"
      fi

      if [ "`use gcc_f77`" ]; then
        buildlang="$buildlang,f77"
      fi
      
      if [ "`use gcc_c++`" ]; then
        buildlang="$buildlang,c++"
      fi
    fi
    
    if [ -z "`use build`" ]
    then
        myconf="--enable-shared"
    fi
   
    myconf="$myconf --enable-languages=$buildlang"
    
    if [ "`use nls`" ]
    then
	if [ "`use build`" ] ; then
          myconf="${myconf} --with-included-gettext --enable-nls"
	else
          myconf="${myconf} --enable-nls"
	fi
    else
        myconf="${myconf} --disable-nls"
    fi

    mkdir $CHOST
    cd $CHOST

    echo ">>> Building with the following configuration: $myconf"

    try ${S}/configure --prefix=${T} --mandir=${T}/share/man --infodir=${T}/share/info \
                --enable-version-specific-runtime-libs \
                --host=${CHOST} --build=${CHOST} --target=${CHOST} --enable-threads  \
                --with-local-prefix=${T}/local ${myconf}

    try make ${MAKEOPTS} bootstrap
}

src_install() {

    cd ${S}/${CHOST}
    
    try make install prefix=${D}${T} mandir=${D}${T}/share/man infodir=${D}${T}/share/info
    
    FULLPATH=${D}${T}/lib/gcc-lib/${CHOST}/${PV}
    cd ${FULLPATH}
    dodir /lib
    dosym /usr/bin/cpp /lib/cpp
    dosym /usr/bin/gcc /usr/bin/cc
    dodir /etc/env.d
    echo "LDPATH=${T}/lib/gcc-lib/${CHOST}/${PV}" > ${D}/etc/env.d/05gcc3
    cd ${S}

    if [ -z "`use build`" ]
    then
	    dodoc BUGS ChangeLog COPYING COPYING.LIB GNATS README* FAQ MAINTAINERS
	    docinto html
	    dodoc *.html

            cd ${S}/boehm-gc
	    docinto hoehm-gc
	    dodoc ChangeLog README*

	    docinto gcc
	    cd ${S}/gcc
	    dodoc ABOUT-GCC-NLS ChangeLog* COPYING* FSFChangeLog* \
	        LANGUAGES NEWS PROBLEMS README* \
	        SERVICE

	    cd ${S}/libf2c
	    docinto libf2c
	    dodoc ChangeLog *.netlib README TODO

            cd ${S}/libffi
	    docinto libffi
	    dodoc ChangeLog* LICENSE README

	    cd ${S}/libiberty
	    docinto libiberty
	    dodoc ChangeLog COPYING.LIB README

            cd ${S}/libjava
	    docinto libjava
	    dodoc ChangeLog* COPYING LIBGJC_LICENSE README THANKS

	    cd ${S}/libio
	    docinto libio
	    dodoc ChangeLog NEWS README

	    cd dbz
	    docinto libio/dbz
	    dodoc README

	    cd ../stdio
	    docinto libio/stdio
	    dodoc ChangeLog*

	    cd ${S}/libobjc
	    docinto libobjc
	    dodoc ChangeLog README* THREADS*
    else
        rm -rf ${D}/usr/share/{man,info}
    fi
}
