# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-1.5.ebuild,v 1.1 2003/08/01 05:32:10 drobbins Exp $

DESCRIPTION="Gentoo autokernel script" 
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2 http://dev.gentoo.org/~drobbins/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}


src_install() {
	dodir /etc/kernels
	cp -rf * ${D}/etc/kernels

	exeinto /usr/sbin
	doexe genkernel

	dodoc README
}
