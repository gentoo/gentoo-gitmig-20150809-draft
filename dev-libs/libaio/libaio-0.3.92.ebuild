# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.92.ebuild,v 1.5 2004/06/12 00:30:20 port001 Exp $

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/bcrl/aio/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/bcrl/aio/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="nls"

DEPEND=""

src_compile() {
	make || die
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die
}
