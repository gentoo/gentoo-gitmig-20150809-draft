# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/le/le-1.9.2.ebuild,v 1.5 2004/05/31 22:12:03 vapier Exp $

DESCRIPTION="Terminal text editor"
HOMEPAGE="http://www.gnu.org/directory/text/editors/le-editor.html"
SRC_URI="http://ftp.yars.free.net/pub/software/unix/util/texteditors/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog FEATURES HISTORY INSTALL NEWS README TODO
}
