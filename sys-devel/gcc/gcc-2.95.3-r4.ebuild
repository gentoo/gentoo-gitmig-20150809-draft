# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.95.3-r4.ebuild,v 1.7 2001/08/31 03:11:59 drobbins Exp $

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.gz
	ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3.tar.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000312.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000419.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000816.diff.gz
    ftp://ftp.freesoftware.com/pub/sourceware/gcc/infrastructure/libg++-2.8.1.3-20000914.diff.gz"

S=${WORKDIR}/${P}
LOC=/usr

DESCRIPTION="Modern GCC C/C++ compiler"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
if [ -z "`use build`" ]
then
	DEPEND="nls? ( sys-devel/gettext )"
fi

src_unpack() {
	unpack ${P}.tar.gz
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
	# A patch for the atexit problem occured with glibc-2.2.3
	patch -l -p0 < ${FILESDIR}/${P}-atexit.diff
}

src_compile() {
	local myconf
	if [ -z "`use build`" ]
	then
		myconf="--enable-shared"
	else
		myconf="--enable-languages=c"
	fi
	if [ "`use nls`" ]
	then
		if [ "`use build`" ]
		then
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

	${S}/configure --prefix=${LOC} --mandir=${LOC}/share/man --infodir=${LOC}/share/info \
	--enable-version-specific-runtime-libs \
	--host=${CHOST} --build=${CHOST} --target=${CHOST} --enable-threads  \
	--with-local-prefix=${LOC}/local ${myconf} --without-included-gettext || die

	if [ -z "`use static`" ]
	then
		emake bootstrap-lean || die
	else
		emake LDFLAGS=-static bootstrap || die
	fi
	cd ${S}/texinfo/util
	make texindex install-info
}

src_install() {
	make install prefix=${D}${LOC} mandir=${D}${LOC}/share/man infodir=${D}${LOC}/share/info || die
	[ -e ${D}/usr/bin/gcc ] || die "gcc not found in ${D}"
    FULLPATH=${D}${LOC}/lib/gcc-lib/${CHOST}/${PV}
	cd ${FULLPATH}
	dodir /lib
	dosym /usr/bin/cpp /lib/cpp
	dosym gcc /usr/bin/cc
	dodir /etc/env.d
	echo "LDPATH=${LOC}/lib/gcc-lib/${CHOST}/${PV}" > ${D}/etc/env.d/05gcc
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
		cd ${S}/texinfo
	fi
	newbin makeinfo/makeinfo makeinfo.gcc
	newbin util/texi2dvi texi2dvi.gcc
	newbin util/install-info install-info.gcc
	newbin util/texindex texindex.gcc
}

pkg_postinst() {
	#create symlinks for makeinfo, etc pointing to the gcc (3.12) versions only if the
	#*real* version (4.0) isn't already installed.  Should allow us to use 3.12 until
	#4.0 is available and not worry about having gcc overwrite our texinfo-4.0 stuff.
	local x
	cd ${ROOT}usr/bin
	for x in makeinfo texi2dvi install-info texindex
	do
		if [ ! -e $x ]
		then
			ln -s ${x}.gcc $x
		fi
	done
}



