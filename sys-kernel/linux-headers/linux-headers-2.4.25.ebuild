# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.25.ebuild,v 1.3 2004/04/07 07:48:26 kumba Exp $

ETYPE="headers"
inherit kernel

OKV="${PV/_/-}"
KV="${OKV}"
S=${WORKDIR}/linux-${OKV}
EXTRAVERSION=""

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org

DESCRIPTION="Linux ${OKV} headers from kernel.org"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
PROVIDE="virtual/kernel virtual/os-headers"
KEYWORDS="-*"


pkg_setup() {
	# Figure out what architecture we are, and set ARCH appropriately
	ARCH="$(uname -m)"
	ARCH=`echo $ARCH | sed -e s/[i].86/i386/ -e s/x86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/ -e s/amd64/x86_64/`
	[ "$ARCH" == "sparc" -a "$PROFILE_ARCH" == "sparc64" ] && ARCH=sparc64


	# Archs which have their own separate header packages, add a check here
	# and redirect the user to them
	case "${ARCH}" in
		mips|mips64|hppa)
			eerror "These headers are not appropriate for your architecture."
			eerror "Please use sys-kernel/${ARCH/64/}-headers instead."
			die
		;;
	esac
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# This patch fixes an issue involving the use of gcc's -ansi flag and the __u64 datatype.
	# It only patches asm-i386, so we only apply it if x86.  Unknown if this is needed for other archs.
	# Closes Bug #32246
	if [ -n "`use x86`" ]; then
		epatch ${FILESDIR}/${PN}-strict-ansi-fix.patch
	fi


	# Do Stuff
	kernel_universal_unpack
}

src_compile() {

	# Do normal src_compile stuff
	kernel_src_compile

	# If this is sparc, then generate asm_offsets.h
	if [ -n "`use sparc`" ]; then
		make ARCH=${ARCH} dep || die "Failed to run 'make dep'"
	fi
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

			# Just incase generate-asm-sparc isn't executable, make it so
			if [ ! -x "${FILESDIR}/generate-asm-sparc" ]; then
				chmod +x ${FILESDIR}/generate-asm-sparc
			fi

			# Generate /usr/include/asm for sparc systems
			${FILESDIR}/generate-asm-sparc ${D}/usr/include
		else
			eerror "${FILESDIR}/generate-asm-sparc doesn't exist!"
			die
		fi
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
