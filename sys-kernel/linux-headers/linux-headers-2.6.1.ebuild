# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.1.ebuild,v 1.2 2004/04/06 17:48:22 vapier Exp $

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
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
PROVIDE="virtual/kernel virtual/os-headers"
KEYWORDS="-*"

# Figure out what architecture we are, and set ARCH appropriately
ARCH="$(uname -m)"
ARCH=`echo $ARCH | sed -e s/[i].86/i386/ -e s/x86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/ -e s/amd64/x86_64/`
[ "$ARCH" == "sparc" -a "$PROFILE_ARCH" == "sparc64" ] && ARCH=sparc64

src_unpack() {

	unpack ${A}
	cd ${S}

	# Do Stuff
	kernel_universal_unpack

	# User-space patches for various things
	epatch ${FILESDIR}/linux-headers-2.6.0-appCompat.patch
	epatch ${FILESDIR}/linux-headers-2.6.0-strict-ansi-fix.patch
	epatch ${FILESDIR}/linux-headers-2.6.0-sysctl_h-compat.patch
	epatch ${FILESDIR}/linux-headers-2.6.0-fb.patch

}

src_compile() {

	# Compile the default configuration
	MY_ARCH=${ARCH}
	unset ${ARCH}
	make defconfig
	ARCH=${MY_ARCH}

	# If this is sparc, then generate asm_offsets.h
	if [ -n "`use sparc`" ]; then
		make ARCH=${ARCH} dep || die "Failed to run 'make dep'"
	fi

}

src_install() {

	# XXX Bug in Kernel.eclass requires this fix for now.
	# XXX Remove when kernel.eclass is fixed.
	# XXX 2.4 kernels symlink 'asm' to 'asm-${ARCH}' in include/
	# XXX 2.6 kernels don't, however.  So we fix this here so kernel.eclass can find the include/asm folder
	if [ "`KV_to_int ${OKV}`" -ge "`KV_to_int 2.6.0`" ]; then
		ln -sf ${S}/include/asm-${ARCH} ${S}/include/asm
	fi


	# Do normal src_install stuff
	kernel_src_install

	# If this is sparc, then we need to place asm_offsets.h in the proper location(s)
	if [ -n "`use sparc`" ]; then

		# We don't need /usr/include/asm, generate-asm-sparc will take care of this
		rm -Rf ${D}/usr/include/asm

		# We do need empty directories, though...
		dodir /usr/include/asm
		dodir /usr/include/asm-sparc

		# Copy asm-sparc
		cp -ax ${S}/include/asm-sparc/* ${D}/usr/include/asm-sparc

		# If this is sparc64, then we need asm-sparc64 stuff too
		if [ "${PROFILE_ARCH}" = "sparc64" ]; then
			dodir /usr/include/asm-sparc64
			cp -ax ${S}/include/asm-sparc64/* ${D}/usr/include/asm-sparc64
		fi

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
