# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysutils/sysutils-0.1.0.ebuild,v 1.6 2004/09/03 21:03:24 pvdabeel Exp $

DESCRIPTION="A small program and library to access the sysfs interface in 2.5+ kernels."
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.gz"
HOMEPAGE="http://www.kernel.org"

KEYWORDS="~x86 s390 ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"

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
