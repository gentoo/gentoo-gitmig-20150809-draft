# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtypist/gtypist-2.5.ebuild,v 1.4 2002/07/25 17:20:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Typist (also called gtypist) is a universal typing tutor."
SRC_URI="ftp://ftp.gnu.org/gnu/gtypist/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gtypist/gtypist.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	local myconf

	# gtypist uses a built in gettext
	use nls && myconf="--enable-nls" || \
		myconf="--disable-nls"

	# gtypist also produces some Emacs/XEmacs editing modes if
	# emacs/xemacs is present. if emacs/xemacs is not present then
	# these emacs modes are not compiled or installed.

	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO THANKS
}
