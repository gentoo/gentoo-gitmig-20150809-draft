# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-385.ebuild,v 1.2 2005/08/18 04:02:14 vapier Exp $

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/less/"
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"
PROVIDE="virtual/pager"

src_install() {
	dobin less lessecho lesskey || die
	newbin "${FILESDIR}"/lesspipe.sh lesspipe.sh

	# Needed for groff-1.18 and later ...
	echo "LESS=\"-R\"" > 70less
	doenvd 70less

	for m in *.nro ; do
		newman ${m} ${m/nro/1}
	done

	dodoc NEWS README
}
