# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/comparator/comparator-2.2.ebuild,v 1.6 2009/06/09 19:16:38 ssuominen Exp $

DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	 http://www.catb.org/~esr/comparator/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 mips sparc x86"
IUSE=""

RDEPEND=""
DEPEND=""

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin comparator filterator || die
	doman comparator.1
}
