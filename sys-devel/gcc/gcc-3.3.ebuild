# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.3.ebuild,v 1.1 2003/05/18 07:41:29 azarah Exp $

IUSE="static nls bootstrap java build X"

inherit eutils flag-o-matic libtool

# Compile problems with these (bug #6641 among others)...
#filter-flags "-fno-exceptions -fomit-frame-pointer -fforce-addr"

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

# ProPolice version
#PP_VER="3_2_2"
#PP_FVER="${PP_VER//_/.}-6"

# Patch tarball support ...
#PATCH_VER="1.0"
PATCH_VER="1.1"

# Snapshot support ...
#SNAPSHOT="2002-08-12"
SNAPSHOT=""

# Branch update support ...
MAIN_BRANCH="${PV}"  # Tarball, etc used ...

#BRANCH_UPDATE="20021208"
BRANCH_UPDATE=""

if [ -z "${SNAPSHOT}" ]
then
	S="${WORKDIR}/${PN}-${MAIN_BRANCH}"
	SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/${P}/${PN}-${MAIN_BRANCH}.tar.bz2"
	
	if [ -n "${PATCH_VER}" ]
	then
		SRC_URI="${SRC_URI}
		         mirror://gentoo/${P}-patches-${PATCH_VER}.tar.bz2"
	fi

	if [ -n "${BRANCH_UPDATE}" ]
	then
		SRC_URI="${SRC_URI}
		         mirror://gentoo/${PN}-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2"
	fi
else
	S="${WORKDIR}/gcc-${SNAPSHOT//-}"
	SRC_URI="ftp://sources.redhat.com/pub/gcc/snapshots/${SNAPSHOT}/gcc-${SNAPSHOT//-}.tar.bz2"
fi
SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-athlon-hammer-branch-20030515.patch.bz2
	mirror://gentoo/${P}-manpages.tar.bz2"

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++ and java compilers"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~mips"

# Ok, this is a hairy one again, but lets assume that we
# are not cross compiling, than we want SLOT to only contain
# $PV, as people upgrading to new gcc layout will not have
# their old gcc unmerged ...
if [ "${CHOST}" == "${CCHOST}" ]
then
# GCC-3.3 is supposed to be binary compatible with 3.2..
#	SLOT="${MY_PV}"
	SLOT="3.2"
else
# GCC-3.3 is supposed to be binary compatible with 3.2..
#	SLOT="${CCHOST}-${MY_PV}"
	SLOT="${CCHOST}-3.2"
fi

DEPEND="virtual/glibc
	mips? >=sys-devel/binutils-2.13.90.0.16 : >=sys-devel/binutils-2.13.90.0.18
	>=sys-devel/gcc-config-1.3.1
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"
			  
RDEPEND="virtual/glibc
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="sys-devel/gcc-config"


chk_gcc_version() {
	# This next bit is for updating libtool linker scripts ...
	OLD_GCC_VERSION="`gcc -dumpversion`"

	if [ "${OLD_GCC_VERSION}" != "${MY_PV_FULL}" ]
	then
		echo "${OLD_GCC_VERSION}" > ${WORKDIR}/.oldgccversion
	fi

	# Did we check the version ?
	touch ${WORKDIR}/.chkgccversion
}

version_patch() {
	[ ! -f "$1" ] && return 1

	sed -e "s:@PV@:${PVR}:g" ${1} > ${T}/${1##*/}
	epatch ${T}/${1##*/}
}

src_unpack() {
	if [ -z "${SNAPSHOT}" ]
	then
		unpack ${PN}-${MAIN_BRANCH}.tar.bz2
		
		if [ -n "${PATCH_VER}" ]
		then
			unpack ${P}-patches-${PATCH_VER}.tar.bz2
		fi
	else
		unpack gcc-${SNAPSHOT//-}.tar.bz2
	fi

	if [ -n "${PP_VER}" ]
	then
		unpack protector-${PP_FVER}.tar.gz
	fi

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	echo

	# Branch update ...
	if [ -n "${BRANCH_UPDATE}" ]
	then
		epatch ${DISTDIR}/${PN}-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2
	fi

	# Merge Athlon/X86_64 Branch
	# This patch is based upon the differences in gcc cvs between
	# hammer-3_3-branch and gcc-3_3-branches and contains many
	# enhancements for regular Athlons as well as support for the
	# new Opteron chip.  Also included is a backport of the gcc-3.4
	# DFA schedular, which should provide further enhancements for
	# all platforms.  See ChangeLog.hammer for more info.
	# <dragon@gentoo.org> (15 May 2003)
	epatch ${DISTDIR}/${P}-athlon-hammer-branch-20030515.patch.bz2

	# Do bulk patches included in ${P}-patches-${PATCH_VER}.tar.bz2
	if [ -n "${PATCH_VER}" ]
	then
		epatch ${WORKDIR}/patch
	fi

	# Make gcc's version info specific to Gentoo
 	version_patch ${FILESDIR}/3.3/gcc33-gentoo-branding.patch

	if [ -n "${PP_VER}" ]
	then
		# ProPolice Stack Smashing protection - protector-3.2.2-6
		cd ${WORKDIR}
		epatch ${FILESDIR}/3.2.3/protector-3.2.2-6-PPC.patch
		cd ${S}
		epatch ${WORKDIR}/protector.dif
		epatch ${FILESDIR}/3.2.2/protector_parallel_make.patch
		cp ${WORKDIR}/protector.c ${WORKDIR}/${P}/gcc/ || die "protector.c not found"
		cp ${WORKDIR}/protector.h ${WORKDIR}/${P}/gcc/ || die "protector.h not found"
		version_patch ${FILESDIR}/3.3/gcc33-propolice-version.patch
	fi

	# Patches from Mandrake/Suse ...
	epatch ${FILESDIR}/3.2.3/gcc32-mklibgcc-serialize-crtfiles.patch
	
	# Get gcc to decreases the number of times the collector has to be run
	# by increasing its memory workspace, bug #16548.
	#
	# Updated for 3.3, change only one const now...
	# <dragon@gentoo.org> (15 May 2003)
#	epatch ${FILESDIR}/3.3/gcc33-ggc_page-speedup.patch

	# Patches from debian-arm
	if use arm
	then
#		epatch ${FILESDIR}/3.2.1/gcc32-arm-disable-mathf.patch
		epatch ${FILESDIR}/3.2.1/gcc32-arm-reload1-fix.patch
	fi

	# Install our pre generated manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		cd ${S}; unpack ${P}-manpages.tar.bz2
	fi
}

src_compile() {
	local myconf=
	local gcc_lang=
	
	if [ -z "`use build`" ]
	then
		myconf="${myconf} --enable-shared"
		gcc_lang="c,c++,ada,f77,objc"
	else
		gcc_lang="c"
	fi
	if [ -z "`use nls`" -o "`use build`" ]
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi
	if [ -n "`use java`" -a -z "`use build`" ]
	then
		gcc_lang="${gcc_lang},java"
	fi

	# Enable building of the gcj Java AWT & Swing X11 backend
	# if we have X as a use flag and are not in a build stage.
	# X11 support is still very experimental but enabling it is
	# quite innocuous...  [No, gcc is *not* linked to X11...]
	# <dragon@gentoo.org> (15 May 2003)
	if [ -n "`use java`" -a -n "`use X`" -a -z "`use build`" ]
	then
		myconf="${myconf} --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib"
		myconf="${myconf} --enable-interpreter --enable-java-awt=xlib --with-x"
	fi
 
	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc-3.3 ...
	export CFLAGS="${CFLAGS/-O?/-O2}"
	export CXXFLAGS="${CXXFLAGS/-O?/-O2}"
	export GCJFLAGS="${CFLAGS/-O?/-O2}"

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	einfo "Configuring GCC..."
	addwrite "/dev/zero"
	${S}/configure --prefix=${LOC} \
		--bindir=${BINPATH} \
		--includedir=${LIBPATH}/include \
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

	# Do not make manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then 
		find ${S} -name '*.[17]' -exec touch {} \; || :
	fi

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	einfo "Building GCC..."
	# Only build it static if we are just building the C frontend, else
	# a lot of things break because there are not libstdc++.so ....
	if [ -n "`use static`" -a "${gcc_lang}" = "c" ]
	then
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake LDFLAGS="-static" bootstrap \
			LIBPATH="${LIBPATH}" \
			BOOT_CFLAGS="${CFLAGS}" STAGE1_CFLAGS="-O" || die
		# Above FLAGS optimize and speedup build, thanks
		# to Jeff Garzik <jgarzik@mandrakesoft.com>
	else
		# Fix for our libtool-portage.patch
		S="${WORKDIR}/build" \
		emake bootstrap-lean \
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
	make prefix=${LOC} \
		bindir=${BINPATH} \
		includedir=${LIBPATH}/include \
		datadir=${DATAPATH} \
		mandir=${DATAPATH}/man \
		infodir=${DATAPATH}/info \
		LIBPATH="${LIBPATH}" \
		DESTDIR="${D}" \
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
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	
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
			[ -f ${x} -o -L ${x} ] && mv -f ${x} ${D}${LIBPATH}
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

		if [ -d ${D}${LOC}/lib/security ]
		then
			dodir /${LIBPATH}/security
			mv -f ${D}${LOC}/lib/security/* ${D}${LIBPATH}/security
			rm -rf ${D}${LOC}/lib/security
		fi

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
		for x in gcc g++ c++ g77 gcj
		do
			rm -f ${CCHOST}-${x}
			[ -f ${x} ] && ln -sf ${x} ${CCHOST}-${x}

			if [ -f ${CCHOST}-${x}-${PV} ]
			then
				rm -f ${CCHOST}-${x}-${PV}
				ln -sf ${x} ${CCHOST}-${x}-${PV}
			fi
		done
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
		dodoc COPYING COPYING.LIB ChangeLog* FAQ GNATS MAINTAINERS README
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
		dodoc ChangeLog* README TODO *.netlib
		cd ${S}/libffi
		docinto ${CCHOST}/libffi
		dodoc ChangeLog* LICENSE README
		cd ${S}/libiberty
		docinto ${CCHOST}/libiberty
		dodoc ChangeLog* COPYING.LIB README
		cd ${S}/libobjc
		docinto ${CCHOST}/libobjc
		dodoc ChangeLog* README* THREADS*
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
			dodoc AUTHORS CHANGES COPYING ChangeLog* NEWS README
			cd ${S}/libjava
			docinto ${CCHOST}/libjava
			dodoc ChangeLog* COPYING HACKING LIBGCJ_LICENSE NEWS README THANKS
		fi

		prepman ${DATAPATH}
		prepinfo ${DATAPATH}
	else
		rm -rf ${D}/usr/share/{man,info}
		rm -rf ${D}${DATAPATH}/{man,info}
	fi

	# Rather install the script, else portage with changing $FILESDIR
	# between binary and source package borks things ....
	insinto /lib/rcscripts/awk
	doins ${FILESDIR}/awk/fixlafiles.awk
	exeinto /sbin
	doexe ${FILESDIR}/fix_libtool_files.sh

	# Fix ncurses b0rking
	find ${D}/ -name '*curses.h' -exec rm -f {} \;
}

pkg_preinst() {

	if [ ! -f "${WORKDIR}/.chkgccversion" ]
	then
		chk_gcc_version
	fi

	# Make again sure that the linker "should" be able to locate
	# libstdc++.so ...
	export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	${ROOT}/sbin/ldconfig
}

pkg_postinst() {

	export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"

	if [ "${ROOT}" = "/" -a "${COMPILER}" = "gcc3" -a "${CHOST}" = "${CCHOST}" ]
	then
		gcc-config --use-portage-chost ${CCHOST}-${MY_PV_FULL}
	fi

	# Update libtool linker scripts to reference new gcc version ...
	if [ -f ${WORKDIR}/.oldgccversion -a "${ROOT}" = "/" ]
	then 
		OLD_GCC_VERSION="`cat ${WORKDIR}/.oldgccversion`"

		/sbin/fix_libtool_files.sh ${OLD_GCC_VERSION}
	fi
	
	# Fix ncurses b0rking (if r5 isn't unmerged)
	find ${ROOT}/usr/lib/gcc-lib -name '*curses.h' -exec rm -f {} \;
}

