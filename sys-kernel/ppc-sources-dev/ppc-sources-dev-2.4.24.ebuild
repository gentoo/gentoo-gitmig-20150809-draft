# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-dev/ppc-sources-dev-2.4.24.ebuild,v 1.1 2004/02/06 19:29:26 dholm Exp $

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
#   Pegasos 20040131
#   benh 2.4.24-0
#   Orinoco Monitor 0.13
#   O_STREAMING
#   GRsecurity 2.0-rc4
#   ea+acl+nfsacl 0.8.65
#   Cryptoloop Jari-2.4.22.0
#   Extra bootlogos


DESCRIPTION="Full developmental sources for the Gentoo Linux PPC kernel - Experimental!"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	mirror://gentoo/patches-${OKV}-ppc-dev.tar.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~ppc -x86 -sparc -mips -hppa -alpha -arm"
DEPEND=">=sys-devel/binutils-2.11.90.0.31"
RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl virtual/modutils sys-devel/make"


src_unpack()
{
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die "Unable to move kernel source tree to linux-${KV}"

	cd ${WORKDIR}/${KV}
	# This is the crypt USE flag
	# keeps {USAGI/superfreeswan/patch-int/loop-jari}
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

pkg_postinst()
{
	kernel_pkg_postinst

	ewarn "ReiserFS is buggy on PowerPC, avoid using it."
	ewarn "XFS is not supported in this release, it will be in the next one."
}
