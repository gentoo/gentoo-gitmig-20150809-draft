# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm2/lvm2-2.00.08.ebuild,v 1.12 2004/11/14 16:33:32 max Exp $

DESCRIPTION="User-land utilities for LVM2 (device-mapper) software."
HOMEPAGE="http://sources.redhat.com/lvm2/"
SRC_URI="ftp://sources.redhat.com/pub/lvm2/old/${PN/lvm/LVM}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND=">=sys-libs/device-mapper-1.00.07"
RDEPEND="${DEPEND}
	!sys-fs/lvm-user"

S="${WORKDIR}/${PN/lvm/LVM}.${PV}"

src_compile() {
	econf || die "econf failed"

	# Parallel build doesn't work.
	emake -j1 || die "compile problem"
}

src_install() {
	einstall sbindir="${D}/sbin"
	dodoc BUGS COPYING* INSTALL INTRO README TODO VERSION doc/*
}
