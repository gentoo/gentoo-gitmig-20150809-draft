# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.1-r8.ebuild,v 1.12 2003/06/12 22:12:22 msterret Exp $

IUSE="nls bootstrap static build"

# NOTE TO MAINTAINER:  Info pages get nuked for multiple version installs.
#                      Ill fix it later if i get a chance.
#
# IMPORTANT:  The versions of libs installed should be updated
#             in src_install() ... Ill implement auto-version detection
#             later on.

inherit libtool

GCC_SUFFIX=-3.1
LOC=/usr
# dont install in /usr/include/g++-v3/, as it will nuke gcc-3.0.x installs
STDCXX_INCDIR="${LOC}/include/g++-v${PV/\./}"
SLOT="3.1"
# we need to set $S to where stuff gets build, else the libtool-portage patch
# do not work
S=${WORKDIR}/build
# the true/original $S
SORIG=${WORKDIR}/${P}
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.bz2
	ftp://ftp.funet.fi/pub/mirrors/sourceware.cygnus.com/pub/gcc/releases/${P}/${P}.tar.bz2"
DESCRIPTION="Modern GCC C/C++ compiler"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc  -ppc"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc 
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4"
if [ -z "`use build`" ]
then
	DEPEND="${DEPEND}
		nls? ( sys-devel/gettext )
		>=sys-libs/ncurses-5.2-r2"
	RDEPEND="${RDEPEND}
		>=sys-libs/ncurses-5.2-r2"
fi

build_multiple() {
	#try to make sure that we should build multiple
	#versions of gcc (dual install of gcc2 and gcc3)
	profile="`readlink /etc/make.profile`"
	# [ "`gcc -dumpversion | cut -d. -f1,2`" != "`echo ${PV} | cut -d. -f1,2`" ]
	#
	# Check the major and minor versions only, and drop the micro version.
	# This is done, as compadibility only differ when major and minor differ.
	if [ -z "`use build`" ] && \
	   [ -z "`use bootstrap`" ] && \
	   [ "`gcc -dumpversion | cut -d. -f1,2`" != "`echo ${PV} | cut -d. -f1,2`" ] && \
	   [ "${profile/gcc3}" = "${profile}" ] && \
	   [ "${GCCBUILD}" != "default" ]
	then
		return 0
	else
		return 1
	fi	  
}

# used to patch Makefiles to install into the build dir
FAKE_ROOT=""

src_unpack() {
	unpack ${P}.tar.bz2
	
	cd ${SORIG}
	# Fixup libtool to correctly generate .la files with portage
	# Only apply the portage patch, and only to ltmain.sh in ${SORIG}/
	# elibtoolize uses $S as work directory....
	S=${SORIG} \
		elibtoolize --portage --shallow

	# Red Hat patches
	for x in gcc31-boehm-gc-libs.patch.bz2 \
		gcc31-fde-merge-compat.patch.bz2 \
		gcc31-attr-visibility.patch.bz2 \
		gcc31-attr-visibility2.patch.bz2 \
		gcc31-trunc_int_for_mode.patch.bz2 \
		gcc31-dwarf2-pr6381.patch.bz2 \
		gcc31-dwarf2-pr6436-test.patch.bz2 \
		gcc31-c++-null-pm-init.patch.bz2 \
		gcc31-c++-tsubst-asm.patch.bz2 \
		gcc31-fdata-sections.patch.bz2 \
		gcc31-fold-const.patch.bz2 \
		gcc31-fold-const2.patch.bz2 \
		gcc31-i386-malign-double-doc.patch.bz2 \
		gcc31-libstdc++-pr6594.patch.bz2 \
		gcc31-libstdc++-pr6648.patch.bz2 \
		gcc31-libstdc++-setrlim.patch.bz2 \
		gcc31-pr6643.patch.bz2 \
		gcc31-test-rotate.patch.bz2
	do
		bzip2 -dc ${FILESDIR}/${PV}/${x} | \
			patch -p0 || die "failed with patch ${x}"
	done
	
	# SuSE patches
	bzip2 -dc ${FILESDIR}/${PV}/gcc31-i386-expand-clrstr.patch.bz2 | \
		patch -p1 || die "failed with patch gcc31-i386-expand-clrstr"

	# Mandrake patches
	# cp/lex.c (cxx_init_options): By default, don't wrap lines since the
	# C front-end operates that way, already.
	bzip2 -dc ${FILESDIR}/${PV}/gcc31-c++-diagnostic-no-line-wrapping.patch.bz2 | \
		patch -p1 || die "failed with patch gcc31-c++-diagnostic-no-line-wrapping"

	# Currently if any path is changed via the configure script, it breaks
	# installing into ${D}.  We should not patch it in src_install() with
	# absolute paths, as some modules then gets rebuild with the wrong
	# paths.  Thus we use $FAKE_ROOT.
	cd ${SORIG}
	for x in $(find . -name Makefile.in)
	do
#		cp ${x} ${x}.orig
		# Fix --datadir=
#		sed -e 's:datadir = @datadir@:datadir = $(FAKE_ROOT)@datadir@:' \
#			${x}.orig > ${x}
		cp ${x} ${x}.orig
		# Fix --with-gxx-include-dir=
		sed -e 's:gxx_include_dir = @gxx_:gxx_include_dir = $(FAKE_ROOT)@gxx_:' \
			-e 's:glibcppinstalldir = @gxx_:glibcppinstalldir = $(FAKE_ROOT)@gxx_:' \
			${x}.orig > ${x}
		rm -f ${x}.orig
	done
}

src_compile() {
	local myconf=""
	# use the system zlib!!!
	myconf="--with-system-zlib"
	if [ -z "`use build`" ]
	then
		myconf="${myconf} --enable-shared"
	else
		myconf="${myconf} --enable-languages=c"
	fi
	if [ -z "`use nls`" ] || [ "`use build`" ] ; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	#only build with a program suffix if it is not our
	#default compiler.  Also check $GCCBUILD until we got
	#compilers sorted out.
	#
	#NOTE:  for software to detirmine gcc version, it will be easier
	#       if we have gcc, gcc-3.0 and gcc-3.1, and NOT gcc-3.0.4.
	if build_multiple
	then
		myconf="${myconf} --program-suffix=${GCC_SUFFIX}"
	fi

	# gcc does not like optimization

	export CFLAGS="${CFLAGS/-O?/}"
	export CXXFLAGS="${CXXFLAGS/-O?/}"

	#build in a separate build tree
	mkdir -p ${S}
	cd ${S}

	addwrite "/dev/zero"
	${SORIG}/configure --prefix=${LOC} \
		--mandir=${LOC}/share/man \
		--infodir=${LOC}/share/info \
		--enable-shared \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--enable-threads=posix \
		--enable-long-long \
		--enable-cstdio=stdio \
		--enable-clocale=generic \
		--disable-checking \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	if [ -z "`use static`" ]
	then
		emake bootstrap-lean || die
	else
		emake LDFLAGS=-static bootstrap || die
	fi
}

src_install() {
	#make install from the build directory
	cd ${S}
	make prefix=${D}${LOC} \
		mandir=${D}${LOC}/share/man \
		infodir=${D}${LOC}/share/info \
		FAKE_ROOT=${D} \
		install || die
	
	if ! build_multiple
	then
		GCC_SUFFIX=""
	fi

	[ -e ${D}${LOC}/bin/gcc${GCC_SUFFIX} ] || die "gcc not found in ${D}"
	
	FULLPATH=${LOC}/lib/gcc-lib/${CHOST}/${PV}
	FULLPATH_D=${D}${LOC}/lib/gcc-lib/${CHOST}/${PV}
	cd ${FULLPATH_D}
	dodir /lib
	dodir /etc/env.d
	echo "LDPATH=${FULLPATH}" > ${D}/etc/env.d/05gcc${GCC_SUFFIX}
	if ! build_multiple
	then
		dosym /usr/bin/cpp /lib/cpp
		dosym gcc /usr/bin/cc
	fi

	# gcc-3.1 have a problem with the ordering of Search Directories.  For
	# instance, if you have libreadline.so in /lib, and libreadline.a in
	# /usr/lib, then it will link with libreadline.a instead of .so.  As far
	# as I can see from the source, /lib should be searched before /usr/lib,
	# and this also differs from gcc-2.95.3 and possibly 3.0.4, but ill have
	# to check on 3.0.4.  Thanks to Daniel Robbins for noticing this oddity.
	#
	# Azarah - 3 Jul 2002
	#
	cd ${FULLPATH_D}
	dosed -e "s:%{L\*} %(link_libgcc):%{L\*} -L/lib %(link_libgcc):" \
		${FULLPATH}/specs

	#make sure we dont have stuff lying around that
	#can nuke multiple versions of gcc
	if [ -z "`use build`" ]
	then
		cd ${FULLPATH_D}

		#Tell libtool files where real libraries are
		for LA in ${D}${LOC}/lib/*.la ${FULLPATH_D}/../*.la
		do
			sed -e "s:/usr/lib:${FULLPATH}:" ${LA} > ${LA}.hacked
			mv ${LA}.hacked ${LA}
			mv ${LA} ${FULLPATH_D}
		done

		#move all the libraries to version specific libdir.
		mv ${D}${LOC}/lib/*.{so,a}* ${FULLPATH_D}/../*.{so,a}* \
			${FULLPATH_D}

		#move Java headers to compiler-specific dir
		mv ${D}${LOC}/include/gc*.h ${FULLPATH_D}/include/
		mv ${D}${LOC}/include/j*.h ${FULLPATH_D}/include/
		for x in gcj gnu java javax org
		do
			mkdir -p ${FULLPATH_D}/include/${x}
			mv ${D}${LOC}/include/${x}/* ${FULLPATH_D}/include/${x}/
			rm -rf ${D}${LOC}/include/${x}
		done

		#move libgcj.spec to compiler-specific directories
		mv ${D}${LOC}/lib/libgcj.spec ${FULLPATH_D}/libgcj.spec

		#rename jar because it could clash with Kaffe's jar if this gcc is
		#primary compiler (aka don't have the -<version> extension)
		cd ${D}${LOC}/bin
		mv jar${GCC_SUFFIX} gcj-jar${GCC_SUFFIX}

		#move <cxxabi.h> to compiler-specific directories
		mv ${D}${STDCXX_INCDIR}/cxxabi.h ${FULLPATH_D}/include/

		#now fix the manpages
		cd ${D}${LOC}/share/man/man1;
		mv cpp.1 cpp${GCC_SUFFIX}.1
		mv gcov.1 gcov${GCC_SUFFIX}.1
	fi

	cd ${SORIG}
    if [ -z "`use build`" ]
    then
		cd ${SORIG}
		docinto /	
		dodoc BUGS COPYING COPYING.LIB ChangeLog GNATS README* FAQ MAINTAINERS
		docinto html
		dodoc *.html
		cd ${SORIG}/boehm-gc
		docinto boehm-gc
		dodoc ChangeLog README*
		cd ${SORIG}/gcc
		docinto gcc
		dodoc ChangeLog* COPYING* FSFChangeLog* LANGUAGES NEWS ONEWS \
			README* SERVICE
	    cd ${SORIG}/fastjar
	    docinto fastjar
	    dodoc AUTHORS CHANGES COPYING ChangeLog NEWS README
		cd ${SORIG}/libf2c
	    docinto libf2c
	    dodoc ChangeLog README TODO changes.netlib disclaimer.netlib \
			permission.netlib readme.netlib
		cd ${SORIG}/libffi
	    docinto libffi
	    dodoc ChangeLog* LICENSE README
		cd ${SORIG}/libjava
	    docinto libjava
	    dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
	    cd ${SORIG}/libiberty
	    docinto libiberty
	    dodoc ChangeLog COPYING.LIB README
	    cd ${SORIG}/libobjc
	    docinto libobjc
	    dodoc ChangeLog README* THREADS*
		cd ${SORIG}/libstdc++-v3
		docinto libstdc++-v3
		dodoc ChangeLog* README
    else
        rm -rf ${D}/usr/share/{man,info}
	fi

    # Fix ncurses b0rking
    find ${D}/ -name '*curses.h' -exec rm -f {} \;
}

pkg_postrm() {
	if [ ! -L ${ROOT}/lib/cpp ]
	then
		ln -sf /usr/bin/cpp ${ROOT}/lib/cpp
	fi
	if [ ! -L ${ROOT}/usr/bin/cc ]
	then
		ln -sf gcc ${ROOT}/usr/bin/cc
	fi
	
	# Fix ncurses b0rking (if r5 isn't unmerged)
        find /usr/lib/gcc-lib -name '*curses.h' -exec rm -f {} \;
}

