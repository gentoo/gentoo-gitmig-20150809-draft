# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-2.9.8_pre1.ebuild,v 1.7 2003/06/29 18:24:08 aliz Exp $

IUSE=""

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
SRC_URI="mirror://sourceforge/joe-editor/${MY_P}.tgz"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"

SLOT="0"
KEYWORDS="x86 ppc ~sparc"
LICENSE="GPL-1"

DEPEND=">=sys-libs/ncurses-5.2-r2"

PROVIDE="virtual/editor"

src_compile() {                           
	econf || die
	make || die
}

src_install() {                              
	einstall || die
	dodoc COPYING INFO LIST README TODO VERSION
}
