# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysutils/sysutils-0.1.0.ebuild,v 1.1 2003/11/23 23:29:42 plasmaroo Exp $

DESCRIPTION="A small program and library to access the sysfs interface in 2.5+ kernels."
SRC_URI="http://www.kernel.org/pub/linux/utils/kernel/hotplug/${P}.tar.gz"
HOMEPAGE="http://www.kernel.org"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {

	emake || die "emake failed"

}

src_install() {

	into /usr
	dolib lib/libsysfs.a
	dosbin cmd/lsbus
	dosbin cmd/systool

	dodoc docs/libsysfs.txt

}
