# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.2.26.ebuild,v 1.1 2004/04/10 06:42:19 kumba Exp $

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
SRC_URI="mirror://kernel/linux/kernel/v2.2/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
PROVIDE="virtual/kernel virtual/os-headers"
KEYWORDS="-*"


pkg_setup() {
	# Catch any archs that don't need these headers
	case "${ARCH}" in
		alpha|amd64|arm|hppa|ia64|mips|ppc|ppc64|s390)
			echo -e ""
			echo -e ""
			eerror "These headers are too old for your arch.  Use 2.4.x and up, these"
			eerror "are only here for reference purposes."
			die
			;;
		sparc)
			if [ "${PROFILE_ARCH}" = "sparc64" ]; then
				echo -e ""
				echo -e ""
				eerror "These headers are too old for your arch.  Use 2.4.x and up, these"
				eerror "are only here for reference purposes."
				die
			fi
			;;
	esac

	# Figure out what architecture we are, and set ARCH appropriately
	ARCH="$(uname -m)"
	ARCH=`echo ${ARCH} | sed -e s/[i].86/i386/ -e s/x86/i386/`
}

src_unpack() {
	unpack ${A}
	cd ${S}

	kernel_universal_unpack
}

src_compile() {

	# Do normal src_compile stuff
	kernel_src_compile

	# If this is sparc, then generate asm_offsets.h
	if [ "`use sparc`" ]; then
		make ARCH=${ARCH} dep || die "Failed to run 'make dep'"
	fi
}

src_install() {

	# Do normal src_install stuff
	kernel_src_install

	# If sparc32, make a symlink from asm to asm-sparc
	if [ "`use sparc`" ]; then
		mv ${D}/usr/include/asm ${D}/usr/include/asm-sparc
		ln -sf ${D}/usr/include/asm-sparc ${D}/usr/include/asm
	fi
}

pkg_postinst() {
	kernel_pkg_postinst

	einfo "Kernel headers are usually only used when recompiling glibc, as such, following"
	einfo "the installation of newer headers, it is advised that you re-merge glibc as follows:"
	einfo "emerge glibc"
	einfo "Failure to do so will cause glibc to not make use of newer features present in the"
	einfo "updated kernel headers."
	echo -e ""
	einfo "If you're using these 2.2.x headers, and wish to rebuilod glibc for them, you will"
	einfo "need to edit the glibc ebuild and set the MIN_KV variable near the top to something"
	einfo "other than '2.4.1'"
}
