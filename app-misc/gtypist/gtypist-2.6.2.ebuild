# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtypist/gtypist-2.6.2.ebuild,v 1.5 2003/06/29 23:17:15 aliz Exp $

DESCRIPTION="universal typing tutor"
SRC_URI="mirror://gnu/gtypist/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gtypist/gtypist.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	# gtypist also produces some Emacs/XEmacs editing modes if
	# emacs/xemacs is present. if emacs/xemacs is not present then
	# these emacs modes are not compiled or installed.
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO THANKS
}
