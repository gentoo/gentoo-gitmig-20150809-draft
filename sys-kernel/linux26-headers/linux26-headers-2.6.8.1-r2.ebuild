# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux26-headers/linux26-headers-2.6.8.1-r2.ebuild,v 1.2 2005/01/11 04:36:28 vapier Exp $

# What's in this kernel ?  ninja juice ! :D

# INCLUDED:
# 1) linux sources from kernel.org

ETYPE="headers"
inherit kernel eutils toolchain-funcs

OKV="${PV/_/-}"
KV="${OKV}"
EXTRAVERSION=""

DESCRIPTION="Linux ${OKV} headers from kernel.org"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	mirror://gentoo/linux-2.6.8.1-sh-headers.patch.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 arm hppa ia64 ~ppc ppc64 ~s390 ~sparc sh x86"
IUSE=""

if [[ ${CTARGET} = ${CHOST} ]] ; then
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
	case $(tc-arch ${CTARGET}) in
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

	# Fixes ... all the mv magic is to keep sed from dumping 
	# ugly warnings about how it can't work on a directory.
	cd "${S}"/include
	mv asm-ia64/sn asm-ppc64/iSeries .
	headers___fix asm-ia64/*
	mv sn asm-ia64/
	headers___fix asm-ppc64/*
	mv iSeries asm-ppc64/
	headers___fix asm-ppc64/iSeries/*
}

src_compile() {
	# autoconf.h isnt generated unless it already exists. plus, we have
	# no guarantee that any headers are installed on the system...
	[ -f "${ROOT}"/usr/include/linux/autoconf.h ] \
		|| touch include/linux/autoconf.h

	# Kernel ARCH != portage ARCH
	local KARCH=$(tc-arch-kernel ${CTARGET})

	# When cross-compiling, we need to set the CROSS_COMPILE var properly
	local xmakeopts=
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		xmakeopts="CROSS_COMPILE=${CTARGET}-"
	elif type -p ${CHOST}-ar ; then
		xmakeopts="CROSS_COMPILE=${CHOST}-"
	fi
	xmakeopts="${xmakeopts} ARCH=${KARCH}"

	# if there arent any installed headers, then there also isnt an asm
	# symlink in /usr/include/, and make defconfig will fail, so we have
	# to force an include path with $S.
	local HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include/"

	ln -sf ${S}/include/asm-${KARCH} ${S}/include/asm
	make defconfig HOSTCFLAGS="${HOSTCFLAGS}" ${xmakeopts} || die "defconfig failed"
	make prepare HOSTCFLAGS="${HOSTCFLAGS}" ${xmakeopts} || die "prepare failed"
}

src_install() {
	# Do normal src_install stuff
	kernel_src_install

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
