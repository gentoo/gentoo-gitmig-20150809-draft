# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-dev/ppc-sources-dev-2.4.21.ebuild,v 1.4 2004/01/08 21:30:08 plasmaroo Exp $

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
IUSE="build crypt"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-ppc-dev"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"
S=${WORKDIR}/linux-${KV}


# What's in this kernel?

# INCLUDED:
#   benh2
#   Pegasos 2.4.22
#   ASFS 0.5
#   Orinoco Monitor 0.13
#   Preempt-kernel
#   Variable Hz
#   O_STREAMING
#   GRsecurity 2.0-rc2
#   ea+acl+nfsacl 0.8.60
#   XFS 1.30
#   Cryptoloop
#   Crypto
#   FreeS/WAN
#   Extra bootlogos


DESCRIPTION="Full developmental sources for the Gentoo Linux PPC kernel - Experimental!"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${OKV}-ppc-dev.tar.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~ppc -x86 -sparc -mips -hppa -alpha -arm"


src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Unable to move kernel source tree to linux-${KV}"

	cd ${WORKDIR}/${KV}
	# This is the crypt USE flag, keeps {USAGI/superfreeswan/patch-int/loop-jari}
	if [ -z "`use crypt`" ]; then
		einfo "No Cryptographic support, dropping patches..."
		for file in 6* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Cryptographic patches will be applied"
	fi

	kernel_src_unpack
}

pkg_postinst() {
	kernel_pkg_postinst

	ewarn "Preemption can cause problems on PPC. Please only enable it if you are sure"
	ewarn "that you know what you are doing!"
}
