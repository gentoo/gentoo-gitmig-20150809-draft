# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-1.1.ebuild,v 1.2 2003/05/17 19:17:55 livewire Exp $

DESCRIPTION="Gentoo autokernel script" 
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

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
