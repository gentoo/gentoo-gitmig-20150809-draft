# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux26-headers/linux26-headers-2.6.8.1-r3.ebuild,v 1.1 2005/01/11 02:57:56 eradicator Exp $

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org

ETYPE="headers"
inherit kernel eutils

OKV="${PV/_/-}"
KV="${OKV}"
EXTRAVERSION=""

DESCRIPTION="Linux ${OKV} headers from kernel.org"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	mirror://gentoo/linux-2.6.8.1-sh-headers.patch.bz2"

LICENSE="GPL-2"
#KEYWORDS="~alpha amd64 arm hppa ia64 ~ppc ppc64 ~sparc sh x86"
# Just amd64 fixes over -r2
KEYWORDS="~amd64"
IUSE=""

if [[ ${CTARGET} = ${CHOST} ]]
then
	DEPEND="!virtual/os-headers"
	PROVIDE="virtual/kernel virtual/os-headers"
	SLOT="0"
else
	SLOT="${CTARGET}"
fi

S=${WORKDIR}/linux-${OKV}

headers___fix() {
	sed -i \
		-e "s/\([ "$'\t'"]\)u8\([ "$'\t'"]\)/\1__u8\2/g;" \
		-e "s/\([ "$'\t'"]\)u16\([ "$'\t'"]\)/\1__u16\2/g;" \
		-e "s/\([ "$'\t'"]\)u32\([ "$'\t'"]\)/\1__u32\2/g;" \
		-e "s/\([ "$'\t'"]\)u64\([ "$'\t'"]\)/\1__u64\2/g;" \
		"$@"
}

pkg_setup() {
	# Archs which have their own separate header packages, add a check here
	# and redirect the user to them
	case "${ARCH}" in
		mips)
			eerror "These headers are not appropriate for your architecture."
			eerror "Please use sys-kernel/mips-headers instead."
			die
		;;
	esac
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/linux-2.6.8.1-sh-headers.patch

	# Do Stuff
	kernel_universal_unpack

	# User-space patches for various things
	epatch ${FILESDIR}/${PN}-2.6.0-sysctl_h-compat.patch
	epatch ${FILESDIR}/${PN}-2.6.0-fb.patch
	epatch ${FILESDIR}/${PN}-2.6.7-generic-arm-prepare.patch
	epatch ${FILESDIR}/${P}-strict-ansi-fix.patch
	epatch ${FILESDIR}/${P}-appCompat.patch
	epatch ${FILESDIR}/${P}-sparc-glibcsafe.patch
	epatch ${FILESDIR}/${PN}-soundcard-ppc64.patch
	epatch ${FILESDIR}/${P}-arm-float.patch
	epatch ${FILESDIR}/${P}-parisc-syscall.patch

	# Fixes
	headers___fix ${S}/include/asm-ia64/*
	headers___fix ${S}/include/asm-ppc64/*
	headers___fix ${S}/include/asm-ppc64/iSeries/*
}

src_compile() {
	# autoconf.h isnt generated unless it already exists. plus, we have
	# no guarantee that any headers are installed on the system...
	[ -f "${ROOT}"/usr/include/linux/autoconf.h ] \
		|| touch include/linux/autoconf.h

	# When cross-compiling, we need to set the CROSS_COMPILE var properly
	local extra_makeopts=
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		extra_makeopts="CROSS_COMPILE=${CTARGET}-"
	elif type -p ${CHOST}-ar ; then
		extra_makeopts="CROSS_COMPILE=${CHOST}-"
	fi

	# if there arent any installed headers, then there also isnt an asm
	# symlink in /usr/include/, and make defconfig will fail, so we have
	# to force an include path with $S.
	local HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include/"

	set_arch_to_kernel
	ln -sf ${S}/include/asm-${ARCH} ${S}/include/asm
	make defconfig HOSTCFLAGS="${HOSTCFLAGS}" ${extra_makeopts} || die "defconfig failed"
	make prepare HOSTCFLAGS="${HOSTCFLAGS}" ${extra_makeopts} || die "prepare failed"
	set_arch_to_portage
}

src_install() {
	# Do normal src_install stuff
	kernel_src_install

	# Sorry, but this multilib includes stuff NEEDS to be abstracted better...
	# I'll do it soon... --eradicator

	# If this is sparc, then we need to place asm_offsets.h in the proper location(s)
	if [ "${PROFILE_ARCH}" = "sparc64" -o "${PROFILE_ARCH}" = "sparc64-multilib" ] ; then
		# We don't need the asm dir, generate-asm-sparc will take care of this
		rm -Rf ${D}/${LINUX_INCDIR}/asm

		# We do need empty directories, though...
		dodir ${LINUX_INCDIR}/asm
		dodir ${LINUX_INCDIR}/asm-sparc
		dodir ${LINUX_INCDIR}/asm-sparc64

		# Copy asm-sparc and asm-sparc64
		cp -ax ${S}/include/asm-sparc/* ${D}/${LINUX_INCDIR}/asm-sparc
		cp -ax ${S}/include/asm-sparc64/* ${D}/${LINUX_INCDIR}/asm-sparc64

		# Check if generate-asm-sparc exists
		if [ -a "${FILESDIR}/generate-asm-sparc" ]; then
			# Copy generate-asm-sparc into the sandox
			cp ${FILESDIR}/generate-asm-sparc ${WORKDIR}/generate-asm-sparc

			# Just in case generate-asm-sparc isn't executable, make it so
			if [ ! -x "${WORKDIR}/generate-asm-sparc" ]; then
				chmod +x ${WORKDIR}/generate-asm-sparc
			fi

			# Generate asm for sparc systems
			${WORKDIR}/generate-asm-sparc ${D}/${LINUX_INCDIR}
		else
			eerror "${FILESDIR}/generate-asm-sparc doesn't exist!"
			die
		fi
	fi

	# If this is sparc, then we need to place asm_offsets.h in the proper location(s)
	if [ "${ARCH}" = "amd64" ]; then
		# We don't need the asm dir, generate-asm-sparc will take care of this
		rm -Rf ${D}/${LINUX_INCDIR}/asm

		# We do need empty directories, though...
		dodir ${LINUX_INCDIR}/asm
		dodir ${LINUX_INCDIR}/asm-i386
		dodir ${LINUX_INCDIR}/asm-x86_64

		cp -ax ${S}/include/asm-i386/* ${D}/${LINUX_INCDIR}/asm-i386
		cp -ax ${S}/include/asm-x86_64/* ${D}/${LINUX_INCDIR}/asm-x86_64

		# Check if generate-asm-amd64 exists
		if [ -a "${FILESDIR}/generate-asm-amd64" ]; then
			# Copy generate-asm-amd64 into the sandox
			cp ${FILESDIR}/generate-asm-amd64 ${WORKDIR}/generate-asm-amd64

			# Just in case generate-asm-amd64 isn't executable, make it so
			if [ ! -x "${WORKDIR}/generate-asm-amd64" ]; then
				chmod +x ${WORKDIR}/generate-asm-amd64
			fi

			# Generate asm for sparc systems
			${WORKDIR}/generate-asm-amd64 ${D}/${LINUX_INCDIR}
		else
			eerror "${FILESDIR}/generate-asm-amd64 doesn't exist!"
			die
		fi
	fi

	# If this is 2.5 or 2.6 headers, then we need asm-generic too
	if [ "`KV_to_int ${OKV}`" -ge "`KV_to_int 2.6.0`" ]; then
		dodir ${LINUX_INCDIR}/asm-generic
		cp -ax ${S}/include/asm-generic/* ${D}/${LINUX_INCDIR}/asm-generic
	fi
}

pkg_preinst() {
	kernel_pkg_preinst
}

pkg_postinst() {
	kernel_pkg_postinst

	einfo "Kernel headers are usually only used when recompiling glibc, as such, following the installation"
	einfo "of newer headers, it is advised that you re-merge glibc as follows:"
	einfo "emerge glibc"
	einfo "Failure to do so will cause glibc to not make use of newer features present in the updated kernel"
	einfo "headers."
}
