# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.4.20040808-r1.ebuild,v 1.56 2006/08/31 20:28:33 vapier Exp $

inherit eutils multilib flag-o-matic toolchain-funcs versionator

# Branch update support.  Following will disable:
#  BRANCH_UPDATE=
BRANCH_UPDATE="20040808"

# Minimum kernel version we support
# (Recent snapshots fails with 2.6.5 and earlier)
# also, we do not have a single 2.4 kernel in the tree with backported
# support required to enable nptl.
MIN_KERNEL_VERSION="2.6.5"

# (very) Theoretical cross-compiler support
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} = ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi


if [ -z "${BRANCH_UPDATE}" ]; then
	BASE_PV="${NEW_PV}"
	NEW_PV="${NEW_PV}"
else
	BASE_PV="2.3.3"
	NEW_PV="${PV%.*}"
fi


S="${WORKDIR}/${PN}-${BASE_PV}"
DESCRIPTION="GNU libc6 (also called glibc2) C library"
HOMEPAGE="http://sources.redhat.com/glibc/"

HPPA_PATCHES=2004-08-24

SRC_URI="http://dev.gentoo.org/~lv/${PN}-${BASE_PV}.tar.bz2
	http://dev.gentoo.org/~lv/${PN}-manpages-${NEW_PV}.tar.bz2
	http://dev.gentoo.org/~lv/glibc-infopages-${NEW_PV}.tar.bz2
	hppa? ( http://parisc-linux.org/~carlos/glibc-work/glibc-hppa-patches-${HPPA_PATCHES}.tar.gz )"

[ ! -z "${BRANCH_UPDATE}" ] && SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~lv/${PN}-${NEW_PV}-branch-update-${BRANCH_UPDATE}.patch.bz2"

LICENSE="LGPL-2"
[[ ${CTARGET} != ${CHOST} ]] \
	&& SLOT="${CTARGET}-2.2" \
	|| SLOT="2.2"
#~sparc: This is only used by the sparc64-multilib PROFILE_ARCH as versions
#        after ~2.3.3.20040420 break blackdown-jdk on sparc.
KEYWORDS="x86 amd64 hppa ppc64 ~ppc -mips ~sparc"
IUSE="build erandom hardened multilib n32 nls nptl pic userlocales"
RESTRICT="nostrip multilib-pkg-force" # we'll handle stripping ourself #46186

# We need new cleanup attribute support from gcc for NPTL among things ...
# We also need linux26-headers if using NPTL. Including kernel headers is
# incredibly unreliable, and this new linux-headers release from plasmaroo
# should work with userspace apps, at least on amd64 and ppc64.
DEPEND=">=sys-devel/gcc-3.2.3-r1
	nptl? ( >=sys-devel/gcc-3.3.1-r1 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	virtual/os-headers
	nptl? ( >=sys-kernel/linux-headers-${MIN_KERNEL_VERSION} )
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( sys-devel/gettext )"

PROVIDE="virtual/libc"

# We need to be able to set alternative headers for
# compiling for non-native platform
# Will also become useful for testing kernel-headers without screwing up
# the whole system.
# note: intentionally undocumented.
alt_headers() {
	if [ -z "${ALT_HEADERS}" ] ; then
		if [[ ${CTARGET} = ${CHOST} ]] ; then
			ALT_HEADERS="${ROOT}/usr/include"
		else
			ALT_HEADERS="${ROOT}/usr/${CTARGET}/include"
		fi
	fi
	echo "${ALT_HEADERS}"
}
alt_build_headers() {
	if [[ -z ${ALT_BUILD_HEADERS} ]] ; then
		ALT_BUILD_HEADERS=$(alt_headers)
		tc-is-cross-compiler && ALT_BUILD_HEADERS=${ROOT}$(alt_headers)
	fi
	echo "${ALT_BUILD_HEADERS}"
}
alt_prefix() {
	if [[ ${CTARGET} = ${CHOST} ]] ; then
		echo /usr
	else
		echo /usr/${CTARGET}
	fi
}
alt_libdir() {
	if [[ ${CTARGET} = ${CHOST} ]] ; then
		echo /$(get_libdir)
	else
		echo /usr/${CTARGET}/$(get_libdir)
	fi
}

setup_flags() {
	# Over-zealous CFLAGS can often cause problems.  What may work for one
	# person may not work for another.  To avoid a large influx of bugs
	# relating to failed builds, we strip most CFLAGS out to ensure as few
	# problems as possible.
	strip-flags
	strip-unsupported-flags

	# -freorder-blocks for all but ppc
	use ppc || append-flags "-freorder-blocks"

	# Sparc/Sparc64 support
	if use sparc; then
		# Both sparc and sparc64 can use -fcall-used-g6.  -g7 is bad, though.
		filter-flags "-fcall-used-g7"
		append-flags "-fcall-used-g6"

		# Sparc64 Only support...
		if [ "${PROFILE_ARCH}" = "sparc64" ] && !has_multilib_profile; then
			# Get rid of -mcpu options (the CHOST will fix this up) and flags
			# known to fail
			filter-flags "-mcpu=ultrasparc -mcpu=v9 -mvis"

			# Setup the CHOST properly to insure "sparcv9"
			# This passes -mcpu=ultrasparc -Wa,-Av9a to the compiler
			if [ "${CHOST}" = "sparc-unknown-linux-gnu" ]; then
				CTARGET="sparcv9-unknown-linux-gnu"
				CHOST="${CTARGET}"
			fi
		fi

		if [ "${PROFILE_ARCH}" = "sparc64" ] && has_multilib_profile; then
			# We change our CHOST, so set this right here
			export CC="$(tc-getCC)"

			# glibc isn't too smart about guessing our flags.  It
			# will default to -xarch=v9, but assembly in sparc64 glibc
			# requires v9a or greater...
			if is-flag "-mcpu=ultrasparc3"; then
				# Change CHOST to include us3 assembly
				if [ "${ABI}" = "sparc32" ]; then
					CTARGET="sparcv9b-unknown-linux-gnu"
					CHOST="${CTARGET}"
				else
					CTARGET="sparc64b-unknown-linux-gnu"
					CHOST="${CTARGET}"
					export CFLAGS_sparc64="$(get_abi_CFLAGS) -Wa,-xarch=v9b"
				fi
			else
				if [ "${ABI}" = "sparc32" ]; then
					CTARGET="sparcv9-unknown-linux-gnu"
					CHOST="${CTARGET}"
				else
					CTARGET="sparc64-unknown-linux-gnu"
					CHOST="${CTARGET}"
					export CFLAGS_sparc64="$(get_abi_CFLAGS) -Wa,-xarch=v9a"
				fi
			fi

			filter-flags -mvis -m32 -m64 -Wa,-xarch -Wa,-A
		fi
	fi

	# AMD64 multilib
	if use amd64 && has_multilib_profile; then
		# We change our CHOST, so set this right here
		export CC="$(tc-getCC)"

		if [ "${ABI}" = "amd64" ]; then
			CTARGET="x86_64-pc-linux-gnu"
			CHOST="${CTARGET}"
		else
			CTARGET="i686-pc-linux-gnu"
			CHOST="${CTARGET}"
		fi

		filter-flags -m32 -m64
	fi

	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]; then
		# broken in 3.4.x
		replace-flags -march=pentium-m -mtune=pentium3
	fi

	if gcc -v 2>&1 | grep -q 'gcc version 3.[0123]'; then
		append-flags -finline-limit=2000
	fi

	# We don't want these flags for glibc
	filter-flags -fomit-frame-pointer -malign-double
	filter-ldflags -pie

	# Lock glibc at -O2 -- linuxthreads needs it and we want to be
	# conservative here
	append-flags -O2
}


check_kheader_version() {
	local header="$(alt_build_headers)/linux/version.h"

	[ -z "$1" ] && return 1

	if [ -f "${header}" ]; then
		local version="`grep 'LINUX_VERSION_CODE' ${header} | \
			sed -e 's:^.*LINUX_VERSION_CODE[[:space:]]*::'`"

		if [ "${version}" -ge "$1" ]; then
			return 0
		fi
	fi

	return 1
}


check_nptl_support() {
	local min_kernel_version="$(KV_to_int "${MIN_KERNEL_VERSION}")"

	echo

	einfon "Checking gcc for __thread support ... "
	if ! gcc -c ${FILESDIR}/test-__thread.c -o ${T}/test2.o &> /dev/null; then
		echo "no"
		echo
		eerror "Could not find a gcc that supports the __thread directive!"
		eerror "please update to gcc-3.2.2-r1 or later, and try again."
		die "No __thread support in gcc!"
	else
		echo "yes"
	fi

	# Building fails on an non-supporting kernel
	einfon "Checking kernel version (>=${MIN_KERNEL_VERSION}) ... "
	if [ "`get_KV`" -lt "${min_kernel_version}" ]; then
		echo "no"
		echo
		eerror "You need a kernel of at least version ${MIN_KERNEL_VERSION}"
		eerror "for NPTL support!"
		die "Kernel version too low!"
	else
		echo "yes"
	fi

	# Building fails with too low linux-headers
	einfon "Checking linux-headers version (>=${MIN_KERNEL_VERSION}) ... "
	if ! check_kheader_version "${min_kernel_version}"; then
		echo "no"
		echo
		eerror "You need linux-headers of at least version ${MIN_KERNEL_VERSION}"
		eerror "for NPTL support!"
		die "linux-headers version too low!"
	else
		echo "yes"
	fi

	echo
}


want_nptl() {
	if use nptl; then
		# Archs that can use NPTL
		if use amd64 || use ia64 || use ppc || \
		   use ppc64 || use s390 ; then
			return 0
		fi

		# Specific x86 CHOSTS that can use NPTL
		if use x86; then
			case "${CHOST/-*}" in
				i486|i586|i686)	return 0 ;;
			esac
		fi
	fi

	return 1
}


want_tls() {
	# Archs that can use TLS (Thread Local Storage)
	if use amd64 || use alpha || use ia64 || use ppc || \
	   use ppc64 || use s390 || use sparc; then
		return 0
	fi

	# Specific x86 CHOSTS that can use TLS
	if use x86; then
		case "${CHOST/-*}" in
			i486|i586|i686)	return 0 ;;
		esac

	fi

	return 1
}


install_locales() {
	unset LANGUAGE LANG LC_ALL
	cd ${WORKDIR}/build
	make PARALLELMFLAGS="${MAKEOPTS} -j1" \
		install_root=${D} localedata/install-locales || die
	[[ ${CTARGET} = ${CHOST} ]] && keepdir /usr/lib/locale/ru_RU/LC_MESSAGES
}


setup_locales() {
	if use !userlocales; then
		einfo "userlocales not enabled, installing -ALL- locales..."
		install_locales || die
	elif [ -e /etc/locales.build ]; then
		einfo "Installing locales in /etc/locales.build..."
		echo 'SUPPORTED-LOCALES=\' > SUPPORTED.locales
		cat /etc/locales.build | grep -v -e ^$ -e ^\# | sed 's/$/\ \\/g' \
			>> SUPPORTED.locales
		cat SUPPORTED.locales > ${S}/localedata/SUPPORTED || die
		install_locales || die
	elif [ -e ${FILESDIR}/locales.build ]; then
		einfo "Installing locales in ${FILESDIR}/locales.build..."
		echo 'SUPPORTED-LOCALES=\' > SUPPORTED.locales
		cat ${FILESDIR}/locales.build | grep -v -e ^$ -e ^\# | sed 's/$/\ \\/g' \
			>> SUPPORTED.locales
		cat SUPPORTED.locales > ${S}/localedata/SUPPORTED || die
		install_locales || die
	else
		einfo "Installing -ALL- locales..."
		install_locales || die
	fi
}


pkg_setup() {
	# We need gcc 3.2 or later ...
	if [ "`gcc-major-version`" -ne "3" -o "`gcc-minor-version`" -lt "2" ]; then
		echo
		eerror "As of glibc-2.3, gcc-3.2 or later is needed"
		eerror "for the build to succeed."
		die "GCC too old"
	fi
	echo
}


do_arch_alpha_patches() {
	[[ $(tc-arch ${CTARGET}) != "alpha" ]] && return 0
	cd ${S}

	# Fix compatability with compaq compilers by ifdef'ing out some
	# 2.3.2 additions.
	# <taviso@gentoo.org> (14 Jun 2003).
	epatch ${FILESDIR}/2.3.2/${PN}-2.3.2-decc-compaq.patch

	# Fix compilation with >=gcc-3.2.3 (01 Nov 2003 agriffis)
#	epatch ${FILESDIR}/2.3.2/${LOCAL_P}-alpha-pwrite.patch
}


do_arch_amd64_patches() {
	[[ $(tc-arch ${CTARGET}) != "amd64" ]] && return 0
	cd ${S};

	if ! has_multilib_profile; then
		# CONF_LIBDIR support
		epatch ${FILESDIR}/2.3.4/glibc-gentoo-libdir.patch
		sed -i -e "s:@GENTOO_LIBDIR@:$(get_libdir):g" ${S}/sysdeps/unix/sysv/linux/configure
	fi

	# fixes compiling with the new binutils on at least amd64 and ia64.
	# see http://sources.redhat.com/ml/libc-alpha/2004-08/msg00076.html
	# and http://bugs.gentoo.org/show_bug.cgi?id=66396 for more info.
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-res_init.patch
}


do_arch_arm_patches() {
	[[ $(tc-arch ${CTARGET}) != "arm" ]] && return 0
	cd ${S};

	# Any needed patches for arm go here
	epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-arm-ioperm.patch
}


do_arch_hppa_patches() {
	[[ $(tc-arch ${CTARGET}) != "hppa" ]] && return 0
	einfo "Applying hppa specific path of ${HPPA_PATCHES} ..."
	cd ${T}
	unpack glibc-hppa-patches-${HPPA_PATCHES}.tar.gz
	cd ${S}
	epatch "${FILESDIR}"/2.3.4/hppa-no-pie.patch
	export EPATCH_OPTS=-p1
	for i in ${T}/glibc-hppa-patches-${HPPA_PATCHES}/*.diff
	do
		epatch ${i}
	done

	unset EPATCH_OPTS

	use hardened && epatch ${FILESDIR}/2.3.4/glibc-2.3.4-hppa-hardened-disable__init_arrays.patch

}


do_arch_ia64_patches() {
	[[ $(tc-arch ${CTARGET}) != "ia64" ]] && return 0
	cd ${S};

	# The basically problem is glibc doesn't store information about
	# what the kernel interface is so that it can't efficiently set up
	# parameters for system calls.  This patch from H.J. Lu fixes it:
	#
	#   http://sources.redhat.com/ml/libc-alpha/2003-09/msg00165.html

#	epatch ${FILESDIR}/2.3.2/${LOCAL_P}-ia64-LOAD_ARGS-fixup.patch


	# fixes compiling with the new binutils on at least amd64 and ia64.
	# see http://sources.redhat.com/ml/libc-alpha/2004-08/msg00076.html
	# and http://bugs.gentoo.org/show_bug.cgi?id=66396 for more info.
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-res_init.patch
}


do_arch_mips_patches() {
	[[ $(tc-arch ${CTARGET}) != "mips" ]] && return 0
	cd ${S}

	# A few patches only for the MIPS platform.  Descriptions of what they
	# do can be found in the patch headers.
	# <tuxus@gentoo.org> thx <dragon@gentoo.org> (11 Jan 2003)
	# <kumba@gentoo.org> remove tst-rndseek-mips & ulps-mips patches
	# <iluxa@gentoo.org> add n32/n64 patches, remove pread patch
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-addabi.diff
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-syscall.h.diff
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-sysify.diff

	# Need to install into /lib for n32-only userland for now.
	# Propper solution is to make all userland /lib{32|64}-aware.
	has_multilib_profile || use multilib || epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-nolib3264.diff

	# Found this on Google (yay google!) and it fixes glibc not building
	# a correct bits/syscall.h from 2.6.x headers.  It possibly breaks older
	# headers (2.4.x?), so for now, only use it on n32.
	use n32 && epatch ${FILESDIR}/2.3.4/glibc-2.3.4-mips-generate-syscall_h.patch
}


do_arch_ppc_patches() {
	[[ $(tc-arch ${CTARGET}) != "ppc" ]] && return 0
	cd ${S};
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-getcontext.patch
	# Any needed patches for ppc go here
}


do_arch_ppc64_patches() {
	[[ $(tc-arch ${CTARGET}) != "ppc64" ]] && return 0
	cd ${S};
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-getcontext.patch
	# Any needed patches for ppc64 go here
}


do_arch_s390_patches() {
	[[ $(tc-arch ${CTARGET}) != "s390" ]] && return 0
	cd ${S};

	# Any needed patches for s390 go here
}


do_arch_sparc_patches() {
	[[ $(tc-arch ${CTARGET}) != "sparc" ]] && return 0
	cd ${S};

	# Any needed patches for sparc go here
}


do_arch_x86_patches() {
	[[ $(tc-arch ${CTARGET}) != "x86" ]] && return 0
	cd ${S};
	# CONF_LIBDIR support
	epatch ${FILESDIR}/2.3.4/glibc-gentoo-libdir.patch
	sed -i -e "s:@GENTOO_LIBDIR@:$(get_libdir):g" ${S}/sysdeps/unix/sysv/linux/configure
}


do_pax_patches() {
	cd ${S}

	# localedef contains nested function trampolines, which trigger
	# segfaults under PaX -solar
	# Debian Bug (#231438, #198099)
	epatch ${FILESDIR}/2.3.3/glibc-2.3.3-localedef-fix-trampoline.patch

	# With latest versions of glibc, a lot of apps failed on a PaX enabled
	# system with:
	#
	#  cannot enable executable stack as shared object requires: Permission denied
	#
	# This is due to PaX 'exec-protecting' the stack, and ld.so then trying
	# to make the stack executable due to some libraries not containing the
	# PT_GNU_STACK section.  Bug #32960.  <azarah@gentoo.org> (12 Nov 2003).
	use mips || epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-dl_execstack-PaX-support.patch

	# Program header support for PaX.
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3_pre20040117-pt_pax.diff

	# Suppress unresolvable relocation against symbol `main' in Scrt1.o
	# can be reproduced with compiling net-dns/bind-9.2.2-r3 using -pie
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4.20040808-i386-got-fix.diff
}


do_hardened_fixes() {
	# this patch is needed to compile nptl with a hardened gcc
	has_hardened && want_nptl && \
		epatch ${FILESDIR}/2.3.4/glibc-2.3.4-hardened-sysdep-shared.patch
}


do_ssp_patches() {
	# To circumvent problems with propolice __guard and
	# __guard_setup__stack_smash_handler
	#
	#  http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	if use !hppa ; then
		epatch ${FILESDIR}/2.3.3/glibc-2.3.2-propolice-guard-functions-v3.patch
		cp ${FILESDIR}/2.3.3/ssp.c ${S}/sysdeps/unix/sysv/linux || \
			die "failed to copy ssp.c to ${S}/sysdeps/unix/sysv/linux/"
	fi

	# patch this regardless of architecture, although it's ssp-related
	epatch ${FILESDIR}/2.3.3/glibc-2.3.3-frandom-detect.patch
}


src_unpack() {
	# Check NPTL support _before_ we unpack things to save some time
	want_nptl && check_nptl_support

	unpack ${PN}-${BASE_PV}.tar.bz2

	# Extract pre-made man pages.
	# Otherwise we need perl, which is bad (especially for stage1 bootstrap)
	mkdir -p ${S}/man
	cd ${S}/man
	unpack ${PN}-manpages-${NEW_PV}.tar.bz2
	cd ${S}

	if [ -n "${BRANCH_UPDATE}" ]; then
		epatch ${DISTDIR}/${PN}-${NEW_PV}-branch-update-${BRANCH_UPDATE}.patch.bz2

		# Snapshot date patch
		einfo "Patching version to display snapshot date ..."
		sed -i -e "s:\(#define RELEASE\).*:\1 \"${BRANCH_UPDATE}\":" version.h
	fi
	# Version patch
	sed -i -e "s:\(#define VERSION\).*:\1 \"${NEW_PV}\":" version.h

	# pre-generated info pages
	unpack glibc-infopages-2.3.4.tar.bz2

	epatch ${FILESDIR}/glibc-sec-hotfix-20040804.patch

	# SSP support in glibc (where it belongs)
	do_ssp_patches

	# PaX-related Patches
	do_pax_patches

	# disable binutils -as-needed
	sed -e 's/^have-as-needed.*/have-as-needed = no/' -i ${S}/config.make.in

	# Glibc is stupid sometimes, and doesn't realize that with a 
	# static C-Only gcc, -lgcc_eh doesn't exist.
	# http://sources.redhat.com/ml/libc-alpha/2003-09/msg00100.html
	echo 'int main(){}' > ${T}/gcc_eh_test.c
	if ! $(tc-getCC) ${T}/gcc_eh_test.c -lgcc_eh 2>/dev/null ; then
		sed -i -e 's:-lgcc_eh::' Makeconfig || die "sed gcc_eh"
	fi

	# hardened toolchain/relro/nptl/security/etc fixes
	do_hardened_fixes

	# Arch specific patching
	do_arch_alpha_patches
	do_arch_amd64_patches
	do_arch_arm_patches
	do_arch_hppa_patches
	do_arch_ia64_patches
	do_arch_mips_patches
	do_arch_ppc_patches
	do_arch_ppc64_patches
	do_arch_s390_patches
	do_arch_sparc_patches
	do_arch_x86_patches

	# Remaining patches
	cd ${S}

	# fix for http://sources.redhat.com/bugzilla/show_bug.cgi?id=227
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-ld.so-brk-fix.patch

	# fix for using nptl's pthread.h with g++
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-nptl-pthread.h-g++-fix.patch

	# Improved handled temporary files. bug #66358
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-tempfile.patch

	# Fix permissions on some of the scripts
	chmod u+x ${S}/scripts/*.sh
}


src_compile() {
	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ -z "${OABI}" -a "${MLTEST/set_abi}" = "${MLTEST}" ]; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			export ABI
			einfo "Compiling ${ABI} glibc"
			src_compile && mv ${WORKDIR}/build ${WORKDIR}/build.${ABI}
		done
		ABI="${OABI}"
		unset OABI
		return 0
	fi
	unset MLTEST

	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	use nls || myconf="${myconf} --disable-nls"
	use erandom || myconf="${myconf} --disable-dev-erandom"

	if want_nptl && want_tls; then
		myconf="${myconf} \
		--enable-add-ons=nptl \
		--with-tls --with-__thread \
		--enable-kernel=2.6.0"
	else
		myconf="${myconf} --enable-add-ons=linuxthreads --without-__thread"
	fi

	# this can be tricky sometimes... if it breaks glibc for you, you should
	# add a block in the want_tls logic. if it breaks linuxthreads, but nptl
	# works... make sure to add 'use !nptl' to that logic.
	want_tls || myconf="${myconf} --without-tls"
	want_tls && myconf="${myconf} --with-tls"

	# Who knows if this works :)
	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"

	# some silly people set LD_RUN_PATH and that breaks things.
	# see bug 19043
	unset LD_RUN_PATH

	einfo "Configuring GLIBC..."
	rm -rf ${WORKDIR}/build
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build
	# Pick out the correct location for build headers
	${S}/configure \
		--build=${CHOST} \
		--host=${CTARGET} \
		--disable-profile \
		--without-gd \
		--without-cvs \
		--with-headers=$(alt_build_headers) \
		--prefix=$(alt_prefix) \
		--mandir=$(alt_prefix)/share/man \
		--infodir=$(alt_prefix)/share/info \
		--libexecdir=$(alt_prefix)/lib/misc \
		--enable-bind-now \
		${myconf} || die

	einfo "Building GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" || die
}

src_test() {
	# This is wrong, but glibc's tests fail bad when screwing 
	# around with sandbox, so lets just punt it
	unset LD_PRELOAD

	cd ${WORKDIR}/build
	make check || die "make check failed :("
}

src_install() {
	# MULTILIB-CLEANUP: Fix this when FEATURES=multilib-pkg is in portage
	local MLTEST=$(type dyn_unpack)
	if has_multilib_profile && [ -z "${OABI}" -a "${MLTEST/set_abi}" = "${MLTEST}" ]; then
		OABI="${ABI}"
		for ABI in $(get_install_abis); do
			export ABI
			mv ${WORKDIR}/build.${ABI} ${WORKDIR}/build

			# Handle stupid lib32 BS
			if use amd64 && [ "${ABI}" = "x86" -a "$(get_libdir)" != "lib" ]; then
				OLD_LIBDIR="$(get_libdir)"
				LIBDIR_x86="lib"
			fi

			src_install && mv ${WORKDIR}/build ${WORKDIR}/build.${ABI}

			# Handle stupid lib32 BS
			if use amd64 && [ "${ABI}" = "x86" -a -n "${OLD_LIBDIR}" ]; then
				LIBDIR_x86="${OLD_LIBDIR}"
				unset OLD_LIBDIR

				mv ${D}/lib ${D}/$(get_libdir)
				mv ${D}/usr/lib ${D}/usr/$(get_libdir)
				mkdir ${D}/lib
				dosym ../$(get_libdir)/ld-linux.so.2 /lib/ld-linux.so.2
				dosed "s:/lib/:/$(get_libdir)/:g" /usr/$(get_libdir)/libc.so /usr/$(get_libdir)/libpthread.so

				rm -rf ${D}/usr/$(get_libdir)/misc ${D}/usr/$(get_libdir)/locale

				for f in ${D}/usr/$(get_libdir)/*.so; do
					local basef=$(basename ${f})
					if [ -L ${f} ]; then
						local target=$(readlink ${f})
						target=${target/\/lib\//\/$(get_libdir)\/}
						rm ${f}
						dosym ${target} /usr/$(get_libdir)/${basef}
					fi
				done
			fi

		done
		ABI="${OABI}"
		unset OABI
		return 0
	fi
	unset MLTEST
	setup_flags

	# Need to dodir first because it might not exist (bad amd64 profiles)
	dodir /usr/$(get_libdir)

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	cd ${WORKDIR}/build

	einfo "Installing GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" \
		install_root=${D} \
		install || die
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		# punt all the junk not needed by a cross-compiler
		rm -r "${D}"/usr/${CTARGET}/{bin,etc,lib/gconv,sbin,share}
	fi

	# now, strip everything but the thread libs #46186
	mkdir -p ${T}/thread-backup
	mv ${D}/$(alt_libdir)/lib{pthread,thread_db}* ${T}/thread-backup/
	env -uRESTRICT CHOST=${CTARGET} prepallstrip

	# this directory can be empty in certain cases so || die is wrong
	ls  ${T}/thread-backup/*  1>/dev/null 2>&1 && mv -f ${T}/thread-backup/* ${D}/$(alt_libdir)/

	# If librt.so is a symlink, change it into linker script (Redhat)
	if [ -L "${D}/usr/$(get_libdir)/librt.so" -a "${LIBRT_LINKERSCRIPT}" = "yes" ]; then
		local LIBRTSO="`cd ${D}/$(get_libdir); echo librt.so.*`"
		local LIBPTHREADSO="`cd ${D}/$(get_libdir); echo libpthread.so.*`"

		rm -f ${D}/usr/$(get_libdir)/librt.so
		cat > ${D}/usr/$(get_libdir)/librt.so <<EOF
/* GNU ld script
	librt.so.1 needs libpthread.so.0 to come before libc.so.6*
	in search scope.  */
EOF
		grep "OUTPUT_FORMAT" ${D}/usr/$(get_libdir)/libc.so >> ${D}/usr/$(get_libdir)/librt.so
		echo "GROUP ( /$(get_libdir)/${LIBPTHREADSO} /$(get_libdir)/${LIBRTSO} )" \
			>> ${D}/usr/$(get_libdir)/librt.so

		for x in ${D}/usr/$(get_libdir)/librt.so.[1-9]; do
			[ -L "${x}" ] && rm -f ${x}
		done
	fi

	if use pic && ! use amd64 ; then
		find ${S}/${buildtarget}/ -name "soinit.os" -exec cp {} ${D}/lib/soinit.o \;
		find ${S}/${buildtarget}/ -name "sofini.os" -exec cp {} ${D}/lib/sofini.o \;
		find ${S}/${buildtarget}/ -name "*_pic.a" -exec cp {} ${D}/lib \;
		find ${S}/${buildtarget}/ -name "*.map" -exec cp {} ${D}/lib \;

		for i in ${D}/lib/*.map; do
			mv ${i} ${i%.map}_pic.map
		done
	fi

	# We'll take care of the cache ourselves
	rm -f ${D}/etc/ld.so.cache

	#################################################################
	# EVERYTHING AFTER THIS POINT IS FOR NATIVE GLIBC INSTALLS ONLY #
	[[ ${CTARGET} != ${CHOST} ]] && return 0

	cd ${WORKDIR}/build
	if ! use build ; then
		if ! has noinfo ${FEATURES} ; then
			einfo "Installing Info pages..."
			make PARALLELMFLAGS="${MAKEOPTS}" \
				install_root=${D} \
				info -i
		fi

		setup_locales

		einfo "Installing man pages and docs..."
		# Install linuxthreads man pages even if nptl is enabled
		dodir /usr/share/man/man3
		doman ${S}/man/*.3thr

		# Install nscd config file
		insinto /etc ; doins ${FILESDIR}/nscd.conf
		exeinto /etc/init.d ; doexe ${FILESDIR}/nscd
		doins "${FILESDIR}"/nsswitch.conf

		cd ${S}
		dodoc BUGS ChangeLog* CONFORMANCE FAQ INTERFACE \
			NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share ${D}/usr/lib/gconv

		einfo "Installing Timezone data..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			timezone/install-others || die
	fi

	# Is this next line actually needed or does the makefile get it right?
	# It previously has 0755 perms which was killing things.
	fperms 4711 /usr/lib/misc/pt_chown

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f ${D}/etc/localtime

	# Some things want this, notably ash.
	dosym libbsd-compat.a /usr/$(get_libdir)/libbsd.a

	# This is our new config file for building locales
	insinto /etc
	doins ${FILESDIR}/locales.build

	# Handle includes for different ABIs
	prep_ml_includes
}

fix_lib64_symlinks() {
	# the original Gentoo/AMD64 devs decided that since 64bit is the native
	# bitdepth for AMD64, lib should be used for 64bit libraries. however,
	# this ignores the FHS and breaks multilib horribly... especially
	# since it wont even work without a lib64 symlink anyways. *rolls eyes*
	# see bug 59710 for more information.
	# Travis Tilley <lv@gentoo.org> (08 Aug 2004)
	if [ -L ${ROOT}/lib64 ] ; then
		ewarn "removing /lib64 symlink and moving lib to lib64..."
		ewarn "dont hit ctrl-c until this is done"
		addwrite ${ROOT}/
		rm ${ROOT}/lib64
		# now that lib64 is gone, nothing will run without calling ld.so
		# directly. luckily the window of brokenness is almost non-existant
		/lib/ld-linux-x86-64.so.2 /bin/mv ${ROOT}/lib ${ROOT}/lib64
		# all better :)
		ldconfig
		ln -s lib64 ${ROOT}/lib
		einfo "done! :-)"
		einfo "fixed broken lib64/lib symlink in ${ROOT}"
	fi
	if [ -L ${ROOT}/usr/lib64 ] ; then
		addwrite ${ROOT}/usr
		rm ${ROOT}/usr/lib64
		mv ${ROOT}/usr/lib ${ROOT}/usr/lib64
		ln -s lib64 ${ROOT}/usr/lib
		einfo "fixed broken lib64/lib symlink in ${ROOT}/usr"
	fi
	if [ -L ${ROOT}/usr/X11R6/lib64 ] ; then
		addwrite ${ROOT}/usr/X11R6
		rm ${ROOT}/usr/X11R6/lib64
		mv ${ROOT}/usr/X11R6/lib ${ROOT}/usr/X11R6/lib64
		ln -s lib64 ${ROOT}/usr/X11R6/lib
		einfo "fixed broken lib64/lib symlink in ${ROOT}/usr/X11R6"
	fi
}

pkg_preinst() {
	# PPC64+others may want to eventually be added to this logic if they
	# decide to be multilib compatible and FHS compliant. note that this 
	# chunk of FHS compliance only applies to 64bit archs where 32bit
	# compatibility is a major concern (not IA64, for example).

	# amd64's 2005.0 is the first amd64 profile to not need this code.
	# 2005.0 is setup properly, and this is executed as part of the
	# 2004.3 -> 2005.0 upgrade script.
	# It can be removed after 2004.3 has been purged from portage.
	use amd64 && [ "$(get_libdir)" == "lib64" ] && ! has_multilib_profile && fix_lib64_symlinks

	# Shouldnt need to keep this updated
	[[ -e ${ROOT}/etc/locales.build ]] && rm -f "${D}"/etc/locales.build
}

pkg_postinst() {
	# Correct me if I am wrong here, but my /etc/localtime is a file
	# created by zic ....
	# I am thinking that it should only be recreated if no /etc/localtime
	# exists, or if it is an invalid symlink.
	#
	# For invalid symlink:
	#   -f && -e  will fail
	#   -L will succeed
	#
	if [ ! -e "${ROOT}/etc/localtime" ]; then
		echo "Please remember to set your timezone using the zic command."
		rm -f ${ROOT}/etc/localtime
		ln -s ../usr/share/zoneinfo/Factory ${ROOT}/etc/localtime
	fi

	if [ -x "${ROOT}/usr/sbin/iconvconfig" ]; then
		# Generate fastloading iconv module configuration file.
		${ROOT}/usr/sbin/iconvconfig --prefix=${ROOT}
	fi

	if [ ! -e "${ROOT}/ld.so.1" ] && use ppc64
	then
		pushd ${ROOT}
		cd ${ROOT}/lib
		ln -s ld64.so.1 ld.so.1
		popd
	fi

	# Reload init ...
	if [ "${ROOT}" = "/" ]; then
		/sbin/telinit U &> /dev/null
	fi
}

must_exist() {
	test -e ${D}/${1}/${2} || die "${1}/${2} was not installed"
}
