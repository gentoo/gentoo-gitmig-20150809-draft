# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

# Kernel patch name
KPATCH=systrace-linux-2.4.20-v1.2.diff

OKV=2.4.20
EXTRAVERSION=-hardened
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}
DESCRIPTION="Special Security Hardened Gentoo Kernel (don't use this yet, it isn't ready)"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
 	 mirror://gentoo/patches-${KV}.tar.bz2"


HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/hardened/"
KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2 patches-${KV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	
	cd ${KV}
	kernel_src_unpack
}

pkg_postinst() {
	kernel_pkg_postinst
	einfo "This kernel contains LSM, GRSec2, and Systrace"
	einfo "This is not yet a production ready kernel.  If you experience problems with"
	einfo "this kernel please report them by assigning bugs on bugs.gentoo.org to"
	einfo "frogger@gentoo.org"
}
