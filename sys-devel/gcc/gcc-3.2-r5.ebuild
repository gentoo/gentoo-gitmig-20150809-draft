# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.2-r5.ebuild,v 1.9 2003/05/17 00:18:44 azarah Exp $

IUSE="static nls bootstrap java build"

inherit eutils flag-o-matic libtool

# Compile problems with these (bug #6641 among others)...
filter-flags "-fno-exceptions -fomit-frame-pointer"

# Recently there has been a lot of stability problem in Gentoo-land.  Many
# things can be the cause to this, but I believe that it is due to gcc3
# still having issues with optimizations, or with it not filtering bad
# combinations (protecting the user maybe from himeself) yet.
#
# This can clearly be seen in large builds like glibc, where too aggressive
# CFLAGS cause the tests to fail miserbly.
#
# Quote from Nick Jones <carpaski@gentoo.org>, who in my opinion
# knows what he is talking about:
#
#   People really shouldn't force code-specific options on... It's a
#   bad idea. The -march options aren't just to look pretty. They enable
#   options that are sensible (and include sse,mmx,3dnow when apropriate).
#
# The next command strips CFLAGS and CXXFLAGS from nearly all flags.  If
# you do not like it, comment it, but do not bugreport if you run into
# problems.
#
# <azarah@gentoo.org> (13 Oct 2002)
strip-flags

# Theoretical cross compiler support
[ ! -n "${CCHOST}" ] && export CCHOST="${CHOST}"

LOC="/usr"
MY_PV="`echo ${PV} | awk -F. '{ gsub(/_pre.*|_alpha.*/, ""); print $1 "." $2 }'`"
MY_PV_FULL="`echo ${PV} | awk '{ gsub(/_pre.*|_alpha.*/, ""); print $0 }'`"

LIBPATH="${LOC}/lib/gcc-lib/${CCHOST}/${MY_PV_FULL}"
BINPATH="${LOC}/${CCHOST}/gcc-bin/${MY_PV}"
DATAPATH="${LOC}/share/gcc-data/${CCHOST}/${MY_PV}"
# Dont install in /usr/include/g++-v3/, but in gcc internal directory.
# We will handle /usr/include/g++-v3/ with gcc-config ...
STDCXX_INCDIR="${LIBPATH}/include/g++-v${MY_PV/\.*/}"

PATCH_VER="1.0"

# Snapshot support ...
#SNAPSHOT="2002-08-12"
SNAPSHOT=""

if [ -z "${SNAPSHOT}" ]
then
	S="${WORKDIR}/${P}"
	SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${P}.tar.bz2
		mirror://gentoo/distfiles/${P}-patches-${PATCH_VER}.tar.bz2"
else
	S="${WORKDIR}/gcc-${SNAPSHOT//-}"
	SRC_URI="ftp://sources.redhat.com/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT//-}.tar.bz2"
fi

DESCRIPTION="Modern C/C++ compiler written by the GNU people"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc alpha"

# Ok, this is a hairy one again, but lets assume that we
# are not cross compiling, than we want SLOT to only contain
# $PV, as people upgrading to new gcc layout will not have
# their old gcc unmerged ...
if [ "${CHOST}" = "${CCHOST}" ]
then
	SLOT="${MY_PV}"
else
	SLOT="${CCHOST}-${MY_PV}"
fi

DEPEND="virtual/glibc
	>=sys-devel/gcc-config-1.2
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"
			  
RDEPEND="virtual/glibc
	>=sys-devel/gcc-config-1.2
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"


# Hack used to patch Makefiles to install into the build dir
FAKE_ROOT=""

src_unpack() {
	if [ -z "${SNAPSHOT}" ]
	then
		unpack ${P}.tar.bz2 ${P}-patches-${PATCH_VER}.tar.bz2
	else
		unpack gcc-${SNAPSHOT//-}.tar.bz2
	fi

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	# Do bulk patches included in ${P}-patches-${PATCH_VER}.tar.bz2
	epatch ${WORKDIR}/patch

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
	# Also for the updated patches, see:
	#
	#   http://archive.linuxfromscratch.org/mail-archives/lfs-dev/2002/08/0588.html
	#
	epatch ${FILESDIR}/${PV}/${P}.fix-copy.patch
	epatch ${FILESDIR}/${PV}/${P}.fix-var.patch

	# Fixes to get gcc to compile under glibc-2.3*
	epatch ${FILESDIR}/${PV}/${P}-glibc-2.3-compat.diff
	# This one is thanks to cretin@gentoo.org
	epatch ${FILESDIR}/${PV}/${P}.ctype.patch

	# Currently if any path is changed via the configure script, it breaks
	# installing into ${D}.  We should not patch it in src_install() with
	# absolute paths, as some modules then gets rebuild with the wrong
	# paths.  Thus we use $FAKE_ROOT.
	cd ${S}
	for x in $(find . -name Makefile.in)
	do
		# Fix --datadir=
		cp ${x} ${x}.orig
		sed -e 's:datadir = @datadir@:datadir = $(FAKE_ROOT)@datadir@:' \
			${x}.orig > ${x}
		
		# Fix --bindir=
		cp ${x} ${x}.orig
		sed -e 's:bindir = @bindir@:bindir = $(FAKE_ROOT)@bindir@:' \
			${x}.orig > ${x}
		
		# Fix --with-gxx-include-dir=
		cp ${x} ${x}.orig
		sed -e 's:gxx_include_dir = @gxx_:gxx_include_dir = $(FAKE_ROOT)@gxx_:' \
			-e 's:glibcppinstalldir = @gxx_:glibcppinstalldir = $(FAKE_ROOT)@gxx_:' \
			${x}.orig > ${x}
		
		# Where java security stuff should be installed
		cp ${x} ${x}.orig
		sed -e 's:secdir = $(libdir)/security:secdir = $(FAKE_ROOT)$(LIBPATH)/security:' \
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

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.
	export CFLAGS="${CFLAGS//-O?}"
	export CXXFLAGS="${CXXFLAGS//-O?}"

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."
	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--datadir=${DATAPATH} \
		--mandir=${DATAPATH}/man \
		--infodir=${DATAPATH}/info \
		--enable-shared \
		--host=${CHOST} \
		--target=${CCHOST} \
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

	einfo "Building GCC..."
	if [ -z "`use static`" ]
	then
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake bootstrap-lean \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
		# Above FLAGS optimize and speedup build, thanks
		# to Jeff Garzik <jgarzik@mandrakesoft.com>
	else
		S="${WORKDIR}/build" \
		emake LDFLAGS=-static bootstrap \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
	fi
}

src_install() {
	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in cd ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
		fi
	done

	einfo "Installing GCC..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make prefix=${D}${LOC} \
		bindir=${D}${BINPATH} \
		datadir=${D}${DATAPATH} \
		mandir=${D}${DATAPATH}/man \
		infodir=${D}${DATAPATH}/info \
		LIBPATH="${LIBPATH}" \
		FAKE_ROOT="${D}" \
		install || die
	
	[ -r ${D}${BINPATH}/gcc ] || die "gcc not found in ${D}"
	
	dodir /lib /usr/bin
	dodir /etc/env.d/gcc
	echo "PATH=\"${BINPATH}\"" > ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "LDPATH=\"${LIBPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "MANPATH=\"${DATAPATH}/man\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "STDCXX_INCDIR=\"${STDCXX_INCDIR##*/}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	# Also set CC and CXX
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/05gcc
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/05gcc
	
	# Dummies to get CONTENTS right .. will handle with gcc-config
	touch ${D}/lib/cpp
	touch ${D}/usr/bin/cc
	
# This should be invalidated by the linker scripts we have as the latest
# fix for bug #4411
#
#	# gcc-3.1 have a problem with the ordering of Search Directories.  For
#	# instance, if you have libreadline.so in /lib, and libreadline.a in
#	# /usr/lib, then it will link with libreadline.a instead of .so.  As far
#	# as I can see from the source, /lib should be searched before /usr/lib,
#	# and this also differs from gcc-2.95.3 and possibly 3.0.4, but ill have
#	# to check on 3.0.4.  Thanks to Daniel Robbins for noticing this oddity,
#	# bugzilla bug #4411
#	#
#	# Azarah - 3 Jul 2002
#	#
#	cd ${D}${LIBPATH}
#	dosed -e "s:%{L\*} %(link_libgcc):%{L\*} -L/lib %(link_libgcc):" \
#		${LIBPATH}/specs

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	if [ -z "`use build`" ]
	then
		cd ${D}${LIBPATH}

		# Tell libtool files where real libraries are
		for LA in ${D}${LOC}/lib/*.la ${D}${LIBPATH}/../*.la
		do
			if [ -f ${LA} ]
			then
				sed -e "s:/usr/lib:${LIBPATH}:" ${LA} > ${LA}.hacked
				mv ${LA}.hacked ${LA}
				mv ${LA} ${D}${LIBPATH}
			fi
		done

		# Move all the libraries to version specific libdir.
		for x in ${D}${LOC}/lib/*.{so,a}* ${D}${LIBPATH}/../*.{so,a}*
		do
			[ -f ${x} ] && mv -f ${x} ${D}${LIBPATH}
		done

		# Move Java headers to compiler-specific dir
		for x in ${D}${LOC}/include/gc*.h ${D}${LOC}/include/j*.h
		do
			[ -f ${x} ] && mv -f ${x} ${D}${LIBPATH}/include/
		done
		for x in gcj gnu java javax org
		do
			if [ -d ${D}${LOC}/include/${x} ]
			then
				dodir /${LIBPATH}/include/${x}
				mv -f ${D}${LOC}/include/${x}/* ${D}${LIBPATH}/include/${x}/
				rm -rf ${D}${LOC}/include/${x}
			fi
		done

		# Move libgcj.spec to compiler-specific directories
		[ -f ${D}${LOC}/lib/libgcj.spec ] && \
			mv -f ${D}${LOC}/lib/libgcj.spec ${D}${LIBPATH}/libgcj.spec

		# Rename jar because it could clash with Kaffe's jar if this gcc is
		# primary compiler (aka don't have the -<version> extension)
		cd ${D}${LOC}/${CCHOST}/gcc-bin/${MY_PV}
		[ -f jar ] && mv -f jar gcj-jar

		# Move <cxxabi.h> to compiler-specific directories
		[ -f ${D}${STDCXX_INCDIR}/cxxabi.h ] && \
			mv -f ${D}${STDCXX_INCDIR}/cxxabi.h ${D}${LIBPATH}/include/

		# These should be symlinks
		cd ${D}${BINPATH}
		rm -f ${CCHOST}-{gcc,g++,c++,g77}
		[ -f gcc ] && ln -sf gcc ${CCHOST}-gcc
		[ -f g++ ] && ln -sf g++ ${CCHOST}-g++
		[ -f g++ ] && ln -sf g++ ${CCHOST}-c++
		[ -f g77 ] && ln -sf g77 ${CCHOST}-g77
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
		docinto /${CCHOST}
		dodoc COPYING COPYING.LIB ChangeLog FAQ GNATS MAINTAINERS README
		docinto ${CCHOST}/html
		dohtml *.html
		cd ${S}/boehm-gc
		docinto ${CCHOST}/boehm-gc
		dodoc ChangeLog doc/{README*,barrett_diagram}
		docinto ${CCHOST}/boehm-gc/html
		dohtml doc/*.html
		cd ${S}/gcc
		docinto ${CCHOST}/gcc
		dodoc ChangeLog* FSFChangeLog* LANGUAGES NEWS ONEWS README* SERVICE
		cd ${S}/libf2c
	    docinto ${CCHOST}/libf2c
	    dodoc ChangeLog README TODO *.netlib
		cd ${S}/libffi
	    docinto ${CCHOST}/libffi
	    dodoc ChangeLog* LICENSE README
	    cd ${S}/libiberty
	    docinto ${CCHOST}/libiberty
	    dodoc ChangeLog COPYING.LIB README
	    cd ${S}/libobjc
	    docinto ${CCHOST}/libobjc
	    dodoc ChangeLog README* THREADS*
		cd ${S}/libstdc++-v3
		docinto ${CCHOST}/libstdc++-v3
		dodoc ChangeLog* README
		docinto ${CCHOST}/libstdc++-v3/html
		dohtml -r -a css,diff,html,txt,xml docs/html/*
		cp -f docs/html/17_intro/[A-Z]* \
			${D}/usr/share/doc/${PF}/${DOCDESTTREE}/17_intro/
		
        if [ -n "`use java`" ]
        then
			cd ${S}/fastjar
			docinto ${CCHOST}/fastjar
			dodoc AUTHORS CHANGES COPYING ChangeLog NEWS README
			cd ${S}/libjava
			docinto ${CCHOST}/libjava
			dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
        fi
    else
        rm -rf ${D}/usr/share/{man,info}
	fi

    # Fix ncurses b0rking
    find ${D}/ -name '*curses.h' -exec rm -f {} \;
}

pkg_postinst() {

	if [ "${ROOT}" = "/" -a "${COMPILER}" = "gcc3" ]
	then
		gcc-config --use-portage-chost ${CCHOST}-${MY_PV_FULL}
	fi
	
	# Fix ncurses b0rking (if r5 isn't unmerged)
	find ${ROOT}/usr/lib/gcc-lib -name '*curses.h' -exec rm -f {} \;
}

