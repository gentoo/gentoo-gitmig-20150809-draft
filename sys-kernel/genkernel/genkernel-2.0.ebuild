# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-2.0.ebuild,v 1.2 2003/10/19 20:43:57 lanius Exp $

BUSYBOX="busybox-0.60.5"
CLOOP="cloop_1.02-1"

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~zhen/${P}.tar.bz2 \
		 http://www.gentoo.org/~zhen/${BUSYBOX}.tar.gz \
		 http://www.gentoo.org/~zhen/${CLOOP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_install() {
	insinto /etc/kernels
	doins files/settings files/default-config-*

	exeinto /usr/sbin
	doexe genkernel

	#Put general files in /usr/share/genkernel for FHS compliance
	insinto /usr/share/genkernel
	doins src/linuxrc src/key.lst src/1024.initrd files/livecdrc ${DISTDIR}/${BUSYBOX} ${DISTDIR}/${CLOOP}

	dodoc README
	dodoc ChangeLog
}
