# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.12_p3.ebuild,v 1.7 2002/08/01 12:51:21 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="XEmacs 21.1.12 GTK"
SRC_URI="http://www.cs.indiana.edu/elisp/gui-xemacs/dist/${PN}-09252000.tar.bz2"
HOMEPAGE="http://www.cs.indiana.edu/elisp/gui-xemacs/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*"

src_compile() {													 
	./configure --prefix=/usr/X11R6 || die
	make || die
}

src_install() {															 
	make prefix=${D}/usr/X11R6 install || die
	prepinfo /usr/X11R6/lib/xemacs-21.1.12
	prepman /usr/X11R6
	dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}
