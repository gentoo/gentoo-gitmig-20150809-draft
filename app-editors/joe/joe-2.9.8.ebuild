# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-2.9.8.ebuild,v 1.4 2003/11/29 01:19:01 joker Exp $

IUSE=""

inherit flag-o-matic

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
SRC_URI="mirror://sourceforge/joe-editor/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"

SLOT="0"
KEYWORDS="x86 ~ppc sparc"
LICENSE="GPL-1"

DEPEND=">=sys-libs/ncurses-5.2-r2"

PROVIDE="virtual/editor"

# Bug 34609 (joe 2.9.8 editor seg-faults on 'find and replace' when compiled with -Os)
replace-flags "-Os" "-O2"

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc COPYING INFO LIST README TODO VERSION
}
