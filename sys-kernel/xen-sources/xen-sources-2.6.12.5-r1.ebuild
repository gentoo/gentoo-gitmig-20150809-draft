# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xen-sources/xen-sources-2.6.12.5-r1.ebuild,v 1.3 2005/10/27 16:29:14 chrb Exp $

ETYPE="sources"
inherit kernel-2 eutils
detect_arch
detect_version

EXTRAVERSION=".${KV_EXTRA}-xen"

DESCRIPTION="Full sources for a dom0/domU Linux kernel to run under Xen"
HOMEPAGE="http://www.cl.cam.ac.uk/Research/SRG/netos/xen/index.html"
DATE="20051010"
SRC_URI="${KERNEL_URI} mirror://gentoo/xen-unstable-${DATE}.tar.bz2"

KEYWORDS="~x86"
DEPEND="=app-emulation/xen-3.0.0_pre${DATE}-r1"
S="${WORKDIR}"
RESTRICT="nostrip"

src_unpack() {
	unpack xen-unstable-${DATE}.tar.bz2
	cd xen-unstable-${DATE}
	epatch ${FILESDIR}/mkbuildtree.patch
	make LINUX_SRC_PATH=${DISTDIR} -f buildconfigs/mk.linux-2.6-xen \
		linux-2.6.12-xen/include/linux/autoconf.h
	t=linux-2.6.12-xen
	cp XEN-VERSION ${t}
	echo ARCH=xen | cat - ${t}/Makefile | sed -e "s/-xen/.5-xen/" >${t}/Makefile.0
	mv ${t}/Makefile.0 ${t}/Makefile
	mv ${t} ${WORKDIR}/linux-2.6.12.5-xen
	rm -rf ${WORKDIR}/xen-unstable-${DATE}
}
