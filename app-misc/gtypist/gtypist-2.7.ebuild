# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtypist/gtypist-2.7.ebuild,v 1.7 2004/12/06 13:52:44 josejx Exp $

DESCRIPTION="universal typing tutor"
HOMEPAGE="http://www.gnu.org/software/gtypist/gtypist.html"
SRC_URI="mirror://gnu/gtypist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
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
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO THANKS
}
