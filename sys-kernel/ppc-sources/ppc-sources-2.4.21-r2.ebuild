# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources/ppc-sources-2.4.21-r2.ebuild,v 1.7 2004/01/08 06:22:58 iggy Exp $

IUSE="build crypt"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

ETYPE="sources"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${KV}.tar.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="-x86 ppc -sparc -alpha -hppa -mips -arm"
SLOT="${KV}"


src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Error moving kernel source tree to linux-${KV}"

	cd ${WORKDIR}/${KV}

	# This is the crypt USE flag, keeps {USAGI/superfreeswan/patch-int/loop-jari}
	if [ -z "`use crypt`" ]; then
		einfo "No Cryptographic support, dropping patches..."
		for file in 8* ;do
			einfo "Dropping ${file}..."
			rm -f ${file}
		done
	else
		einfo "Cryptographic patches will be applied"
	fi

	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

	kernel_src_unpack
}

pkg_postinst() {

	kernel_pkg_postinst

	ewarn "There is no xfs support in this kernel."
	echo
	ewarn "If iptables/netfilter behaves abnormally, such as 'Invalid Argument',"
	ewarn "you will need to re-emerge iptables to restore proper functionality."
}
