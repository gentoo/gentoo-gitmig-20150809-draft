# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-2.95.3-r6.ebuild,v 1.1 2001/09/01 23:23:06 drobbins Exp $

TV=4.0
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
DEPEND="virtual/glibc >=sys-apps/texinfo-4.0-r3"
RDEPEND="virtual/glibc"
if [ -z "`use build`" ]
then
	DEPEND="$DEPEND nls? ( sys-devel/gettext ) >=sys-libs/ncurses-5.2-r2"
	RDEPEND="$RDEPEND >=sys-libs/ncurses-5.2-r2"
fi

src_unpack() {
	unpack ${P}.tar.gz
	if [ "`use libg++`" ]
	then
		unpack libg++-2.8.1.3.tar.gz
		cd ${S}/../libg++-2.8.1.3
		gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000312.diff.gz | patch -p1 || die
		gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000419.diff.gz | patch -p1 || die
		gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000816.diff.gz | patch -p1 || die
		gzip -dc ${DISTDIR}/libg++-2.8.1.3-20000914.diff.gz | patch -p1 || die
		cd ${S}
		mv ../libg++-2.8.1.3/* .
		rmdir ../libg++-2.8.1.3
	fi
	cd ${S}
	# A patch for the atexit problem occured with glibc-2.2.3
	patch -l -p0 < ${FILESDIR}/${P}-atexit.diff || die
}

src_compile() {
	local myconf
	if [ -z "`use build`" ]
	then
		myconf="--enable-shared"
	else
		myconf="--enable-languages=c"
	fi
	if [ -z "`use nls`" ] || [ "`use build`" ] ; then
		myconf="$myconf --disable-nls"
	else
		myconf="$myconf --enable-nls --without-included-gettext"
	fi

	# gcc does not like optimization

	export CFLAGS="${CFLAGS/-O?/}"
	export CXXFLAGS="${CXXFLAGS/-O?/}"

	${S}/configure --prefix=${LOC} --mandir=${LOC}/share/man --infodir=${LOC}/share/info \
	--enable-version-specific-runtime-libs --host=${CHOST} --build=${CHOST} --target=${CHOST} --enable-threads  \
	--with-local-prefix=${LOC}/local ${myconf} || die

	if [ -z "`use static`" ]
	then
		emake bootstrap-lean || die
	else
		emake LDFLAGS=-static bootstrap || die
	fi
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
		cd ${S}
		docinto /	
		dodoc COPYING COPYING.LIB README* FAQ MAINTAINERS
		docinto html
		dodoc faq.html
		docinto gcc
		cd ${S}/gcc
		dodoc BUGS ChangeLog* COPYING* FSFChangeLog* LANGUAGES NEWS PROBLEMS README* SERVICE TESTS.FLUNK
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
	fi
}
