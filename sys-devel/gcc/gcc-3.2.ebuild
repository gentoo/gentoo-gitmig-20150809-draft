# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.2.ebuild,v 1.3 2002/08/17 20:37:51 gerk Exp $

# NOTE TO MAINTAINER:  Info pages get nuked for multiple version installs.
#                      Ill fix it later if i get a chance.

inherit flag-o-matic libtool

# Compile problems with these ...
filter-flags "-fno-exceptions"

LOC="/usr"
MY_PV="`echo ${PV/_pre} | cut -d. -f1,2`"
GCC_SUFFIX="-${MY_PV}"
# Dont install in /usr/include/g++-v3/, as it will nuke gcc-3.0.x installs
STDCXX_INCDIR="${LOC}/include/g++-v${MY_PV/\./}"

# Snapshot support ...
#SNAPSHOT="2002-08-12"
SNAPSHOT=""
if [ -z "${SNAPSHOT}" ]
then
	S="${WORKDIR}/${P}"
	SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.bz2"
else
	S="${WORKDIR}/gcc-${SNAPSHOT//-}"
	SRC_URI="ftp://ftp.mirror.ac.uk/sites/sources.redhat.com/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT//-}.tar.bz2"
fi

DESCRIPTION="Modern GCC C/C++ compiler"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
SLOT="${MY_PV}"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"
			  
RDEPEND="virtual/glibc 
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"


build_multiple() {
	# Try to make sure that we should build multiple
	# versions of gcc (dual install of gcc2 and gcc3)
	profile="`readlink /etc/make.profile`"
	# [ "`gcc -dumpversion | cut -d. -f1,2`" != "`echo ${PV} | cut -d. -f1,2`" ]
	#
	# Check the major and minor versions only, and drop the micro version.
	# This is done, as compadibility only differ when major and minor differ.
	if [ -z "`use build`" ] && \
	   [ -z "`use bootstrap`" ] && \
	   [ "`gcc -dumpversion | cut -d. -f1,2`" != "${MY_PV}" ] && \
	   [ "${profile/gcc3}" = "${profile}" ] && \
	   [ "${GCCBUILD}" != "default" ]
	then
		return 0
	else
		return 1
	fi	  
}

# Used to patch Makefiles to install into the build dir
FAKE_ROOT=""

src_unpack() {
	if [ -z "${SNAPSHOT}" ]
	then
		unpack ${P}.tar.bz2
	else
		unpack gcc-${SNAPSHOT//-}.tar.bz2
	fi

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow
	
	# Fixes a bug in gcc-3.1 and above ... -maccumulate-outgoing-args flag (added
	# in gcc-3.1) causes gcc to misconstruct the function call frame in many cases.
	# Thanks to Ronald Hummelink <ronald@hummelink.xs4all.nl> for bringing it to
	# our attention.
	#
	#   http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/
	#   http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/0319.html
	#   http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/0350.html
	#   http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/0410.html
	#   http://gcc.gnu.org/ml/gcc/2002-08/msg00731.html
	#
	cd ${S}; patch -p0 < ${FILESDIR}/gcc-3-deopt.patch || die

	# Currently if any path is changed via the configure script, it breaks
	# installing into ${D}.  We should not patch it in src_install() with
	# absolute paths, as some modules then gets rebuild with the wrong
	# paths.  Thus we use $FAKE_ROOT.
	cd ${S}
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
	local gcc_lang=""
	if [ -z "`use build`" ]
	then
		myconf="${myconf} --enable-shared"
		gcc_lang="c,c++,ada,f77,objc"
	else
		gcc_lang="c"
	fi
	if [ -z "`use nls`" ] || [ "`use build`" ]
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi
	if [ -n "`use java`" ] && [ -z "`use build`" ]
	then
		gcc_lang="${gcc_lang},java"
	fi

	# Only build with a program suffix if it is not our
	# default compiler.  Also check $GCCBUILD until we got
	# compilers sorted out.
	#
	# NOTE:  for software to detirmine gcc version, it will be easier
	#        if we have gcc, gcc-3.0 and gcc-3.1, and NOT gcc-3.0.4.
	if build_multiple
	then
		myconf="${myconf} --program-suffix=${GCC_SUFFIX}"
	fi

	# In general gcc does not like optimization
	export CFLAGS="${CFLAGS//-O?}"
	export CXXFLAGS="${CXXFLAGS//-O?}"

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--mandir=${LOC}/share/man \
		--infodir=${LOC}/share/info \
		--enable-shared \
		--host=${CHOST} \
		--build=${CHOST} \
		--target=${CHOST} \
		--with-system-zlib \
		--enable-languages=${gcc_lang} \
		--enable-threads=posix \
		--enable-long-long \
		--disable-checking \
		--enable-cstdio=stdio \
		--enable-clocale=generic \
		--enable-__cxa_atexit \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	touch ${S}/gcc/c-gperf.h

	if [ -z "`use static`" ]
	then
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake bootstrap-lean || die
	else
		S="${WORKDIR}/build" \
		emake LDFLAGS=-static bootstrap || die
	fi

	# Fixes the manpage for the "-maccumulate-outgoing-args bug"
	cd ${S}; patch -p0 < ${FILESDIR}/gcc-3-deopt-doc.patch || die
}

src_install() {
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
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
	
	FULLPATH=${LOC}/lib/gcc-lib/${CHOST}/${PV/_pre}
	FULLPATH_D=${D}${LOC}/lib/gcc-lib/${CHOST}/${PV/_pre}
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
	# to check on 3.0.4.  Thanks to Daniel Robbins for noticing this oddity,
	# bugzilla bug #4411
	#
	# Azarah - 3 Jul 2002
	#
	cd ${FULLPATH_D}
	dosed -e "s:%{L\*} %(link_libgcc):%{L\*} -L/lib %(link_libgcc):" \
		${FULLPATH}/specs

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	if [ -z "`use build`" ]
	then
		cd ${FULLPATH_D}

		# Tell libtool files where real libraries are
		for LA in ${D}${LOC}/lib/*.la ${FULLPATH_D}/../*.la
		do
			if [ -f ${LA} ]
			then
				sed -e "s:/usr/lib:${FULLPATH}:" ${LA} > ${LA}.hacked
				mv ${LA}.hacked ${LA}
				mv ${LA} ${FULLPATH_D}
			fi
		done

		# Move all the libraries to version specific libdir.
		for x in ${D}${LOC}/lib/*.{so,a}* ${FULLPATH_D}/../*.{so,a}*
		do
			[ -f ${x} ] && mv -f ${x} ${FULLPATH_D}
		done

		# Move Java headers to compiler-specific dir
		for x in ${D}${LOC}/include/gc*.h ${D}${LOC}/include/j*.h
		do
			[ -f ${x} ] && mv -f ${x} ${FULLPATH_D}/include/
		done
		for x in gcj gnu java javax org
		do
			if [ -d ${D}${LOC}/include/${x} ]
			then
				mkdir -p ${FULLPATH_D}/include/${x}
				mv -f ${D}${LOC}/include/${x}/* ${FULLPATH_D}/include/${x}/
				rm -rf ${D}${LOC}/include/${x}
			fi
		done

		# Move libgcj.spec to compiler-specific directories
		[ -f ${D}${LOC}/lib/libgcj.spec ] && \
			mv -f ${D}${LOC}/lib/libgcj.spec ${FULLPATH_D}/libgcj.spec

		# Rename jar because it could clash with Kaffe's jar if this gcc is
		# primary compiler (aka don't have the -<version> extension)
		cd ${D}${LOC}/bin
		[ -f jar${GCC_SUFFIX} ] && mv -f jar${GCC_SUFFIX} gcj-jar${GCC_SUFFIX}

		# Move <cxxabi.h> to compiler-specific directories
		[ -f ${D}${STDCXX_INCDIR}/cxxabi.h ] && \
			mv -f ${D}${STDCXX_INCDIR}/cxxabi.h ${FULLPATH_D}/include/

		if build_multiple
		then
			# Now fix the manpages
			cd ${D}${LOC}/share/man/man1
			mv cpp.1 cpp${GCC_SUFFIX}.1
			mv gcov.1 gcov${GCC_SUFFIX}.1
		fi
	fi

	# This one comes with binutils
	if [ -f ${D}${LOC}/lib/libiberty.a ]
	then
		rm -f ${D}${LOC}/lib/libiberty.a
	fi

	cd ${S}
    if [ -z "`use build`" ]
    then
		cd ${S}
		docinto /	
		dodoc COPYING COPYING.LIB ChangeLog FAQ GNATS MAINTAINERS README
		docinto html
		dohtml *.html
		cd ${S}/boehm-gc
		docinto boehm-gc
		dodoc ChangeLog doc/{README*,barrett_diagram}
		docinto boehm-gc/html
		dohtml doc/*.html
		cd ${S}/gcc
		docinto gcc
		dodoc ChangeLog* FSFChangeLog* LANGUAGES NEWS ONEWS README* SERVICE
		cd ${S}/libf2c
	    docinto libf2c
	    dodoc ChangeLog README TODO *.netlib
		cd ${S}/libffi
	    docinto libffi
	    dodoc ChangeLog* LICENSE README
	    cd ${S}/libiberty
	    docinto libiberty
	    dodoc ChangeLog COPYING.LIB README
	    cd ${S}/libobjc
	    docinto libobjc
	    dodoc ChangeLog README* THREADS*
		cd ${S}/libstdc++-v3
		docinto libstdc++-v3
		dodoc ChangeLog* README
		docinto libstdc++-v3/html
		dohtml -r -a css,diff,html,txt,xml docs/html/*
		cp -f docs/html/17_intro/[A-Z]* \
			${D}/usr/share/doc/${PF}/${DOCDESTTREE}/17_intro/
		
        if [ -n "`use java`" ]
        then
			cd ${S}/fastjar
			docinto fastjar
			dodoc AUTHORS CHANGES COPYING ChangeLog NEWS README
			cd ${S}/libjava
			docinto libjava
			dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
        fi
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
	find ${ROOT}/usr/lib/gcc-lib -name '*curses.h' -exec rm -f {} \;
}

