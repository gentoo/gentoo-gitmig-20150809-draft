# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matthew Kennedy <mkennedy@gentoo.org>
# Author: Matthew Kennedy <mbkennedy@ieee.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S=${WORKDIR}/${P}
DESCRIPTION="GNU Typist (also called gtypist) is a universal typing tutor."
SRC_URI="ftp://ftp.gnu.org/gnu/gtypist/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gtypist/gtypist.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {
	local myconf

	# gtypist uses a built in gettext
	use nls && myconf="--enable-nls" || \
		myconf="--disable-nls"

	# gtypist also produces some Emacs/XEmacs editing modes if
	# emacs/xemacs is present. if emacs/xemacs is not present then
	# these emacs modes are not compiled or installed.

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO THANKS
}
