# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/keyutils/keyutils-1.1.ebuild,v 1.1 2006/05/12 01:08:09 robbat2 Exp $

DESCRIPTION="Linux Key Management Utilities"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="http://people.redhat.com/~dhowells/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=sys-kernel/linux-headers-2.6.11"
#RDEPEND=""

src_compile() {
	emake CFLAGS="-Wall ${CFLAGS}" NO_ARLIB=0
}

src_install() {
	emake install DESTDIR="${D}" NO_ARLIB=0
	dodoc README
}
