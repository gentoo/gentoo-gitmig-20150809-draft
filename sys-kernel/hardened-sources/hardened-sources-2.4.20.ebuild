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
 	 http://www.citi.umich.edu/u/provos/systrace/systrace-linux-2.4.20-v1.2.diff"


HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/hardened/"
KEYWORDS="~x86"
SLOT="${KV}"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd ${S}
	patch -p1 < ${DISTDIR}/${KPATCH} || die "Cannot find systrace patch"
}

src_compile() {
	einfo "You must compile and install this kernel *before* you can emerge and use the systrace userland utilities."
}

src_install() {
	dodir /usr/src
	echo ">>> Copying sources..."
	mv ${WORKDIR}/linux-${KV} ${D}/usr/src
}
