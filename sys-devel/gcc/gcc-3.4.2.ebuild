# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.4.2.ebuild,v 1.5 2004/09/10 14:54:28 lv Exp $

IUSE="static nls bootstrap build nomultilib gcj gtk f77 objc hardened uclibc n32 n64"

inherit eutils flag-o-matic libtool gnuconfig toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie and ssp extensions"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"
LICENSE="GPL-2 LGPL-2.1"

#KEYWORDS="-* amd64 ~mips ~ppc64 ~x86 -hppa ~ppc"
KEYWORDS="-*"

# we need a proper glibc version for the Scrt1.o provided to the pie-ssp specs
# we also need at least glibc 2.3.3 20040420-r1 in order for gcc 3.4 not to nuke
# SSP in glibc.

# NOTE: we SHOULD be using at least binutils 2.15.90.0.1 everywhere for proper
# .eh_frame ld optimisation and symbol visibility support, but it hasnt been
# well tested in gentoo on any arch other than amd64!!
DEPEND="virtual/libc
	!uclibc? ( >=sys-libs/glibc-2.3.3_pre20040420-r1 )
	!uclibc? ( hardened? ( >=sys-libs/glibc-2.3.3_pre20040529 ) )
	( !sys-devel/hardened-gcc )
	>=sys-devel/binutils-2.14.90.0.8-r1
	amd64? ( >=sys-devel/binutils-2.15.90.0.1.1-r1 )
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.1
	amd64? ( !nomultilib? ( >=app-emulation/emul-linux-x86-glibc-1.1 ) )
	!build? ( gcj? ( gtk? ( >=x11-libs/gtk+-2.2 ) ) )
	!build? ( gcj? ( >=media-libs/libart_lgpl-2.1 ) )
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/libc
	!uclibc? ( >=sys-libs/glibc-2.3.3_pre20040420-r1 )
	!uclibc? ( hardened? ( >=sys-libs/glibc-2.3.3_pre20040529 ) )
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="sys-devel/gcc-config
	!n32? ( !n64? ( !uclibc? ( !build ( sys-libs/libstdc++-v3 ) ) ) )"

GENTOO_TOOLCHAIN_BASE_URI="http://dev.gentoo.org/~lv/GCC/"
PATCH_VER="1.0"
PIE_VER="8.7.6.5"
PIE_CORE="gcc-3.4.0-piepatches-v${PIE_VER}.tar.bz2"
PP_VER="3_4_1"
PP_FVER="${PP_VER//_/.}-1"
SRC_URI="$(get_gcc_src_uri)"

S="$(gcc_get_s_dir)"

PIEPATCH_EXCLUDE="upstream/04_all_gcc-3.4.0-v8.7.6.1-pie-arm-uclibc.patch.bz2"
HARDENED_GCC_WORKS="x86 sparc amd64"

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
do_filter_flags() {
	strip-flags

	# In general gcc does not like optimization, and add -O2 where
	# it is safe.  This is especially true for gcc 3.3 + 3.4
	replace-flags -O? -O2

	# -mcpu is deprecated on these archs, and possibly others
	if use amd64 || use x86 ; then
		setting="`get-flag mcpu`"
		[ ! -z "${setting}" ] && \
			replace-flags -mcpu="${setting}" -mtune="${setting}" && \
			ewarn "-mcpu is deprecated on your arch\a\a\a" && \
			epause 5
	fi

	strip-unsupported-flags

	# If we use multilib on mips, we shouldn't pass -mabi flag - it breaks
	# build of non-default-abi libraries.
	use mips && use !nomultilib && filter-flags "-mabi*"

	# Compile problems with these (bug #6641 among others)...
	#filter-flags "-fno-exceptions -fomit-frame-pointer -fforce-addr"

	export GCJFLAGS="${CFLAGS}"
}

# Ok, this is a hairy one again, but lets assume that we
# are not cross compiling, than we want SLOT to only contain
# $PV, as people upgrading to new gcc layout will not have
# their old gcc unmerged ...
# GCC 3.4 introduces a new version of libstdc++
if [ "${CHOST}" == "${CCHOST}" ]
then
	SLOT="3.4"
else
	SLOT="${CCHOST}-3.4"
fi

pkg_setup() {
	gcc_setup_variables
}

check_option_validity() {
	# Must compile for mips64-linux target if we want n32/n64 support
	case "${CCHOST}" in
		mips64-*)
		;;
		*)
		    if use n32 || use n64; then
		     eerror "n32/n64 can only be used when target host is mips64-*-linux-*";
		     die "Invalid USE flags for CCHOST ($CCHOST)";
		    fi
		;;
	esac

	#cannot have both n32 & n64 without multilib
	if use n32 && use n64 && use nomultilib; then
		eerror "Please disable nomultilib if you want to use both n32 & n64";
		die "Invalid USE flag combination";
	fi
}

chk_gcc_version() {
	# This next bit is for updating libtool linker scripts ...
	local OLD_GCC_VERSION="`gcc -dumpversion`"
	local OLD_GCC_CHOST="$(gcc -v 2>&1 | egrep '^Reading specs' |\
	                       sed -e 's:^.*/gcc[^/]*/\([^/]*\)/[0-9]\+.*$:\1:')"

	if [ "${OLD_GCC_VERSION}" != "${MY_PV_FULL}" ]
	then
		echo "${OLD_GCC_VERSION}" > "${WORKDIR}/.oldgccversion"
	fi

	if [ -n "${OLD_GCC_CHOST}" ]
	then
		if [ "${CHOST}" = "${CCHOST}" -a "${OLD_GCC_CHOST}" != "${CHOST}" ]
		then
			echo "${OLD_GCC_CHOST}" > "${WORKDIR}/.oldgccchost"
		fi
	fi

	# Did we check the version ?
	touch "${WORKDIR}/.chkgccversion"
}

src_unpack() {
	gcc_src_unpack

	# misc patches that havent made it into a patch tarball yet
	epatch ${FILESDIR}/3.4.0/gcc34-reiser4-fix.patch

	if use mips && use nomultilib; then
		use n32 && epatch ${FILESDIR}/3.4.1/gcc-3.4.1-mips-n32only.patch
		use n64 && epatch ${FILESDIR}/3.4.1/gcc-3.4.1-mips-n64only.patch
	fi

	if use amd64 && use !nomultilib ; then
		# this should hack around the GCC_NO_EXECUTABLES bug
		epatch ${FILESDIR}/3.4.1/gcc-3.4.1-glibc-is-native.patch
		cd ${S}/libstdc++-v3
		einfo "running autoreconf..."
		autoreconf
		cd ${S}
	fi

	# We dont want a multilib libjava, so lets use this hack taken from fedora
	cd ${S}
	sed -i -e 's/^all: all-redirect/ifeq (\$(MULTISUBDIR),)\nall: all-redirect\nelse\nall:\n\techo Multilib libjava build disabled\nendif/' libjava/Makefile.in
	sed -i -e 's/^install: install-redirect/ifeq (\$(MULTISUBDIR),)\ninstall: install-redirect\nelse\ninstall:\n\techo Multilib libjava install disabled\nendif/' libjava/Makefile.in
	sed -i -e 's/^check: check-redirect/ifeq (\$(MULTISUBDIR),)\ncheck: check-redirect\nelse\ncheck:\n\techo Multilib libjava check disabled\nendif/' libjava/Makefile.in
	sed -i -e 's/^all: all-recursive/ifeq (\$(MULTISUBDIR),)\nall: all-recursive\nelse\nall:\n\techo Multilib libjava build disabled\nendif/' libjava/Makefile.in
	sed -i -e 's/^install: install-recursive/ifeq (\$(MULTISUBDIR),)\ninstall: install-recursive\nelse\ninstall:\n\techo Multilib libjava install disabled\nendif/' libjava/Makefile.in
	sed -i -e 's/^check: check-recursive/ifeq (\$(MULTISUBDIR),)\ncheck: check-recursive\nelse\ncheck:\n\techo Multilib libjava check disabled\nendif/' libjava/Makefile.in
}

src_compile() {

	local myconf=

	check_option_validity

	if ! use build
	then
		GCC_LANG="c,c++"
		use f77 && GCC_LANG="${GCC_LANG},f77"
		use objc && GCC_LANG="${GCC_LANG},objc"
		use gcj && GCC_LANG="${GCC_LANG},java"
		# We do NOT want 'ADA support' in here!
		# use ada  && gcc_lang="${gcc_lang},ada"
	else
		GCC_LANG="c"
	fi

	# GTK+ is preferred over xlib in 3.4.x (xlib is unmaintained
	# right now). Much thanks to <csm@gnu.org> for the heads up.
	# Travis Tilley <lv@gentoo.org>  (11 Jul 2004)
	if ! use build && use gcj && use gtk
	then
		myconf="${myconf} --enable-java-awt=gtk"
	fi

	# Fix linking problem with c++ apps which where linked
	# against a 3.2.2 libgcc
	[ "${ARCH}" = "hppa" ] && myconf="${myconf} --enable-sjlj-exceptions"

	# Add --with-abi flags to enable respective MIPS ABIs
	case "${CCHOST}" in
	    mips*)
		use !nomultilib && myconf="${myconf} --with-abi=32"
		use n64 && myconf="${myconf} --with-abi=n64"
		use n32 && myconf="${myconf} --with-abi=n32"
	    ;;
	esac

	do_filter_flags
	einfo "CFLAGS=\"${CFLAGS}\""
	einfo "CXXFLAGS=\"${CXXFLAGS}\""
	einfo "GCJFLAGS=\"${GCJFLAGS}\""

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	# Install our pre generated manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		unpack ${P}-manpages.tar.bz2 || die "Failed to unpack man pages"
	fi

	gcc_do_configure versioned ${myconf}

	touch ${S}/gcc/c-gperf.h

	# Do not make manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		find ${WORKDIR}/build -name '*.[17]' -exec touch {} \; || :
	fi

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	einfo "Building GCC..."
	gcc_do_make
}

src_install() {
	local x=

	# Do allow symlinks in ${LOC}/lib/gcc-lib/${CHOST}/${PV}/include as
	# this can break the build.
	for x in ${WORKDIR}/build/gcc/include/*
	do
		if [ -L ${x} ]
		then
			rm -f ${x}
			continue
		fi
	done
	# Remove generated headers, as they can cause things to break
	# (ncurses, openssl, etc).
	for x in `find ${WORKDIR}/build/gcc/include/ -name '*.h'`
	do
		if grep -q 'It has been auto-edited by fixincludes from' ${x}
		then
			rm -f ${x}
		fi
	done

	einfo "Installing GCC..."
	# Do the 'make install' from the build directory
	cd ${WORKDIR}/build
	S="${WORKDIR}/build" \
	make DESTDIR="${D}" install || die

	[ -r ${D}${BINPATH}/gcc ] || die "gcc not found in ${D}"

	create_gcc_multilib_scripts

	# Because GCC 3.4 installs into the gcc directory and not the gcc-lib
	# directory, we will have to rename it in order to keep compatibility
	# with our current libtool check and gcc-config (which would be a pain
	# to fix compared to this simple mv and symlink).
	mv ${D}/${LOC}/lib/gcc ${D}/${LOC}/lib/gcc-lib
	ln -s gcc-lib ${D}/${LOC}/lib/gcc
	LIBPATH=${LIBPATH/lib\/gcc/lib\/gcc-lib}

	dodir /lib /usr/bin
	dodir /etc/env.d/gcc
	echo "PATH=\"${BINPATH}\"" > ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}

	# The LDPATH stuff is kinda iffy now that we need to provide compatibility
	# with older versions of GCC for binary apps.
	if use !nomultilib && [ "${ARCH}" = "amd64" ]
	then
		# amd64 is a bit unique because of multilib.  Add some other paths
		LDPATH="${LIBPATH}:${LIBPATH}/32"
	else
		LDPATH="${LIBPATH}"
	fi
	if [ "${BULIB}" != "" ]
	then
		LDPATH="${LDPATH}:${LOC}/lib/gcc-lib/${CCHOST}/${BULIB}"
	fi
	echo "LDPATH=\"${LDPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}

	echo "MANPATH=\"${DATAPATH}/man\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "STDCXX_INCDIR=\"${STDCXX_INCDIR##*/}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	# Also set CC and CXX
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}

	# Make sure we dont have stuff lying around that
	# can nuke multiple versions of gcc
	if ! use build
	then
		cd ${D}${LIBPATH}

		# Tell libtool files where real libraries are
		for x in ${D}${LOC}/lib/*.la ${D}${LIBPATH}/../*.la
		do
			if [ -f "${x}" ]
			then
				sed -i -e "s:/usr/lib:${LIBPATH}:" ${x}
				mv ${x} ${D}${LIBPATH}
			fi
		done

		# Move all the libraries to version specific libdir.
		for x in ${D}${LOC}/lib/*.{so,a}* ${D}${LIBPATH}/../*.{so,a}*
		do
			[ -f "${x}" -o -L "${x}" ] && mv -f ${x} ${D}${LIBPATH}
		done

		# Move Java headers to compiler-specific dir
		for x in ${D}${LOC}/include/gc*.h ${D}${LOC}/include/j*.h
		do
			[ -f "${x}" ] && mv -f ${x} ${D}${LIBPATH}/include/
		done
		for x in gcj gnu java javax org
		do
			if [ -d "${D}${LOC}/include/${x}" ]
			then
				dodir /${LIBPATH}/include/${x}
				mv -f ${D}${LOC}/include/${x}/* ${D}${LIBPATH}/include/${x}/
				rm -rf ${D}${LOC}/include/${x}
			fi
		done

		if [ -d "${D}${LOC}/lib/security" ]
		then
			dodir /${LIBPATH}/security
			mv -f ${D}${LOC}/lib/security/* ${D}${LIBPATH}/security
			rm -rf ${D}${LOC}/lib/security
		fi

		# Move libgcj.spec to compiler-specific directories
		[ -f "${D}${LOC}/lib/libgcj.spec" ] && \
			mv -f ${D}${LOC}/lib/libgcj.spec ${D}${LIBPATH}/libgcj.spec

		# Rename jar because it could clash with Kaffe's jar if this gcc is
		# primary compiler (aka don't have the -<version> extension)
		cd ${D}${LOC}/${CCHOST}/gcc-bin/${MY_PV}
		[ -f jar ] && mv -f jar gcj-jar

		# Move <cxxabi.h> to compiler-specific directories
		[ -f "${D}${STDCXX_INCDIR}/cxxabi.h" ] && \
			mv -f ${D}${STDCXX_INCDIR}/cxxabi.h ${D}${LIBPATH}/include/

		# These should be symlinks
		cd ${D}${BINPATH}
		for x in gcc g++ c++ g77 gcj
		do
			rm -f ${CCHOST}-${x}
			[ -f "${x}" ] && ln -sf ${x} ${CCHOST}-${x}

			if [ -f "${CCHOST}-${x}-${PV}" ]
			then
				rm -f ${CCHOST}-${x}-${PV}
				ln -sf ${x} ${CCHOST}-${x}-${PV}
			fi
		done
	fi

	# This one comes with binutils
	if [ -f "${D}${LOC}/lib/libiberty.a" ]
	then
		rm -f ${D}${LOC}/lib/libiberty.a
	fi
	if [ -f "${D}${LIBPATH}/libiberty.a" ]
	then
		rm -f ${D}${LIBPATH}/libiberty.a
	fi

	cd ${S}
	if ! use build
	then
		cd ${S}
		docinto /${CCHOST}
		dodoc COPYING COPYING.LIB ChangeLog* FAQ MAINTAINERS README
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
		if use f77
		then
			cd ${S}/libf2c
			docinto ${CCHOST}/libf2c
			dodoc ChangeLog* README TODO *.netlib
		fi
		cd ${S}/libffi
		docinto ${CCHOST}/libffi
		dodoc ChangeLog* LICENSE README
		cd ${S}/libiberty
		docinto ${CCHOST}/libiberty
		dodoc ChangeLog* COPYING.LIB README
		if use objc
		then
			cd ${S}/libobjc
			docinto ${CCHOST}/libobjc
			dodoc ChangeLog* README* THREADS*
		fi
		cd ${S}/libstdc++-v3
		docinto ${CCHOST}/libstdc++-v3
		dodoc ChangeLog* README
		docinto ${CCHOST}/libstdc++-v3/html
		dohtml -r -a css,diff,html,txt,xml docs/html/*
		cp -f docs/html/17_intro/[A-Z]* \
			${D}/usr/share/doc/${PF}/${DOCDESTTREE}/17_intro/

		if use gcj
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

	# multilib is a headache. we want a versioned 32bit libgcc in /lib32,
	# but that currently needs to be a symlink to where we -really- keep
	# our 32bit libraries.
	if [ -d ${D}/${LIBPATH}/../lib32 ] && use amd64 ; then
		mkdir -p ${D}/emul/linux/x86/lib/
		ln -s lib ${D}/emul/linux/x86/lib32
		ln -s ./emul/linux/x86/lib ${D}/lib32
	fi

	if [ "$CHOST" == "$CCHOST" -o "$CCHOST" == "" ] ; then
		# we want libgcc_s.so in /lib{,32,64}, NOT some funky directory where
		# it'll never be found.
		for libgcc_dir in `ls -d ${D}/${LIBPATH}/../lib*` ; do
			mkdir -p ${D}/$(basename ${libgcc_dir})
			mv ${libgcc_dir}/* ${D}/$(basename ${libgcc_dir})/
			rm -rf ${libgcc_dir}
			add_version_to_shared ${D}/$(basename ${libgcc_dir})/
		done
		# it might be here too.
		if [ -e ${D}/${LIBPATH}/libgcc_s.so ] ; then
			mkdir -p ${D}/$(get_libdir)/
			mv ${D}/${LIBPATH}/libgcc_s* ${D}/$(get_libdir)/
			# we need a libgcc_s.so
			dosym libgcc_s.so.1 /$(get_libdir)/libgcc_s.so
			add_version_to_shared ${D}/$(get_libdir)/
		fi
	fi
}

pkg_preinst() {

	if [ ! -f "${WORKDIR}/.chkgccversion" ]
	then
		chk_gcc_version
	fi

	# Make again sure that the linker "should" be able to locate
	# libstdc++.so ...
	if use !nomultilib && [ "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	${ROOT}/sbin/ldconfig
}

pkg_postinst() {

	if use !nomultilib && [ "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	if [ "${ROOT}" = "/" -a "${CHOST}" = "${CCHOST}" ]
	then
		gcc-config --use-portage-chost ${CCHOST}-${MY_PV_FULL}
	fi

	# Update libtool linker scripts to reference new gcc version ...
	if [ "${ROOT}" = "/" ] && \
	   [ -f "${WORKDIR}/.oldgccversion" -o -f "${WORKDIR}/.oldgccchost" ]
	then
		local OLD_GCC_VERSION=
		local OLD_GCC_CHOST=

		if [ -f "${WORKDIR}/.oldgccversion" ] && \
		   [ -n "$(cat "${WORKDIR}/.oldgccversion")" ]
		then
			OLD_GCC_VERSION="$(cat "${WORKDIR}/.oldgccversion")"
		else
			OLD_GCC_VERSION="${MY_PV_FULL}"
		fi

		if [ -f "${WORKDIR}/.oldgccchost" ] && \
		   [ -n "$(cat "${WORKDIR}/.oldgccchost")" ]
		then
			OLD_GCC_CHOST="--oldarch $(cat "${WORKDIR}/.oldgccchost")"
		fi

		/sbin/fix_libtool_files.sh ${OLD_GCC_VERSION} ${OLD_GCC_CHOST}
	fi
}

