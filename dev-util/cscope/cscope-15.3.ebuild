# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cscope/cscope-15.3.ebuild,v 1.24 2003/09/20 06:28:21 seemant Exp $

inherit gnuconfig

S=${WORKDIR}/${P}
DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="mirror://sourceforge/cscope/${P}.tar.gz"
HOMEPAGE="http://cscope.sourceforge.net"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa mips arm amd64 ia64"

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
