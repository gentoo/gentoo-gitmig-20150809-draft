# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/calc/calc-2.11.9.3.ebuild,v 1.2 2004/03/13 23:47:19 dholm Exp $

DESCRIPTION="An arbitrary precision C-like arithmetic system"
HOMEPAGE="http://www.isthe.com/chongo/tech/comp/calc/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.2"

RDEPEND=">=sys-apps/less-348"

src_compile() {
	make \
		T=${D} \
		DEBUG="${CFLAGS}" \
		CALCPAGER=less \
		USE_READLINE="-DUSE_READLINE" \
		READLINE_LIB="-lreadline -lhistory -lncurses" \
		all chk \
	|| die
}

src_install() {
	make T=${D} install || die
	dodoc BUGS CHANGES COPYING COPYING-LGPL LIBRARY README
}
