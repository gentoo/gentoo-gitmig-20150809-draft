# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.4.20040619.ebuild,v 1.20 2004/07/22 12:22:00 gmsoft Exp $

inherit eutils flag-o-matic gcc

# Branch update support.  Following will disable:
#  BRANCH_UPDATE=
BRANCH_UPDATE="20040619"


# Minimum kernel version we support
# (Recent snapshots fails with 2.6.5 and earlier)
MIN_KERNEL_VERSION="2.6.5"


if [ -z "${BRANCH_UPDATE}" ]; then
	BASE_PV="${NEW_PV}"
	NEW_PV="${NEW_PV}"
else
	BASE_PV="2.3.2"
	NEW_PV="${PV%.*}"
fi


S="${WORKDIR}/${PN}-${BASE_PV}"
DESCRIPTION="GNU libc6 (also called glibc2) C library"
HOMEPAGE="http://sources.redhat.com/glibc/"

HPPA_PATCHES=2004-06-04

SRC_URI="http://ftp.gnu.org/gnu/${PN}/${PN}-${BASE_PV}.tar.bz2
	ftp://sources.redhat.com/pub/${PN}/snapshots/${PN}-${BASE_PV}.tar.bz2
	mirror://gentoo/${PN}-manpages-${NEW_PV}.tar.bz2
	hppa? ( http://parisc-linux.org/~carlos/glibc-work/glibc-hppa-patches-${HPPA_PATCHES}.tar.gz )"
if [ -z "${BRANCH_UPDATE}" ]; then
	SRC_URI="${SRC_URI}
		http://ftp.gnu.org/gnu/${PN}/${PN}-linuxthreads-${BASE_PV}.tar.bz2
		ftp://sources.redhat.com/pub/${PN}/snapshots/${PN}-linuxthreads-${BASE_PV}.tar.bz2"
else
	SRC_URI="${SRC_URI}
		mirror://gentoo/${PN}-${NEW_PV}-branch-update-${BRANCH_UPDATE}.patch.bz2"
fi

LICENSE="LGPL-2"
SLOT="2.2"
KEYWORDS="-* ~x86 ~mips ~amd64 ~hppa"
IUSE="nls pic build nptl erandom hardened makecheck multilib debug"

# We need new cleanup attribute support from gcc for NPTL among things ...
# We also need linux26-headers if using NPTL. Including kernel headers is
# incredibly unreliable, and this new linux-headers release from plasmaroo
# should work with userspace apps, at least on amd64 and ppc64.
DEPEND=">=sys-devel/gcc-3.2.3-r1
	nptl? ( >=sys-devel/gcc-3.3.1-r1 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	virtual/os-headers
	nptl? ( =sys-kernel/linux26-headers-2.6* )
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/os-headers
	sys-apps/baselayout
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/glibc virtual/libc"


# Theoretical cross-compiler support
[ -z "${CCHOST}" ] && CCHOST="${CHOST}"

# We need to be able to set alternative headers for
# compiling for non-native platform
# Will also become useful for testing kernel-headers without screwing up
# whole system
[ -z "${ALT_HEADERS}" ] && ALT_HEADERS="${ROOT}/usr/include"


setup_flags() {
	# Over-zealous CFLAGS can often cause problems.  What may work for one person may not
	# work for another.  To avoid a large influx of bugs relating to failed builds, we
	# strip most CFLAGS out to ensure as few problems as possible.
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
		if [ "${PROFILE_ARCH}" = "sparc64" ]; then
			# Get rid of -mcpu options (the CHOST will fix this up) and flags known to fail
			filter-flags "-mcpu=ultrasparc -mcpu=v9 -mvis"

			# Setup the CHOST properly to insure "sparcv9"
			# This passes -mcpu=ultrasparc -Wa,-Av9a to the compiler
			if [ "${CHOST}" = "sparc-unknown-linux-gnu" ]; then
				export CHOST="sparcv9-unknown-linux-gnu"
				export CCHOST="sparcv9-unknown-linux-gnu"
			fi
		fi
	fi

	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]; then
		# broken in 3.4.x
		replace-flags -march=pentium-m -mtune=pentium3
	fi

	# We don't want these flags for glibc
	filter-flags -fomit-frame-pointer -malign-double
	filter-ldflags -pie

	# Lock glibc at -O2 -- linuxthreads needs it and we want to be conservative here
	append-flags -O2
	export LDFLAGS="${LDFLAGS//-Wl,--relax}"
}


check_kheader_version() {
	local header="${ALT_HEADERS}/linux/version.h"

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
		if use amd64 || use alpha || use ia64 || use ppc || \
		   use ppc64 || use s390 || use sparc; then
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


do_makecheck() {
	ATIME=`mount | awk '{ print $3,$6 }' | grep ^\/\  | grep noatime`
	if [ "$ATIME" = "" ]; then
		cd ${WORKDIR}/build
		make check || die
	else
		ewarn "remounting / without noatime option so that make check"
		ewarn "does not fail!"
		sleep 2
		mount / -o remount,atime
		cd ${WORKDIR}/build
		make check || die
		einfo "remounting / with noatime"
		mount / -o remount,noatime
	fi
}


install_locales() {
	unset LANGUAGE LANG LC_ALL
	cd ${WORKDIR}/build
	make PARALLELMFLAGS="${MAKEOPTS}" \
		install_root=${D} localedata/install-locales || die
	keepdir /usr/lib/locale/ru_RU/LC_MESSAGES
}


setup_locales() {
	if use nls || use makecheck; then
		einfo "nls or makecheck in USE, installing -ALL- locales..."
		install_locales
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
	# Check if we are going to downgrade, we don't like that
	local old_version

	old_version="`best_version glibc`"
	old_version="${old_version/sys-libs\/glibc-/}"

	if [ "$old_version" ]; then
		if [ `python -c "import portage; print int(portage.vercmp(\"${PV}\",\"$old_version\"))"` -lt 0 ]; then
			if [ "${FORCE_DOWNGRADE}" ]; then
				ewarn "downgrading glibc, still not recommended, but we'll do as you wish"
			else
				eerror "Dowgrading glibc is not supported and we strongly recommend that"
				eerror "you don't do it as it WILL break all applications compiled against"
				eerror "the new version (most likely including python and portage)."
				eerror "If you are REALLY sure that you want to do it set "
				eerror "     FORCE_DOWNGRADE=1"
				eerror "when you try it again."
				die "glibc downgrade"
			fi
		fi
	fi

	# We need gcc 3.2 or later ...
	if [ "`gcc-major-version`" -ne "3" -o "`gcc-minor-version`" -lt "2" ]; then
		echo
		eerror "As of glibc-2.3, gcc-3.2 or later is needed"
		eerror "for the build to succeed."
		die "GCC too old"
	fi
	echo
}


do_arch_amd64_patches() {
	cd ${S};
	epatch ${FILESDIR}/2.3.2/${PN}-2.3.2-amd64-nomultilib.patch
}


do_arch_alpha_patches() {
	cd ${S}

	# Fix compatability with compaq compilers by ifdef'ing out some
	# 2.3.2 additions.
	# <taviso@gentoo.org> (14 Jun 2003).
	epatch ${FILESDIR}/2.3.2/${PN}-2.3.2-decc-compaq.patch

	# Fix compilation with >=gcc-3.2.3 (01 Nov 2003 agriffis)
#	epatch ${FILESDIR}/2.3.2/${LOCAL_P}-alpha-pwrite.patch
}


do_arch_arm_patches() {
	cd ${S};

	# Any needed patches for arm go here
}


do_arch_hppa_patches() {
	einfo "Applying hppa specific path of ${HPPA_PATCHES} ..."
	cd ${T}
	unpack glibc-hppa-patches-${HPPA_PATCHES}.tar.gz
	cd ${S}
	export EPATCH_OPTS=-p1
	for i in ${T}/glibc-hppa-patches-${HPPA_PATCHES}/*.diff
	do
		epatch ${i}
	done

	use hardened && epatch ${FILESDIR}/2.3.4/glibc-2.3.4-hppa-hardened-disable__init_arrays.patch

}


do_arch_ia64_patches() {
	cd ${S};

	# The basically problem is glibc doesn't store information about
	# what the kernel interface is so that it can't efficiently set up
	# parameters for system calls.  This patch from H.J. Lu fixes it:
	#
	#   http://sources.redhat.com/ml/libc-alpha/2003-09/msg00165.html

#	epatch ${FILESDIR}/2.3.2/${LOCAL_P}-ia64-LOAD_ARGS-fixup.patch
}


do_arch_mips_patches() {
	cd ${S}

	# A few patches only for the MIPS platform.  Descriptions of what they
	# do can be found in the patch headers.
	# <tuxus@gentoo.org> thx <dragon@gentoo.org> (11 Jan 2003)
	# <kumba@gentoo.org> remove tst-rndseek-mips & ulps-mips patches
	# <iluxa@gentoo.org> add n32/n64 patches, remove pread patch
	epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-fpu-cw-mips.patch
	epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-librt-mips.patch
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3_pre20040420-mips-dl-machine-calls.diff
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3_pre20040420-mips-incl-sgidefs.diff
	epatch ${FILESDIR}/2.3.3/mips-addabi.diff
	epatch ${FILESDIR}/2.3.3/mips-syscall.h.diff
	epatch ${FILESDIR}/2.3.3/semtimedop.diff
	epatch ${FILESDIR}/2.3.3/mips-sysify.diff

	if use n32 || use n64; then
		epatch ${FILESDIR}/2.3.4/mips-sysdep-cancel.diff
	fi

	# Need to install into /lib for n32-only userland for now.
	# Propper solution is to make all userland /lib{32|64}-aware.
	use multilib || epatch ${FILESDIR}/2.3.3/mips-nolib3264.diff
}


do_arch_ppc_patches() {
	cd ${S};
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-nptl-altivec.patch
	# Any needed patches for ppc go here
}


do_arch_ppc64_patches() {
	cd ${S};
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-nptl-altivec.patch
	# Any needed patches for ppc64 go here
}


do_arch_s390_patches() {
	cd ${S};

	# Any needed patches for s390 go here
}


do_arch_sparc_patches() {
	cd ${S};

	# Any needed patches for sparc go here
}


do_arch_x86_patches() {
	cd ${S};

	# Any needed patches for x86 go here
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
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3_pre20040117-got-fix.diff
}


do_hardened_fixes() {
	# disable binutils -as-needed
	sed -e 's/^have-as-needed.*/have-as-needed = no/' -i ${S}/config.make.in

	# disable relro usage for ld.so
	# mandatory, if binutils supports relro and the kernel is pax/grsecurity enabled
	# solves almost all segfaults building the locale files on grsecurity enabled kernels and
	# Inconsistency detected by ld.so: dl-fini.c: 69: Assertion `i == _rtld_local dl_nloaded' failed!
	# the real tested conditions, where this definitely has to be applied are for now:
	# use build || use bootstrap || use hardened || <pax/grsec kernel>
	sed -e 's/^LDFLAGS-rtld += $(relro.*/LDFLAGS-rtld += -Wl,-z,norelro/' -i ${S}/Makeconfig

	# disables building nscd as pie
	has_hardened || sed -e 's/^have-fpie.*/have-fpie = no/' -i ${S}/config.make.in

	# disable completely relro usage (also for ld.so)
	has_hardened || sed -e 's/^have-z-relro.*/have-z-relro = no/' -i ${S}/config.make.in
	has_hardened || sed -e 's/HAVE_Z_RELRO/USE_Z_RELRO/' -i ${S}/config.h.in

	# Sanity check the forward and backward chunk pointers in the
	# unlink() macro used by Doug Lea's implementation of malloc(3).
	epatch ${FILESDIR}/2.3.3/glibc-2.3.3-owl-malloc-unlink-sanity-check.diff

	# this patch is needed to compile nptl with a hardened gcc
	has_hardened && want_nptl && \
		epatch ${FILESDIR}/2.3.4/glibc-2.3.4-hardened-sysdep-shared.patch
}


do_ssp_patches() {
	# To circumvent problems with propolice __guard and
	# __guard_setup__stack_smash_handler
	#
	#  http://www.gentoo.org/proj/en/hardened/etdyn-ssp.xml
	if [ "${ARCH}" != "hppa" ] && [ "${ARCH}" != "hppa64" ]; then
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
	# Remove all info files, as newer versions have about 10 libc info pages,
	# but older release tarballs have about 50, giving us a lot of unneeded
	# crap laying around ...
	rm -f ${S}/manual/*.info*

	if (! want_nptl) && [ -z "${BRANCH_UPDATE}" ]; then
		unpack ${PN}-linuxthreads-${BASE_PV}.tar.bz2
	else
		rm -rf ${S}/linuxthreads
	fi

	if [ -n "${BRANCH_UPDATE}" ]; then
		epatch ${DISTDIR}/${PN}-${NEW_PV}-branch-update-${BRANCH_UPDATE}.patch.bz2

		# Snapshot date patch
		einfo "Patching version to display snapshot date ..."
		sed -i -e "s:\(#define RELEASE\).*:\1 \"${BRANCH_UPDATE}\":" version.h
	fi
	# Version patch
	sed -i -e "s:\(#define VERSION\).*:\1 \"${NEW_PV}\":" version.h

	# SSP support in glibc (where it belongs)
	do_ssp_patches


	# PaX-related Patches
	do_pax_patches


	# hardened toolchain/relro/nptl/security/etc fixes
	do_hardened_fixes


	# Arch specific patching
	use amd64	&& do_arch_amd64_patches
	use alpha	&& do_arch_alpha_patches
	use arm		&& do_arch_arm_patches
	use hppa	&& do_arch_hppa_patches
	use ia64	&& do_arch_ia64_patches
	use mips	&& do_arch_mips_patches
	use ppc		&& do_arch_ppc_patches
	use ppc64	&& do_arch_ppc64_patches
	use s390	&& do_arch_s390_patches
	use sparc	&& do_arch_sparc_patches
	use x86		&& do_arch_x86_patches


	# Remaining patches
	cd ${S}

	# Fix permissions on some of the scripts
	chmod u+x ${S}/scripts/*.sh
}

src_compile() {
	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	use nls || myconf="${myconf} --disable-nls"
	use erandom || myconf="${myconf} --disable-dev-erandom"
	use hardened && myconf="${myconf} --enable-bind-now"

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

	# some silly people set LD_RUN_PATH and that breaks things.
	# see bug 19043
	unset LD_RUN_PATH

	einfo "Configuring GLIBC..."
	rm -rf ${WORKDIR}/build
	mkdir -p ${WORKDIR}/build
	cd ${WORKDIR}/build
	${S}/configure \
		--build=${CHOST} \
		--host=${CCHOST} \
		--disable-profile \
		--without-gd \
		--without-cvs \
		--with-headers=${ALT_HEADERS} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib/misc \
		${myconf} || die

	einfo "Building GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" || die
}

src_install() {
	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	cd ${WORKDIR}/build

	einfo "Installing GLIBC..."
	make PARALLELMFLAGS="${MAKEOPTS}" \
		install_root=${D} \
		install || die

	# If librt.so is a symlink, change it into linker script (Redhat)
	if [ -L "${D}/usr/lib/librt.so" -a "${LIBRT_LINKERSCRIPT}" = "yes" ]; then
		local LIBRTSO="`cd ${D}/lib; echo librt.so.*`"
		local LIBPTHREADSO="`cd ${D}/lib; echo libpthread.so.*`"

		rm -f ${D}/usr/lib/librt.so
		cat > ${D}/usr/lib/librt.so <<EOF
/* GNU ld script
	librt.so.1 needs libpthread.so.0 to come before libc.so.6*
	in search scope.  */
EOF
		grep "OUTPUT_FORMAT" ${D}/usr/lib/libc.so >> ${D}/usr/lib/librt.so
		echo "GROUP ( /lib/${LIBPTHREADSO} /lib/${LIBRTSO} )" \
			>> ${D}/usr/lib/librt.so

		for x in ${D}/usr/lib/librt.so.[1-9]; do
			[ -L "${x}" ] && rm -f ${x}
		done
	fi

	if ! use build; then
		cd ${WORKDIR}/build

		einfo "Installing Info pages..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			info -i

		setup_locales

		einfo "Installing man pages and docs..."
		# Install linuxthreads man pages even if nptl is enabled
			dodir /usr/share/man/man3
			doman ${S}/man/*.3thr

		# Install nscd config file
		insinto /etc
		doins ${FILESDIR}/nscd.conf

		cd ${S}
		dodoc BUGS ChangeLog* CONFORMANCE COPYING* FAQ INTERFACE \
			NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share ${D}/usr/lib/gconv

		einfo "Installing Timezone data..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			timezone/install-others -C ${WORKDIR}/build || die
	fi

	if use pic && use !amd64; then
		find ${S}/${buildtarget}/ -name "soinit.os" -exec cp {} ${D}/lib/soinit.o \;
		find ${S}/${buildtarget}/ -name "sofini.os" -exec cp {} ${D}/lib/sofini.o \;
		find ${S}/${buildtarget}/ -name "*_pic.a" -exec cp {} ${D}/lib \;
		find ${S}/${buildtarget}/ -name "*.map" -exec cp {} ${D}/lib \;

		for i in ${D}/lib/*.map; do
			mv ${i} ${i%.map}_pic.map
		done
	fi

	# Is this next line actually needed or does the makefile get it right?
	# It previously has 0755 perms which was killing things.
	fperms 4711 /usr/lib/misc/pt_chown

	# Currently libraries in  /usr/lib/gconv do not get loaded if not
	# in search path ...
#	insinto /etc/env.d
#	doins ${FILESDIR}/03glibc

	rm -f ${D}/etc/ld.so.cache

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f ${D}/etc/localtime

	# Some things want this, notably ash.
	dosym /usr/lib/libbsd-compat.a /usr/lib/libbsd.a

	# This is our new config file for building locales
	insinto /etc
	doins ${FILESDIR}/locales.build

	if use makecheck; then
		local OLD_SANDBOX_ON="${SANDBOX_ON}"
		# make check will fail if sandbox is enabled.  Do not do it
		# globally though, else we might fail to find sandbox violations ...
		SANDBOX_ON="0"
		do_makecheck
		SANDBOX_ON="${OLD_SANDBOX_ON}"
	fi
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

	if [ ! -e "${ROOT}/ld.so.1" -a "`use ppc64`" ]
	then
		pushd ${ROOT}
		cd ${ROOT}/lib
		ln -s ld64.so.1 ld.so.1
		popd
	fi

	# Reload init ...
	if [ "${ROOT}" = "/" ]; then
		/sbin/init U &> /dev/null
	fi
}
