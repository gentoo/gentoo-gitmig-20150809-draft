# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.07.ebuild,v 1.3 2003/12/27 03:47:28 seemant Exp $

MY_P=${PN/lvm/LVM}.${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
SRC_URI="ftp://ftp.sistina.com/pub/LVM2/tools/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/device-mapper-1"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

src_compile() {
	econf || die

	# parallel build doesn't work
	emake -j1 || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin" || die
	dodoc BUGS COPYING* INSTALL INTRO README TODO VERSION doc/*
}
