# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-2.0.ebuild,v 1.8 2004/02/06 18:18:27 iggy Exp $

BUSYBOX="busybox-0.60.5"
CLOOP="cloop_1.02-1"

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~zhen/distfiles/${P}.tar.bz2
		 http://dev.gentoo.org/~zhen/distfiles/${BUSYBOX}.tar.gz
		 http://dev.gentoo.org/~zhen/distfiles/${CLOOP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tar.bz2
}

src_install() {
	insinto /etc/kernels
	doins files/settings files/default-config-*

	exeinto /usr/sbin
	doexe genkernel

	#Put general files in /usr/share/genkernel for FHS compliance
	insinto /usr/share/genkernel
	doins src/linuxrc files/key.lst src/1024.initrd files/livecdrc \
		${DISTDIR}/${BUSYBOX}.tar.gz ${DISTDIR}/${CLOOP}.tar.gz

	dodoc README
	dodoc ChangeLog
}
