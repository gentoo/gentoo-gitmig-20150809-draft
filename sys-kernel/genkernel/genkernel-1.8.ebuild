# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-1.8.ebuild,v 1.4 2004/06/24 22:56:28 agriffis Exp $

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~drobbins/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}


src_install() {
	insinto /etc/kernels
	doins settings default-config

	exeinto /usr/sbin
	doexe genkernel

	#Put general files in /usr/share/genkernel for FHS compliance
	insinto /usr/share/genkernel
	doins archives/* linuxrc

	dodoc README
}
