# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-382-r2.ebuild,v 1.7 2004/09/03 21:03:24 pvdabeel Exp $

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/"
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha ~arm ~hppa ~amd64 ia64 ~ppc64 ~s390"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2"

src_install() {
	dobin less lessecho lesskey || die
	newbin ${FILESDIR}/lesspipe.sh-r2 lesspipe.sh

	# Needed for groff-1.18 and later ...
	dodir /etc/env.d
	echo "LESS=\"-R\"" > ${D}/etc/env.d/70less

	newman lesskey.nro lesskey.1
	newman less.nro less.1

	dodoc NEWS README
}
