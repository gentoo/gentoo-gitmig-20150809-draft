# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-dev/ppc-sources-dev-2.4.22-r1.ebuild,v 1.1 2004/01/08 21:30:08 plasmaroo Exp $

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
#   benh 2.4.22-2
#   Pegasos 20030902
#   Amiga SFS 0.6
#   Orinoco Monitor 0.13
#   O_STREAMING
#   GRsecurity 2.0-rc3
#   ea+acl+nfsacl 0.8.60
#   XFS 1.30
#   Cryptoloop Jari
#   Super FreeS/WAN 2.01
#   x509 1.4.5
#   Extra bootlogos
#   Bootsplash 3.0.7 (Does not work on Macs)


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
	cd ${S}
	epatch ${FILESDIR}/ppc-sources-dev-2.4.22-r1.via-pmu.diff || die "patch failed"
	epatch ${FILESDIR}/${P}.do_brk.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${P}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

}

pkg_postinst()
{
	kernel_pkg_postinst

	ewarn "Bootsplash currently does not work on Macs."
}
