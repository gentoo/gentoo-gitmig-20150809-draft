# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sysutils/sysutils-0.1.0.ebuild,v 1.7 2005/06/02 16:45:48 dang Exp $

DESCRIPTION="A small program and library to access the sysfs interface in 2.5+ kernels."
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.gz"
HOMEPAGE="http://www.kernel.org"

KEYWORDS="~amd64 ppc s390 ~x86"
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
