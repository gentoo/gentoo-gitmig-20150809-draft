# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/glibc/glibc-2.3.4.20041102.ebuild,v 1.11 2004/12/05 20:47:32 solar Exp $

inherit eutils flag-o-matic gcc versionator

# Branch update support.  Following will disable:
#  BRANCH_UPDATE=
BRANCH_UPDATE="20041102"

# Minimum kernel version we support
# (Recent snapshots fails with 2.6.5 and earlier)
# also, we do not have a single 2.4 kernel in the tree with backported
# support required to enable nptl.
MIN_KERNEL_VERSION="2.6.5"

# (very) Theoretical cross-compiler support
export CTARGET="${CTARGET:-${CHOST}}"


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

HPPA_PATCHES=2004-09-30

SRC_URI="http://dev.gentoo.org/~lv/${PN}-${BASE_PV}.tar.bz2
	http://dev.gentoo.org/~lv/${PN}-manpages-${NEW_PV}.tar.bz2
	http://dev.gentoo.org/~lv/glibc-infopages-${NEW_PV}.tar.bz2
	hppa? ( http://parisc-linux.org/~carlos/glibc-work/glibc-hppa-patches-${HPPA_PATCHES}.tar.gz )"

[ ! -z "${BRANCH_UPDATE}" ] && SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~lv/${PN}-${NEW_PV}-branch-update-${BRANCH_UPDATE}.patch.bz2"

LICENSE="LGPL-2"
SLOT="2.2"
KEYWORDS="~amd64 ppc64 -hppa ~ia64 ~ppc ~x86 ~mips"
IUSE="nls pic build nptl nptlonly erandom hardened multilib debug userlocales nomalloccheck"
RESTRICT="nostrip" # we'll handle stripping ourself #46186

# We need new cleanup attribute support from gcc for NPTL among things ...
# We also need linux26-headers if using NPTL. Including kernel headers is
# incredibly unreliable, and this new linux-headers release from plasmaroo
# should work with userspace apps, at least on amd64 and ppc64.
DEPEND=">=sys-devel/gcc-3.2.3-r1
	nptl? ( >=sys-devel/gcc-3.3.1-r1 )
	>=sys-devel/binutils-2.14.90.0.6-r1
	virtual/os-headers
	nptl? ( >=sys-kernel/linux26-headers-2.6.5 )
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/os-headers
	sys-apps/baselayout
	nls? ( sys-devel/gettext )"
# until we compile the 32bit glibc here
PDEPEND="amd64? ( multilib? ( app-emulation/emul-linux-x86-glibc ) )"

PROVIDE="virtual/glibc virtual/libc"

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
		echo /usr/${CTARGET}/lib
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
		if [ "${PROFILE_ARCH}" = "sparc64" ]; then
			# Get rid of -mcpu options (the CHOST will fix this up) and flags
			# known to fail
			filter-flags "-mcpu=ultrasparc -mcpu=v9 -mvis"

			# Setup the CHOST properly to insure "sparcv9"
			# This passes -mcpu=ultrasparc -Wa,-Av9a to the compiler
			if [ "${CHOST}" = "sparc-unknown-linux-gnu" ]; then
				export CHOST="sparcv9-unknown-linux-gnu"
				export CTARGET="sparcv9-unknown-linux-gnu"
			fi
		fi
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
	local header="$(alt_headers)/linux/version.h"

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
	if use nptl || use nptlonly ; then
		# Archs that can use NPTL
		if use amd64 || use ia64 || use ppc || \
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


install_locales() {
	unset LANGUAGE LANG LC_ALL
	cd ${WORKDIR}/${MYMAINBUILDDIR} || die "${WORKDIR}/${MYMAINBUILDDIR}"
	make PARALLELMFLAGS="${MAKEOPTS}" \
		install_root=${D} localedata/install-locales || die
	keepdir /usr/lib/locale/ru_RU/LC_MESSAGES
}


setup_locales() {
	if use !userlocales ; then
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
	if use nptlonly && use !nptl ; then
		eerror "If you want nptlonly, add nptl to your USE too ;p"
		die "nptlonly without nptl"
	fi

	# give some sort of warning about the nptl logic changes...
	if want_nptl && use !nptlonly ; then
		ewarn "Warning! Gentoo's GLIBC with NPTL enabled now behaves like the"
		ewarn "glibc from almost every other distribution out there. This means"
		ewarn "that glibc is compiled -twice-, once with linuxthreads and once"
		ewarn "with nptl. The NPTL version is installed to lib/tls and is still"
		ewarn "used by default. If you do not need nor want the linuxthreads"
		ewarn "fallback, you can disable this behavior by adding nptlonly to"
		ewarn "USE to save yourself some compile time."
		ebeep
		epause
	fi
}


do_arch_amd64_patches() {
	cd ${S};
	# CONF_LIBDIR support
	epatch ${FILESDIR}/2.3.4/glibc-gentoo-libdir.patch
	sed -i -e "s:@GENTOO_LIBDIR@:$(get_libdir):g" ${S}/sysdeps/unix/sysv/linux/configure
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
	epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-arm-ioperm.patch
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

	unset EPATCH_OPTS

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
	# do can (probably) be found in the patch headers.
	epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-librt-mips.patch
	epatch ${FILESDIR}/2.3.1/${PN}-2.3.1-fpu-cw-mips.patch
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-addabi.diff
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-syscall.h.diff
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-sysify.diff
	epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-semtimedop.diff
	epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-mips-update-__throw.patch
	epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-mips-prot_grows-undefined.patch
	epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-mips-rtld_deepbind-undefined.patch
	epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-mips-add-missing-sgidefs_h.patch

	# Need to install into /lib for n32-only userland for now.
	# Propper solution is to make all userland /lib{32|64}-aware.
	use multilib || epatch ${FILESDIR}/2.3.3/${PN}-2.3.3-mips-nolib3264.diff
}


do_arch_ppc_patches() {
	cd ${S};
	# Any needed patches for ppc go here
}


do_arch_ppc64_patches() {
	cd ${S};
	# Any needed patches for ppc64 go here

	# setup lib -- seems like a good place to set this up
	get_libdir_override lib64
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
	# CONF_LIBDIR support
	epatch ${FILESDIR}/2.3.4/glibc-gentoo-libdir.patch
	sed -i -e "s:@GENTOO_LIBDIR@:$(get_libdir):g" ${S}/sysdeps/unix/sysv/linux/configure
}


do_pax_patches() {
	cd ${S}

	# localedef contains nested function trampolines, which trigger
	# segfaults under PaX -solar
	# Debian Bug (#231438, #198099)
	#epatch ${FILESDIR}/2.3.3/glibc-2.3.3-localedef-fix-trampoline.patch
	# with the redhat patch included, the above is no longer needed.

	# With latest versions of glibc, a lot of apps failed on a PaX enabled
	# system with:
	#
	#  cannot enable executable stack as shared object requires: Permission denied
	#
	# This is due to PaX 'exec-protecting' the stack, and ld.so then trying
	# to make the stack executable due to some libraries not containing the
	# PT_GNU_STACK section.  Bug #32960.  <azarah@gentoo.org> (12 Nov 2003).
	use mips || epatch ${FILESDIR}/2.3.4/${PN}-2.3.4-dl_execstack-PaX-support.patch

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


do_fedora_patches() {
	pushd ${S} > /dev/null

	# go team ramdom nptl stuff
	want_nptl && epatch ${S}/fedora/glibc-nptl-check.patch

	# remove the fedora-branch glibc 2.0 compat stuff.
	rm -rf glibc-compat
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-fedora-branch-no-libnoversion.patch
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-fedora-branch-no-force-nontls.patch

	rm -f sysdeps/alpha/alphaev6/memcpy.S
	find . -type f -size 0 -o -name "*.orig" -exec rm -f {} \;
	touch `find . -name configure`

	# If gcc supports __thread, test it even in --with-tls --without-__thread
	# builds.
	if echo '__thread int a;' | $GCC -xc - -S -o /dev/null 2>/dev/null; then
		sed -i -e 's~0 ||~1 ||~' ./elf/tst-tls10.h ./linuxthreads/tst-tls1.h
	fi

	popd > /dev/null
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

	# redhat stuffs
	do_fedora_patches

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
		sed -i -e '/static-gnulib := /s:-lgcc -lgcc_eh:-lgcc:' Makeconfig
	fi

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
	epatch ${FILESDIR}/2.3.4/glibc-sec-hotfix-20040916.patch

	# multicast DNS aka rendezvous support
	# ...patch updated to make mdns optional
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-mdns-resolver-20041102.diff

	# if __OPTIMIZE__ isnt defined, the comparison in this header
	# fails.
	epatch ${FILESDIR}/2.3.4/glibc-2.3.4-features-header-fix.patch

	# whine whine whine, this patch sets the default for the malloc check
	# to 0, disabling it.
	use nomalloccheck && epatch ${FILESDIR}/2.3.4/glibc-2.3.4-fedora-branch-nomalloccheck.patch

	# Fix permissions on some of the scripts
	chmod u+x ${S}/scripts/*.sh
}


glibc_do_configure() {
	local myconf

	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL
	# silly users
	unset LD_RUN_PATH

	# set addons
	pushd ${S} > /dev/null
	ADDONS=$(echo */configure | sed -e 's!/configure!!g;s!\(linuxthreads\|nptl\|rtkaio\)\( \|$\)!!g;s! \+$!!;s! !,!g;s!^!,!;/^,\*$/d')
	popd > /dev/null

	use nls || myconf="${myconf} --disable-nls"
	use erandom || myconf="${myconf} --disable-dev-erandom"

	if [ "$1" == "linuxthreads" ] ; then
		want_tls && myconf="${myconf} --with-tls --without-__thread"
		want_tls || myconf="${myconf} --without-tls --without-__thread"
		myconf="${myconf} --enable-add-ons=linuxthreads${ADDONS}"
		myconf="${myconf} --enable-kernel=2.4.1"
	elif [ "$1" == "nptl" ] ; then
		want_nptl && myconf="${myconf} --with-tls --with-__thread"
		myconf="${myconf} --enable-add-ons=nptl${ADDONS}"
		myconf="${myconf} --enable-kernel=${MIN_KERNEL_VERSION}"
	else
		die "invalid pthread option"
	fi

	# Who knows if this works :)
	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"
	myconf="${myconf} --without-cvs
			--enable-bind-now
			--build=${CHOST}
			--host=${CTARGET}
			--disable-profile
			--without-gd
			--with-headers=$(alt_headers)
			--prefix=$(alt_prefix)
			--mandir=$(alt_prefix)/share/man
			--infodir=$(alt_prefix)/share/info
			--libexecdir=$(alt_prefix)/lib/misc"

	GBUILDDIR="${WORKDIR}/build-${CTARGET}-$1"
	mkdir -p ${GBUILDDIR}
	cd ${GBUILDDIR}
	einfo "Configuring GLIBC for $1 with: ${myconf}"
	${S}/configure ${myconf} || die "failed to configure glibc"
}


src_compile() {
	# do the linuxthreads build unless we're using nptlonly
	if use !nptlonly ; then
		glibc_do_configure linuxthreads
		einfo "Building GLIBC with linuxthreads..."
		make PARALLELMFLAGS="${MAKEOPTS}" || die
	fi
	if want_nptl ; then
		# ...and then do the optional nptl build
		unset LD_ASSUME_KERNEL || :
		glibc_do_configure nptl
		einfo "Building GLIBC with NPTL..."
		make PARALLELMFLAGS="${MAKEOPTS}" || die
	fi
}

src_install() {
	setup_flags

	# These should not be set, else the
	# zoneinfo do not always get installed ...
	unset LANGUAGE LANG LC_ALL

	if use nptlonly ; then
		MYMAINBUILDDIR=build-${CTARGET}-nptl
	else
		MYMAINBUILDDIR=build-${CTARGET}-linuxthreads
	fi

	if use !nptlonly ; then
		cd ${WORKDIR}/build-${CTARGET}-linuxthreads
		einfo "Installing GLIBC with linuxthreads..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			install || die
	elif use nptlonly ; then
		cd ${WORKDIR}/build-${CTARGET}-nptl
		einfo "Installing GLIBC with NPTL..."
		make PARALLELMFLAGS="${MAKEOPTS}" \
			install_root=${D} \
			install || die
	fi
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		# punt all the junk not needed by a cross-compiler
		rm -r "${D}"/usr/${CTARGET}/{bin,etc,lib/gconv,sbin,share}
	fi

	if use !nptlonly && want_nptl ; then
		einfo "Installing NPTL to $(get_libdir)/tls/..."
		cd ${WORKDIR}/build-${CTARGET}-nptl
		mkdir -p ${D}/$(get_libdir)/tls/

		libcsofile=$(basename ${D}/$(get_libdir)/libc-*.so)
		cp -a libc.so ${D}/$(get_libdir)/tls/${libcsofile} || die
		dosym ${libcsofile} /$(get_libdir)/tls/$(ls libc.so.*)

		libmsofile=$(basename ${D}/$(get_libdir)/libm-*.so)
		pushd math > /dev/null
		cp -a libm.so ${D}/$(get_libdir)/tls/${libmsofile} || die
		dosym ${libmsofile} /$(get_libdir)/tls/$(ls libm.so.*)
		popd > /dev/null

		librtsofile=$(basename ${D}/$(get_libdir)/librt-*.so)
		pushd rt > /dev/null
		cp -a librt.so ${D}/$(get_libdir)/tls/${librtsofile} || die
		dosym ${librtsofile} /$(get_libdir)/tls/$(ls librt.so.*)
		popd > /dev/null

		libthreaddbsofile=$(basename ${D}/$(get_libdir)/libthread_db-*.so)
		pushd nptl_db > /dev/null
		cp -a libthread_db.so ${D}/$(get_libdir)/tls/${libthreaddbsofile} || die
		dosym ${libthreaddbsofile} /$(get_libdir)/tls/$(ls libthread_db.so.*)
		popd > /dev/null

		libpthreadsofile=libpthread-${NEW_PV}.so
		cp -a nptl/libpthread.so ${D}/$(get_libdir)/tls/${libpthreadsofile} || die
		dosym ${libpthreadsofile} /$(get_libdir)/tls/libpthread.so.0

		# and now for the static libs
		mkdir -p ${D}/usr/$(get_libdir)/nptl
		cp -a libc.a nptl/libpthread.a nptl/libpthread_nonshared.a rt/librt.a \
			${D}/usr/$(get_libdir)/nptl
		# linker script crap
		sed "s~/$(get_libdir)/~/$(get_libdir)/tls/~" ${D}/usr/$(get_libdir)/libc.so \
			> ${D}/usr/$(get_libdir)/nptl/libc.so

		sed "s~/$(get_libdir)/~/$(get_libdir)/tls/~" ${D}/usr/$(get_libdir)/libpthread.so \
			> ${D}/usr/$(get_libdir)/nptl/libpthread.so
		sed -i -e "s~/usr/lib64/~/usr/lib64/nptl/~" ${D}/usr/$(get_libdir)/nptl/libpthread.so

		dosym ../${librtsofile} /usr/$(get_libdir)/nptl/librt.so

		# last but not least... headers.
		mkdir -p ${D}/nptl ${D}/usr/include/nptl
		make install_root=${D}/nptl install-headers PARALLELMFLAGS="${MAKEOPTS}"
		pushd ${D}/nptl/usr/include > /dev/null
			for i in `find . -type f`; do
				if ! [ -f ${D}/usr/include/$i ] \
					|| ! cmp -s $i ${D}/usr/include/$i; then
				mkdir -p ${D}/usr/include/nptl/`dirname $i`
				cp -a $i ${D}/usr/include/nptl/$i
			fi
		done
		rm -rf ${D}/nptl
	fi

	# now, strip everything but the thread libs #46186
	mkdir -p ${T}/thread-backup
	mv ${D}/$(alt_libdir)/lib{pthread,thread_db}* ${T}/thread-backup/
	if use !nptlonly && want_nptl ; then
		mkdir -p ${T}/thread-backup/tls
		mv ${D}/$(alt_libdir)/tls/lib{pthread,thread_db}* ${T}/thread-backup/tls
	fi
	env -uRESTRICT prepallstrip
	cp -R -- ${T}/thread-backup/* ${D}/$(alt_libdir)/ || die

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

	cd ${WORKDIR}/${MYMAINBUILDDIR}
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

		cd ${S}
		dodoc BUGS ChangeLog* CONFORMANCE FAQ INTERFACE \
			NEWS NOTES PROJECTS README*
	else
		rm -rf ${D}/usr/share ${D}/usr/$(get_libdir)/gconv

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
	dosym /usr/lib/libbsd-compat.a /usr/lib/libbsd.a

	insinto /etc
	# This is our new config file for building locales
	doins ${FILESDIR}/locales.build
	# example host.conf with multicast dns disabled by default
	doins ${FILESDIR}/2.3.4/host.conf

	must_exist /$(get_libdir)/ libpthread.so.0
}

must_exist() {
	test -e ${D}/${1}/${2} || die "${1}/${2} was not installed"
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
	use amd64 && [ "$(get_libdir)" == "lib64" ] && fix_lib64_symlinks

	# it appears that /lib/tls is sometimes not removed. See bug
	# 69258 for more info.
	if [ -d /${ROOT}/$(get_libdir)/tls ] && use nptlonly ; then
		addwrite /${ROOT}/$(get_libdir)/
		ewarn "nptlonly in USE, removing /${ROOT}/$(get_libdir)/tls..."
		rm -rf /${ROOT}/$(get_libdir)/tls || die
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

	if [ ! -e "${ROOT}/ld.so.1" ] && use ppc64
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

	# warn the few multicast-dns-by-default users we've had about the change
	# in behavior...
	echo
	einfo "Gentoo's glibc now disables multicast dns by default in our"
	einfo "example host.conf. To re-enable this functionality, simply"
	einfo "remove the line that disables it (mdns off)."
	echo
}
