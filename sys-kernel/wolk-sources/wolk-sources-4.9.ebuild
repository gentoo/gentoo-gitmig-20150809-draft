# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.9.ebuild,v 1.6 2004/01/06 00:28:57 plasmaroo Exp $

IUSE="build"

ETYPE="sources"
inherit kernel

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

OKV=2.4.20
WOLK_MAJOR=4
WOLK_MINOR=9
EXTRAVERSION=-wolk${WOLK_MAJOR}.${WOLK_MINOR}s
BASE=-wolk${WOLK_MAJOR}.0s
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}

DESCRIPTION="Working Overloaded Linux Kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
WOLK_PATCHLIST="linux-${OKV}${BASE}.patch.bz2"

# cheat and build it in a constant fashion
for i in `seq 1 ${WOLK_MINOR}`; do
	old="$((${i}-1))"
	new="${i}"
	WOLK_PATCHLIST="${WOLK_PATCHLIST} linux-${OKV}-wolk${WOLK_MAJOR}.${old}s-to-${WOLK_MAJOR}.${new}s.patch.bz2"
done
for i in ${WOLK_PATCHLIST}; do
	SRC_URI="${SRC_URI} mirror://sourceforge/wolk/${i}"
done;

KEYWORDS="x86"
SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd ${WORKDIR}/linux-${KV}

	for i in ${WOLK_PATCHLIST}; do
		bzcat ${DISTDIR}/${i} | patch -p1 || die
	done
	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"
}
src_install() {
	dodir /usr/src
	echo ">>> Copying sources..."
	dodoc ${FILESDIR}/patches.txt
	mv ${WORKDIR}/linux* ${D}/usr/src
}

pkg_postinst() {
	local KERNELPATH="/usr/src/linux-${OKV}-wolk${WOLK_MAJOR}.${WOLK_MINOR}s"
	einfo
	einfo   "If you use one of the NVIDIA modules below, you will need to use the"
	einfo   "supplied rmap patch in ${KERNELPATH}/userspace-patches"
	einfo   "against your nvidia kernel driver source"
	einfo   "cd NVIDIA_kernel-1.0-XXXX "
	einfo	"patch -p1 <${KERNELPATH}/userspace-patches/"
	einfo   "NVIDIA_kernel-1.0-XXXX-2.4-rmap15b.patch"
	einfo   "There are NVIDIA_kernel-1.0-3123 and 1.0-4191 patches supplied."
	einfo
}

