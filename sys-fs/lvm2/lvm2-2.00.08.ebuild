# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.08.ebuild,v 1.6 2004/01/17 07:41:40 darkspecter Exp $

MY_P=${PN/lvm/LVM}.${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
SRC_URI="ftp://ftp.sistina.com/pub/LVM2/tools/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~sparc ppc"

DEPEND=">=sys-libs/device-mapper-1.00.07"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

src_compile() {
	econf || die

	# Parallel build doesn't work.
	emake -j1 || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" || die
	dodoc BUGS COPYING* INSTALL INTRO README TODO VERSION doc/*
}
