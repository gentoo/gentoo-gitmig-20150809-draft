# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gputils/gputils-0.12.0.ebuild,v 1.3 2004/03/23 18:33:03 dragonheart Exp $

DESCRIPTION="Collection of tools including assembler, linker and librarian for PIC microcontrollers"
SRC_URI="mirror://sourceforge/gputils/${P}.tar.gz"
HOMEPAGE="http://gputils.sourceforge.net/"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
DEPEND="virtual/glibc
	sys-devel/gcc
	sys-devel/flex
	sys-devel/bison"

RDEPEND="virtual/glibc"


src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc doc/gputils.ps doc/gputils.lyx doc/gputils.pdf
}
