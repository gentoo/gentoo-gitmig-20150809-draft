# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.08.ebuild,v 1.8 2004/03/10 04:32:22 max Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/${PN/lvm/LVM}.${PV}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 sparc ppc"

DEPEND=">=sys-libs/device-mapper-1.00.07"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_compile() {
	econf

	# Parallel build doesn't work.
	emake -j1 || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin"
	dodoc BUGS COPYING* INSTALL INTRO README TODO VERSION doc/*
}
