# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.0.0.20010514.ebuild,v 1.1 2001/05/22 03:47:34 achim Exp $


SRC_URI="ftp://ftp.fu-berlin.de/unix/languages/egcs/snapshots/2001-05-14/gcc-20010514.tar.gz"

if [ "`use libg++`" ]
then
    SRC_URI="${SRC_URI}
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000312.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000419.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz"
fi

S=${WORKDIR}/${PN}-20010514
T=/usr

DESCRIPTION="Modern GCC C/C++ compiler"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
if [ -z "`use build`" ] ; then
  if [ "`use bootstrap`" ] ; then
	DEPEND="nls? ( sys-devel/gettext )"
  else
	DEPEND="nls? ( sys-devel/gettext ) sys-apps/texinfo"
  fi
fi


src_unpack() {

    unpack gcc-20010514.tar.gz

    if [ "`use libg++`" ]
    then
      unpack libg++-2.8.1.3.tar.gz
      cd ${S}/../libg++-2.8.1.3
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000312.diff.gz | patch -p1
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000419.diff.gz | patch -p1
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000816.diff.gz | patch -p1
      gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000914.diff.gz | patch -p1
      cd ${S}
      mv ../libg++-2.8.1.3/* .
      rmdir ../libg++-2.8.1.3
    fi

    cd ${S}

    # We do not build the included texinfo stuff
    if [ -z "`use build`" ]
    then 
      rm -rf texinfo
    fi
}

src_compile() {

    local myconf
    if [ -z "`use build`" ]
    then
        myconf="--enable-shared --enable-languages=c,c++,f77,java,objc"
    else
        myconf="--enable-languages=c"
    fi
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

    # gcc does not like optimization

    export CFLAGS="${CFLAGS/-O?/}"
    export CXXFLAGS="${CXXFLAGS/-O?/}"
    mkdir build
    cd build
    try ${S}/configure --prefix=${T} --mandir=${T}/share/man --infodir=${T}/share/info \
                --host=${CHOST} --build=${CHOST} --target=${CHOST} --enable-threads  \
                --with-local-prefix=${T}/local ${myconf} \
                --enable-version-specific-runtime-libs 
	# Parallel build does not work
    if [ -z "`use static`" ]
    then
	    try make bootstrap-lean
    else
        try make LDFLAGS=-static bootstrap-lean
    fi
#    if [ "`use build`" ]
#    then
#        cd ${S}/texinfo/util
#        make texindex install-info
#    fi
}

src_install() {
    cd build
	try make install prefix=${D}${T} mandir=${D}${T}/share/man infodir=${D}${T}/share/info

    FULLPATH=${D}${T}/lib/gcc-lib/${CHOST}/3.0
	cd ${FULLPATH}
	dodir /lib
	dosym	${T}/lib/gcc-lib/${CHOST}/3.0/cpp0 /lib/cpp
	dosym   /usr/bin/gcc /usr/bin/cc
	dodir /etc/env.d
	echo "LDPATH=${T}/lib/gcc-lib/${CHOST}/3.0" > ${D}/etc/env.d/05gcc
	cd ${S}
    if [ -z "`use build`" ]
    then
	    dodoc COPYING COPYING.LIB README* FAQ MAINTAINERS
	    docinto html
	    dodoc faq.html
	    docinto gcc
	    cd ${S}/gcc
	    dodoc BUGS ChangeLog* COPYING* FSFChangeLog* \
	        LANGUAGES NEWS PROBLEMS README* \
	        SERVICE TESTS.FLUNK
	    cd ${S}/libchill
	    docinto libchill
	    dodoc ChangeLog
	    cd ${S}/libf2c
	    docinto libf2c
	    dodoc ChangeLog changes.netlib README TODO
	    cd ${S}/libiberty
	    docinto libiberty
	    dodoc ChangeLog COPYING.LIB README
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

        if [ "`use libg++`" ]
        then
            cd ${S}/libg++
	        docinto libg++
	        dodoc ChangeLog g++FAQ.txt NEWS README* TODO
        else
            cd ${S}/libstdc++
	        docinto libstdc++
            dodoc ChangeLog NEWS
        fi
    else
        rm -rf ${D}/usr/share/{man,info}
        #cd texinfo
        #dobin makeinfo/makeinfo util/texi2dvi util/install-info util/texindex
    fi

}





