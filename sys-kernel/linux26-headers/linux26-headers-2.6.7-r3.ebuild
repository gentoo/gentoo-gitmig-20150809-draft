# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux26-headers/linux26-headers-2.6.7-r3.ebuild,v 1.3 2004/07/20 15:12:27 vapier Exp $

ETYPE="headers"
inherit kernel eutils

OKV="${PV/_/-}"
KV="${OKV}"
S=${WORKDIR}/linux-${OKV}
EXTRAVERSION=""

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org

DESCRIPTION="Linux ${OKV} headers from kernel.org"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
PROVIDE="virtual/kernel virtual/os-headers"
KEYWORDS="-* ~x86 ~ppc ~arm ~hppa"
IUSE=""

DEPEND="!virtual/os-headers"

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

	# Do Stuff
	kernel_universal_unpack

	# User-space patches for various things
	epatch ${FILESDIR}/${PN}-2.6.3-strict-ansi-fix.patch
	epatch ${FILESDIR}/${PN}-2.6.0-sysctl_h-compat.patch
	epatch ${FILESDIR}/${PN}-2.6.0-fb.patch
	epatch ${FILESDIR}/${PN}-2.6.7-generic-arm-prepare.patch
}

src_compile() {
	# autoconf.h isnt generated unless it already exists. plus, we have
	# no gurentee that any headers are installed on the system...
	[ -f ${ROOT}/usr/include/linux/autoconf.h ] || \
		touch ${S}/include/linux/autoconf.h
	# if there arent any installed headers, then there also isnt an asm
	# symlink in /usr/include/, and make defconfig will fail.
	set_arch_to_kernel
	ln -sf ${S}/include/asm-${ARCH} ${S}/include/asm
	make defconfig HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include/"
	make prepare || die "prepare failed"
	set_arch_to_portage

	# this must happen after `make prepare`
	epatch ${FILESDIR}/${PN}-2.6.7-appCompat.patch
}

src_install() {
	# Do normal src_install stuff
	kernel_src_install

	# If this is sparc, then we need to place asm_offsets.h in the proper location(s)
	if [ "${PROFILE_ARCH}" = "sparc64" ]; then

		# We don't need /usr/include/asm, generate-asm-sparc will take care of this
		rm -Rf ${D}/usr/include/asm

		# We do need empty directories, though...
		dodir /usr/include/asm
		dodir /usr/include/asm-sparc
		dodir /usr/include/asm-sparc64

		# Copy asm-sparc and asm-sparc64
		cp -ax ${S}/include/asm-sparc/* ${D}/usr/include/asm-sparc
		cp -ax ${S}/include/asm-sparc64/* ${D}/usr/include/asm-sparc64

		# Check if generate-asm-sparc exists
		if [ -a "${FILESDIR}/generate-asm-sparc" ]; then

			# Copy generate-asm-sparc into the sandox
			cp ${FILESDIR}/generate-asm-sparc ${WORKDIR}/generate-asm-sparc

			# Just in case generate-asm-sparc isn't executable, make it so
			if [ ! -x "${WORKDIR}/generate-asm-sparc" ]; then
				chmod +x ${WORKDIR}/generate-asm-sparc
			fi

			# Generate /usr/include/asm for sparc systems
			${WORKDIR}/generate-asm-sparc ${D}/usr/include
		else
			eerror "${FILESDIR}/generate-asm-sparc doesn't exist!"
			die
		fi
	fi

	# If this is 2.5 or 2.6 headers, then we need asm-generic too
	if [ "`KV_to_int ${OKV}`" -ge "`KV_to_int 2.6.0`" ]; then
		dodir /usr/include/asm-generic
		cp -ax ${S}/include/asm-generic/* ${D}/usr/include/asm-generic
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
