# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Grant Goodyear <g2boojum@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.1.ebuild,v 1.1 2002/05/17 15:42:30 prez Exp

# NOTE TO MAINTAINER:  Info pages get nuked for multiple version installs.
#                      Ill fix it later if i get a chance.
#
# IMPORTANT:  The versions of libs installed should be updated
#             in src_install() ... Ill implement auto-version detection
#             later on.

GCC_SUFFIX=-3.1
LOC=/usr
# dont install in /usr/include/g++-v3/, as it will nuke gcc-3.0.x installs
STDCXX_INCDIR="${LOC}/include/g++-v${PV/\./}"
SLOT="3.1"
S=${WORKDIR}/${P}
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.bz2
	ftp://ftp.funet.fi/pub/mirrors/sourceware.cygnus.com/pub/gcc/releases/${P}/${P}.tar.bz2"
DESCRIPTION="Modern GCC C/C++ compiler and an included, upgraded version of texinfo to boot"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc 
	>=sys-libs/zlib-1.1.4"
if [ -z "`use build`" ]
then
	DEPEND="$DEPEND 
		nls? ( sys-devel/gettext ) 
		>=sys-libs/ncurses-5.2-r2"
	RDEPEND="$RDEPEND 
		>=sys-libs/ncurses-5.2-r2"
fi

build_multiple() {
	#try to make sure that we should build multiple
	#versions of gcc (dual install of gcc2 and gcc3)
	profile="`readlink /etc/make.profile`"
	if [ -z "`use build`" ] && \
	   [ -z "`use bootstrap`" ] && \
	   [ "`gcc --version | cut -f1 -d.`" -ne 3 ] && \
	   [ "${profile/gcc3}" = "${profile}" ] && \
	   [ "${GCCBUILD}" != "default" ]
	then
		return 0
	else
		return 1
	fi	  
}

src_unpack() {
	unpack ${P}.tar.bz2
	
	#now we integrate texinfo-${TV} into gcc.  It comes with texinfo-3.12.
	cd ${S}
	#fixes the build system to properly do the transformation
	#of the binaries (thanks to Mandrake)
	#fixup libtool to correctly generate .la files with portage
	patch <${FILESDIR}/libtool-1.4.1-portage.patch-v3 || die

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
	cd ${WORKDIR}
	mkdir build
	cd build

	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--mandir=${LOC}/share/man \
		--infodir=${LOC}/share/info \
		--datadir=${LOC}/share/gcc-${PV} \
		--enable-shared \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--enable-threads=posix \
		--enable-long-long \
		--enable-cstdio=stdio \
		--enable-clocale=generic \
		--disable-checking \
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

#thanks to mandrake for this function
dispatch_libs() {
	libname=$1 libversion=$2
	rm -f $libname.so $libname.a

	if build_multiple
	then
	# If we have multiple versions of GCC, leave libraries in $FULLPATH
		chmod 0755 ../../../$libname.so.$libversion
		ln -s ../../../$libname.so.$libversion $libname.so
		rm -f ../../../$libname.so
		cp -f ../../../$libname.a $libname.a
		rm -f ../../../$libname.a
	else
		ln -sf ../../../$libname.so $libname.so
		ln -sf ../../../$libname.a $libname.a
	fi
}

src_install() {
	#fix Makefile to properly install libgcj.jar and not
	#generate a sandbox error.
	cd ${WORKDIR}/build/${CHOST}
	for x in `find . -name "Makefile"`; do
	    cp $x $x.orig
	    sed -e "s:datadir = /usr/share:datadir = ${D}/usr/share:" \
			-e "s:gxx_include_dir = /usr:gxx_include_dir = ${D}/usr:" \
			-e "s:glibcppinstalldir = /usr:glibcppinstalldir = ${D}/usr:" \
		$x.orig >$x
	done
	
	#make install from the build directory
	cd ${WORKDIR}/build
	make prefix=${D}${LOC} \
		mandir=${D}${LOC}/share/man \
		infodir=${D}${LOC}/share/info \
		datadir=${D}${LOC}/share/gcc-${PV} \
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
	dosym /usr/bin/cpp /lib/cpp
	dosym gcc /usr/bin/cc

	#make sure we dont have stuff lying around that
	#can nuke multiple versions of gcc
	if [ -z "`use build`" ]
	then
		cd ${FULLPATH_D}
		#move symlinks to compiler-specific dir
		dispatch_libs libstdc++  4.0.0
		mv ../../../libsupc++.a libsupc++.a
		
		dispatch_libs libgcj     3.0.0
		dispatch_libs libgcjgc   1.1.0
		#do not always get created.
		[ ! -e libgcjgc.so ] && rm -f libgcjgc.so
		
		dispatch_libs libg2c     0.0.0
		mv ../../../libfrtbegin.a libfrtbegin.a
		
		mv libobjc* ../../../
		dispatch_libs libobjc    1.0.0
		dispatch_libs libobjc_gc 1.0.0
		#do not always get created.
		[ ! -e libobjc_gc.so ] && rm -f libobjc_gc.so

		if build_multiple
		then
			#move libtool .la files to $FULLPATH till I figure
			#what to do with them. This needs to be done with
			#parallel installs, else gcc-2.95 tries to link with
			#the wrong libs.
			mv ${D}${LOC}/lib/*.la ${FULLPATH_D}
		fi

		#move Java headers to compiler-specific dir
		mv ${D}${LOC}/include/j*.h ${FULLPATH_D}/include/
		mv ${D}${LOC}/include/{gcj,gnu,java} ${FULLPATH_D}/include/

		#move libgcj.spec to compiler-specific directories
		mv ${D}${LOC}/lib/libgcj.spec ${FULLPATH_D}/libgcj.spec

		#there is already one with binutils
		mv ${D}${LOC}/lib/libiberty.a ${FULLPATH_D}/libiberty.a

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

	#move libgcc_s.so.1 to /lib
	cd ${D}/lib
	chmod +x ${D}${LOC}/lib/libgcc_s.so.1
	mv -f ${D}${LOC}/lib/libgcc_s.so.1 libgcc_s-${PV}.so.1
	ln -sf libgcc_s-${PV}.so.1 libgcc_s.so.1
	ln -sf libgcc_s.so.1 libgcc_s.so
	rm -f ${D}${LOC}/lib/libgcc_s.so*

	cd ${S}
    if [ -z "`use build`" ]
    then
		cd ${S}
		docinto /	
		dodoc BUGS COPYING COPYING.LIB ChangeLog GNATS README* FAQ MAINTAINERS
		docinto html
		dodoc *.html
		cd ${S}/boehm-gc
		docinto boehm-gc
		dodoc ChangeLog README*
		cd ${S}/gcc
		docinto gcc
		dodoc ChangeLog* COPYING* FSFChangeLog* LANGUAGES NEWS ONEWS \
			README* SERVICE
	    cd ${S}/fastjar
	    docinto fastjar
	    dodoc AUTHORS CHANGES COPYING ChangeLog NEWS README
		cd ${S}/libf2c
	    docinto libf2c
	    dodoc ChangeLog README TODO changes.netlib disclaimer.netlib \
			permission.netlib readme.netlib
		cd ${S}/libffi
	    docinto libffi
	    dodoc ChangeLog* LICENSE README
		cd ${S}/libjava
	    docinto libjava
	    dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
	    cd ${S}/libiberty
	    docinto libiberty
	    dodoc ChangeLog COPYING.LIB README
	    cd ${S}/libobjc
	    docinto libobjc
	    dodoc ChangeLog README* THREADS*
		cd ${S}/libstdc++-v3
		docinto libstdc++-v3
		dodoc ChangeLog* README
    else
        rm -rf ${D}/usr/share/{man,info}
	fi
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
}

