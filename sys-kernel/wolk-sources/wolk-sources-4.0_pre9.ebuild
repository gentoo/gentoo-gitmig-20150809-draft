# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/wolk-sources/wolk-sources-4.0_pre9.ebuild,v 1.2 2003/02/10 07:06:27 sethbc Exp $

IUSE="build"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel || die

OKV=2.4.20
EXTRAVERSION=-wolk4.0s-pre9
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}
DESCRIPTION="Working Overloaded Linux Kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://sourceforge/wolk/linux-${KV}.patch.bz2"
KEYWORDS="~x86"
SLOT="${KV}"
HOMEPAGE="http://wolk.sourceforge.net http://www.kernel.org"

src_unpack() {
    unpack linux-${OKV}.tar.bz2
    mv linux-${OKV} linux-${KV} || die
    cd ${WORKDIR}/linux-${KV}
    bzcat ${DISTDIR}/linux-${OKV}${EXTRAVERSION}.patch.bz2 | patch -p1
}
src_install() {
		 dodir /usr/src
                echo ">>> Copying sources..."
		dodoc ${FILESDIR}/patches.txt
                mv ${WORKDIR}/linux* ${D}/usr/src
}

pkg_postinst() {
                rm -f ${ROOT}usr/src/linux
                
				# DONT DO THIS, ITS BAD
				# ln -sf linux-${KV} ${ROOT}/usr/src/linux
}

