# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-1.6.ebuild,v 1.5 2004/07/15 03:47:42 agriffis Exp $

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~drobbins/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND=""


src_install() {
	dodir /etc/kernels
	cp -rf * ${D}/etc/kernels

	exeinto /usr/sbin
	doexe genkernel

	dodoc README
}
