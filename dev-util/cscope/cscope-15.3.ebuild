# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.3.ebuild,v 1.28 2004/07/14 22:54:57 agriffis Exp $

inherit gnuconfig

DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"
HOMEPAGE="http://cscope.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa mips amd64 ia64"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/bison
	sys-devel/flex"

src_compile() {
	gnuconfig_update

	sed -i -e "s:={:{:" src/egrep.y

	econf || die
	make clean || die
	emake || die
}

src_install() {
	einstall || die

	dodoc NEWS AUTHORS TODO COPYING Changelog INSTALL README*
}
