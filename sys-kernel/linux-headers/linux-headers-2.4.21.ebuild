# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.21.ebuild,v 1.4 2003/09/12 09:41:40 kumba Exp $


ETYPE="headers"
inherit kernel
OKV=${PV/_/-}
S=${WORKDIR}/linux-${OKV}

# What's in this kernel?

# INCLUDED:
# 1) linux sources from kernel.org
# 2) patch for big-endian machines to fix header issue (currently sparc only)

DESCRIPTION="Linux ${OKV} headers from kernel.org"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${OKV}"
KEYWORDS="-* amd64 ~sparc"


# Figure out what architecture we are, and set KERNEL_ARCH appropriately
ARCH="${ARCH:-`uname -m`}"
ARCH=`echo $ARCH | sed -e s/[i].86/i386/ -e s/x86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/ -e s/amd64/x86_64/`
[ "$ARCH" == "sparc" -a "$PROFILE_ARCH" == "sparc64" ] && ARCH=sparc64


# Archs which have their own separate header packages, add a check here
# and redirect the user to them
if [ "${ARCH}" = "mips" ] || [ "${ARCH}" = "mips64" ]; then
	eerror "These headers are not appropriate for your architecture."
	eerror "Please use sys-kernel/${ARCH/64/}-headers instead."
	die
fi



src_unpack() {
	unpack ${A}
	cd ${S}

	# Big Endian architectures need this patch in order to build certain programs properly
	# Right now, this fix only affects sparc.  hppa and ppc will need to edit this later.
	# Closes Bug #26062
	if [ -n "`use sparc`" ]; then
		epatch ${FILESDIR}/bigendian-byteorder-fix.patch
	fi

	# Do Stuff
	kernel_universal_unpack
}

src_compile() {

	# Do normal src_compile stuff
	kernel_src_compile

	# If this is sparc, then geneate asm_offsets.h
	if [ -n "`use sparc`" ]; then
		make dep ARCH=sparc || die "Failed to run 'make dep'"
	fi
}

src_install() {

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
		if [ "$PROFILE_ARCH" = "sparc64" ]; then
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
}

pkg_preinst() {
	kernel_pkg_preinst
}

pkg_postinst() {
	kernel_pkg_postinst
}
