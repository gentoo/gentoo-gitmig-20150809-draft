# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-3.3.4.ebuild,v 1.8 2004/07/20 18:33:46 vapier Exp $

inherit eutils flag-o-matic libtool gnuconfig

# The next command strips most flags from CFLAGS/CXXFLAGS.  If you do 
# not like it, comment it out, but do not file bugreports if you run into
# problems.
do_filter_flags() {
	strip-flags

	# In general gcc does not like optimization ... we'll add -O2 where safe
	filter-flags -O?

	# Compile problems with these (bug #6641 among others)...
	#filter-flags -fno-exceptions -fomit-frame-pointer -fforce-addr
}

# gcc produce unstable binaries if compiled with a different CHOST.
[ "${ARCH}" = "hppa" ] && export CHOST="hppa-unknown-linux-gnu"

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

# PIE support
PIE_VER=

# ProPolice version
PP_VER="3_3_2"
PP_FVER="${PP_VER//_/.}-2"

# Patch tarball support ...
#PATCH_VER="1.0"
PATCH_VER="1.0"

# Snapshot support ...
#SNAPSHOT="2002-08-12"
SNAPSHOT=

# Branch update support ...
MAIN_BRANCH="${PV}"  # Tarball, etc used ...

#BRANCH_UPDATE="20040412"
BRANCH_UPDATE=

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
if [ -n "${PP_VER}" ]
then
	SRC_URI="${SRC_URI}
		http://www.research.ibm.com/trl/projects/security/ssp/gcc${PP_VER}/protector-${PP_FVER}.tar.gz"
fi
# bug #6148 - the bounds checking patch interferes with gcc.c
if [ -n "${PIE_VER}" ]
then
	SRC_URI="${SRC_URI} mirror://gentoo/gcc-3.3.3-piepatches-v${PIE_VER}.tar.bz2"
fi
SRC_URI="${SRC_URI}
	mirror://gentoo/${P}-manpages.tar.bz2"

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie and ssp extentions"
HOMEPAGE="http://www.gnu.org/software/gcc/gcc.html"

LICENSE="GPL-2 LGPL-2.1"
## SpanKY says hppa is a no go with any 3.3.x
## desired KEYWORDS="~sparc ~x86"
## KEYWORDS="-* -hppa arm ~x86 ~sparc ~amd64"
KEYWORDS="-*"
IUSE="static nls bootstrap build X multilib gcj f77 objc pic hardened uclibc debug"

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

# We need the later binutils for support of the new cleanup attribute.
# 'make check' fails for about 10 tests (if I remember correctly) less
# if we use later bison.
# This one depends on glibc-2.3.2-r3 containing the __guard in glibc
# we scan for Guard@@libgcc and then apply the function moving patch.
# If using NPTL, we currently cannot however depend on glibc-2.3.2-r3,
# else bootstap will break.

# we need a proper glibc version for the Scrt1.o provided to the pie-ssp specs
DEPEND="virtual/libc
	!uclibc? ( !nptl? ( >=sys-libs/glibc-2.3.2-r3 ) )
	!uclibc? ( hardened? ( >=sys-libs/glibc-2.3.2-r9 ) )
	( !sys-devel/hardened-gcc )
	>=sys-devel/binutils-2.14.90.0.6-r1
	>=sys-devel/bison-1.875
	>=sys-devel/gcc-config-1.3.6
	amd64? ( multilib? ( >=app-emulation/emul-linux-x86-baselibs-1.0 ) )
	!build? ( >=sys-libs/ncurses-5.2-r2
	          nls? ( sys-devel/gettext ) )"

RDEPEND="virtual/libc
	!uclibc? ( !nptl? ( >=sys-libs/glibc-2.3.2-r3 ) )
	!uclibc? ( hardened? ( >=sys-libs/glibc-2.3.2-r9 ) )
	>=sys-devel/gcc-config-1.3.1
	>=sys-libs/zlib-1.1.4
	>=sys-apps/texinfo-4.2-r4
	!build? ( >=sys-libs/ncurses-5.2-r2 )"

PDEPEND="sys-devel/gcc-config"


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

version_patch() {
	[ ! -f "$1" ] && return 1
	[ -z "$2" ] && return 1

	sed -e "s:@GENTOO@:$2:g" ${1} > ${T}/${1##*/}
	epatch ${T}/${1##*/}
}

glibc_have_ssp() {
	use uclibc \
		&& local my_libc="${ROOT}/lib/libc.so.0" \
		|| local my_libc="${ROOT}/lib/libc.so.6"

# Not necessary. lib64 is a symlink to /lib. -- avenj@gentoo.org  3 Apr 04
#	case "${ARCH}" in
#		"amd64")
#			my_libc="${ROOT}/lib64/libc.so.?"
#			;;
#	esac

	# Check for the glibc to have the __guard symbols
	if  [ "$(readelf -s "${my_libc}" 2>/dev/null | \
	         grep GLOBAL | grep OBJECT | grep '__guard')" ] && \
	    [ "$(readelf -s "${my_libc}" 2>/dev/null | \
	         grep GLOBAL | grep FUNC | grep '__stack_smash_handler')" ]
	then
		return 0
	else
		return 1
	fi
}

glibc_have_pie() {
	if [ ! -f ${ROOT}/usr/lib/Scrt1.o ] ; then
		echo
		ewarn "Your glibc does not have support for pie, the file Scrt1.o is missing"
		ewarn "Please update your glibc to a proper version or disable hardened"
		echo
		return 1
	fi
}

check_glibc_ssp() {
	if glibc_have_ssp
	then
		if [ -n "${GLIBC_SSP_CHECKED}" ] && \
		   [ -z "$(readelf -s  "${ROOT}/$(gcc-config -L)/libgcc_s.so" 2>/dev/null | \
		           grep 'GLOBAL' | grep 'OBJECT' | grep '__guard')" ]
		then
			# No need to check again ...
			return 0
		fi

		echo
		ewarn "This sys-libs/glibc has __guard object and __stack_smash_handler functions"
		ewarn "scanning the system for binaries with __guard - this may take 5-10 minutes"
		ewarn "Please do not press ctrl-C or ctrl-Z during this period - it will continue"
		echo
		if ! bash ${FILESDIR}/scan_libgcc_linked_ssp.sh
		then
			echo
			eerror "Found binaries that are dynamically linked to the libgcc with __guard@@GCC"
			eerror "You need to compile these binaries without CFLAGS -fstack-protector/hcc -r"
			echo
			eerror "Also, you have to make sure that using ccache needs the cache to be flushed"
			eerror "wipe out /var/tmp/ccache or /root/.ccache.  This will remove possible saved"
			eerror "-fstack-protector arguments that still may reside in such a compiler cache"
			echo
			eerror "When such binaries are found, gcc cannot remove libgcc propolice functions"
			eerror "leading to gcc -static -fstack-protector breaking, see gentoo bug #25299"
			echo
			einfo  "To do a full scan on your system, enter this following command in a shell"
			einfo  "(Please keep running and remerging broken packages until it do not report"
			einfo  " any breakage anymore!):"
			echo
			einfo  " # ${FILESDIR}/scan_libgcc_linked_ssp.sh"
			echo
			die "Binaries with libgcc __guard@GCC dependencies detected!"
		else
			echo
			einfo "No binaries with suspicious libgcc __guard@GCC dependencies detected"
			echo
		fi
	fi

	return 0
}

update_gcc_for_libc_ssp() {
	if glibc_have_ssp
	then
		einfo "Updating gcc to use SSP from glibc..."
		sed -e 's|^\(LIBGCC2_CFLAGS.*\)$|\1 -D_LIBC_PROVIDES_SSP_|' \
			-i ${S}/gcc/Makefile.in || die "Failed to update gcc!"
	fi
}

src_unpack() {
	local release_version="Gentoo Linux ${PVR}"

	if [ -n "${PP_VER}" ] && [ "${ARCH}" != "hppa" ]
	then
		# the guard check should be very early in the unpack process
		check_glibc_ssp
	fi

	[ -n "${PIE_VER}" ] && use hardened && glibc_have_pie

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

	if [ -n "${PIE_VER}" ]
	then
		unpack ${PIE_CORE}
	fi

	cd ${S}
	# Fixup libtool to correctly generate .la files with portage
	elibtoolize --portage --shallow

	# Branch update ...
	if [ -n "${BRANCH_UPDATE}" ]
	then
		epatch ${DISTDIR}/${PN}-${MAIN_BRANCH}-branch-update-${BRANCH_UPDATE}.patch.bz2
	fi

	# Do bulk patches included in ${P}-patches-${PATCH_VER}.tar.bz2
	if [ -n "${PATCH_VER}" ]
	then
		mkdir -p ${WORKDIR}/patch/exclude
		mv -f ${WORKDIR}/patch/16* ${WORKDIR}/patch/exclude/

		if use multilib && [ "${ARCH}" = "amd64" ]
		then
			mv -f ${WORKDIR}/patch/06* ${WORKDIR}/patch/exclude/
			bzip2 -c ${FILESDIR}/gcc331_use_multilib.amd64.patch > \
				${WORKDIR}/patch/06_amd64_gcc331-use-multilib.patch.bz2
		fi

		epatch ${WORKDIR}/patch
		mv ${S}/gcc-3.3.2/libstdc++-v3/config/os/uclibc ${S}/libstdc++-v3/config/os/ || die
		mv ${S}/gcc-3.3.2/libstdc++-v3/config/locale/uclibc ${S}/libstdc++-v3/config/locale/ || die
		use uclibc && epatch ${FILESDIR}/3.3.3/gcc-uclibc-3.3-loop.patch
	fi

	if [ -n "${PIE_VER}" ]
	then
		# corrects startfile/endfile selection and shared/static/pie flag usage
		epatch ${WORKDIR}/piepatch/upstream
		# adds non-default pie support (for now only rs6000)
		epatch ${WORKDIR}/piepatch/nondef
		# adds default pie support for all archs less rs6000 if DEFAULT_PIE[_SSP] is defined
		epatch ${WORKDIR}/piepatch/def
		# disable relro/now
		use uclibc && epatch ${FILESDIR}/3.3.3/gcc-3.3.3-norelro.patch
	fi

	if [ "${ARCH}" = "ppc" -o "${ARCH}" = "ppc64" ]
	then
		epatch ${FILESDIR}/3.3.3/gcc333_pre20040408-stack-size.patch
	fi

	if [ "${ARCH}" = "arm" ]
	then
		epatch ${FILESDIR}/3.3.3/gcc333-debian-arm-getoff.patch
		epatch ${FILESDIR}/3.3.3/gcc333-debian-arm-ldm.patch
	fi

	# non-default SSP support.
	if [ "${ARCH}" != "hppa" -a "${ARCH}" != "hppa64" -a -n "${PP_VER}" ]
	then
		# ProPolice Stack Smashing protection
#		EPATCH_OPTS="${EPATCH_OPTS} ${WORKDIR}/protector.dif" \
#		epatch ${FILESDIR}/3.3.1/gcc331-pp-fixup.patch

#		EPATCH_OPTS="${EPATCH_OPTS} ${WORKDIR}/protector.dif" \
#		epatch ${FILESDIR}/3.3.3/gcc333-ssp-3.3.2_1-fixup.patch

		epatch ${WORKDIR}/protector.dif

		cp ${WORKDIR}/protector.c ${WORKDIR}/${P}/gcc/ || die "protector.c not found"
		cp ${WORKDIR}/protector.h ${WORKDIR}/${P}/gcc/ || die "protector.h not found"

		[ -n "${PATCH_VER}" ] && epatch ${FILESDIR}/3.3.3/gcc-3.3.3-uclibc-add-ssp.patch

		# we apply only the needed parts of protectonly.dif
		sed -e 's|^CRTSTUFF_CFLAGS = |CRTSTUFF_CFLAGS = -fno-stack-protector-all |' \
			-i gcc/Makefile.in || die "Failed to update crtstuff!"
		#sed -e 's|^\(LIBGCC2_CFLAGS.*\)$|\1 -fno-stack-protector-all|' \
		#	-i ${S}/gcc/Makefile.in || die "Failed to update libgcc!"

		release_version="${release_version}, ssp-${PP_FVER}"

		update_gcc_for_libc_ssp
	fi

	cd ${WORKDIR}/${P}

	[ -n "${PIE_VER}" ] && release_version="${release_version}, pie-${PIE_VER}"

	# if use hardened && ( use x86 || use sparc || use amd64 )
	# the use hardened && use sparc part breaks glibc compiling - pappy
	if use hardened && ( use x86 || use amd64 )
	then
		einfo "Updating gcc to use automatic PIE + SSP building ..."
		sed -e 's|^ALL_CFLAGS = |ALL_CFLAGS = -DEFAULT_PIE_SSP |' \
			-i ${S}/gcc/Makefile.in || die "Failed to update gcc!"

		# rebrand to make bug reports easier
		release_version="${release_version/Gentoo/Gentoo Hardened}"
	fi

	# corrects text relocations in libiberty.a
	(use pic || use hardened) && epatch ${FILESDIR}/3.3.3/gcc-3.3.3-libiberty-pic.patch

	version_patch ${FILESDIR}/3.3.4/gcc334-gentoo-branding.patch \
		"${BRANCH_UPDATE} (${release_version})" || die "Failed Branding"

	# TODO: on arches where we lack a Scrt1.o (like parisc) we still need unpack, compile and install logic
	# TODO: for the crt1Snocsu.o provided by a custom gcc-pie-ssp.tgz which can also be included in SRC_URI

	# Misdesign in libstdc++ (Redhat)
	cp -a ${S}/libstdc++-v3/config/cpu/i{4,3}86/atomicity.h

	# disable --as-needed from being compiled into gcc specs
	# natively when using >=sys-devel/binutils-2.15.90.0.1 this is
	# done to keep our gcc backwards compatible with binutils. 
	# gcc 3.4.1 cvs has patches that need back porting.. 
	# http://gcc.gnu.org/bugzilla/show_bug.cgi?id=14992 (May 3 2004)
	sed -i -e s/HAVE_LD_AS_NEEDED/USE_LD_AS_NEEDED/g ${S}/gcc/config.in

	use uclibc && gnuconfig_update

	cd ${S}; ./contrib/gcc_update --touch &> /dev/null
}

src_compile() {
	local myconf=
	local gcc_lang=

	if ! use build
	then
		myconf="${myconf} --enable-shared"
		gcc_lang="c,c++"
		use f77 && gcc_lang="${gcc_lang},f77"
		use objc && gcc_lang="${gcc_lang},objc"
		use gcj && gcc_lang="${gcc_lang},java"
		# We do NOT want 'ADA support' in here!
		# use ada  && gcc_lang="${gcc_lang},ada"
	else
		gcc_lang="c"
	fi
	if ! use nls || use build
	then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls --without-included-gettext"
	fi

	# Enable building of the gcj Java AWT & Swing X11 backend
	# if we have X as a use flag and are not in a build stage.
	# X11 support is still very experimental but enabling it is
	# quite innocuous...  [No, gcc is *not* linked to X11...]
	# <dragon@gentoo.org> (15 May 2003)
	if ! use build && use gcj && use X && [ -f /usr/X11R6/include/X11/Xlib.h ]
	then
		myconf="${myconf} --x-includes=/usr/X11R6/include --x-libraries=/usr/X11R6/lib"
		myconf="${myconf} --enable-interpreter --enable-java-awt=xlib --with-x"
	fi

	# Multilib not yet supported
	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		einfo "WARNING: Multilib support enabled. This is still experimental."
		myconf="${myconf} --enable-multilib"
	else
		if [ "${ARCH}" = "amd64" ]
		then
			einfo "WARNING: Multilib not enabled. You will not be able to build 32bit binaries."
		fi
		myconf="${myconf} --disable-multilib"
	fi

	# Fix linking problem with c++ apps which where linked
	# against a 3.2.2 libgcc
	[ "${ARCH}" = "hppa" ] && myconf="${myconf} --enable-sjlj-exceptions"

	# --with-gnu-ld needed for cross-compiling
	# --enable-sjlj-exceptions : currently the unwind stuff seems to work 
	# for statically linked apps but not dynamic
	# so use setjmp/longjmp exceptions by default
	# --disable-libunwind-exceptions needed till unwind sections get fixed. see ps.m for details

	if ! use uclibc
	then
		# it's getting close to a time where we are going to need USE=glibc, uclibc, bsdlibc -solar
		myconf="${myconf} --enable-__cxa_atexit --enable-clocale=generic"
	else
		myconf="${myconf} --disable-__cxa_atexit --enable-target-optspace --with-gnu-ld --enable-sjlj-exceptions"
	fi

	# Make sure we have sane CFLAGS
	do_filter_flags

	# Build in a separate build tree
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build

	# Install our pre generated manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		unpack ${P}-manpages.tar.bz2
	fi

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
		--disable-libunwind-exceptions \
		--enable-cstdio=stdio \
		--enable-version-specific-runtime-libs \
		--with-gxx-include-dir=${STDCXX_INCDIR} \
		--with-local-prefix=${LOC}/local \
		${myconf} || die

	touch ${S}/gcc/c-gperf.h

	# Do not make manpages if we do not have perl ...
	if [ ! -x /usr/bin/perl ]
	then
		find ${WORKDIR}/build -name '*.[17]' -exec touch {} \; || :
	fi

	# Setup -j in MAKEOPTS
	get_number_of_jobs

	einfo "Building GCC..."
	# Only build it static if we are just building the C frontend, else
	# a lot of things break because there are not libstdc++.so ....
	if use static && [ "${gcc_lang}" = "c" ]
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
	make prefix=${LOC} \
		bindir=${BINPATH} \
		includedir=${LIBPATH}/include \
		datadir=${DATAPATH} \
		mandir=${DATAPATH}/man \
		infodir=${DATAPATH}/info \
		DESTDIR="${D}" \
		LIBPATH="${LIBPATH}" \
		install || die

	[ -r ${D}${BINPATH}/gcc ] || die "gcc not found in ${D}"

	dodir /lib /usr/bin
	dodir /etc/env.d/gcc
	echo "PATH=\"${BINPATH}\"" > ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "ROOTPATH=\"${BINPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# amd64 is a bit unique because of multilib.  Add some other paths
		echo "LDPATH=\"${LIBPATH}:${LIBPATH}/32:${LIBPATH}/../lib64:${LIBPATH}/../lib32\"" >> \
			${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	else
		echo "LDPATH=\"${LIBPATH}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	fi
	echo "MANPATH=\"${DATAPATH}/man\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "INFOPATH=\"${DATAPATH}/info\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "STDCXX_INCDIR=\"${STDCXX_INCDIR##*/}\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	# Also set CC and CXX
	echo "CC=\"gcc\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	echo "CXX=\"g++\"" >> ${D}/etc/env.d/gcc/${CCHOST}-${MY_PV_FULL}
	# Make sure we do not check glibc for SSP again, as we did already
	if glibc_have_ssp || \
	   [ -f "${ROOT}/etc/env.d/99glibc_ssp" ]
	then
		echo "GLIBC_SSP_CHECKED=1" > ${D}/etc/env.d/99glibc_ssp
	fi

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
	[ -f "${D}${LOC}/lib/libiberty.a" ] && rm -f ${D}${LOC}/lib/libiberty.a

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
		dodoc ChangeLog* FSFChangeLog* LANGUAGES ONEWS README* SERVICE
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

	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# If using multilib, GCC has a bug, where it doesn't know where to find
		# -lgcc_s when linking while compiling with g++ .  ${LIBPATH} is in
		# it's path though, so ln the 64bit and 32bit versions of -lgcc_s
		# to that directory.
		ln -sf ${LIBPATH}/../lib64/libgcc_s.so ${D}/${LIBPATH}/libgcc_s.so
		ln -sf ${LIBPATH}/../lib32/libgcc_s_32.so ${D}/${LIBPATH}/libgcc_s_32.so
	fi
}

pkg_preinst() {

	if [ ! -f "${WORKDIR}/.chkgccversion" ]
	then
		chk_gcc_version
	fi

	# Make again sure that the linker "should" be able to locate
	# libstdc++.so ...
	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	${ROOT}/sbin/ldconfig
}

pkg_postinst() {

	if use multilib && [ "${ARCH}" = "amd64" ]
	then
		# Can't always find libgcc_s.so.1, make it find it
		export LD_LIBRARY_PATH="${LIBPATH}:${LIBPATH}/../lib64:${LIBPATH}/../lib32:${LD_LIBRARY_PATH}"
	else
		export LD_LIBRARY_PATH="${LIBPATH}:${LD_LIBRARY_PATH}"
	fi
	if [ "${ROOT}" = "/" -a "${COMPILER}" = "gcc3" -a "${CHOST}" = "${CCHOST}" ]
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

