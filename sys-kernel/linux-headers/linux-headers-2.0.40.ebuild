# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.0.40.ebuild,v 1.1 2004/04/10 06:42:18 kumba Exp $

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
SRC_URI="mirror://kernel/linux/kernel/v2.0/linux-${OKV}.tar.bz2"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
PROVIDE="virtual/kernel virtual/os-headers"
KEYWORDS="-*"


pkg_setup() {
	# Catch any archs that don't need these headers
	case "${ARCH}" in
		alpha|amd64|arm|hppa|ia64|mips|ppc|ppc64|s390|sparc)
			echo -e ""
			echo -e ""
			eerror "These headers are too old for your arch.  Use 2.4.x and up, these"
			eerror "are only here for reference purposes."
#			die
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
