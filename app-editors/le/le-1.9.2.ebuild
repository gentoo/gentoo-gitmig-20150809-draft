# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/le/le-1.9.2.ebuild,v 1.1 2003/06/08 20:22:41 naz Exp $

DESCRIPTION="LE is a Terminal text editor, capable of many block operations, has \
			hex mode, syntax highlighting, etc."
HOMEPAGE="http://www.gnu.org/directory/text/editors/le-editor.html"
SRC_URI="http://ftp.yars.free.net/pub/software/unix/util/texteditors/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
        ncurses? ( >=sys-libs/ncurses-5.2-r5 )"

src_install () {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog FEATURES HISTORY INSTALL NEWS \
		README TODO
}
