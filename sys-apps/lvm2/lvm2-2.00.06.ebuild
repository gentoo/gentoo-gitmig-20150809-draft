# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lvm2/lvm2-2.00.06.ebuild,v 1.1 2003/09/03 14:04:56 max Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://www.sistina.com/products_lvm.htm"
SRC_URI="ftp://ftp.sistina.com/pub/LVM2/tools/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-libs/device-mapper-1"
RDEPEND="${DEPEND}
	!sys-apps/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_compile() {
	econf
	
	# Parallel build doesn't work.
	make || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin"
	dodoc BUGS COPYING* INSTALL INTRO README TODO VERSION doc/*
}
