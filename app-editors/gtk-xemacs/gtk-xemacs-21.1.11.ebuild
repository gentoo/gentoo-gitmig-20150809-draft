# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.11.ebuild,v 1.1 2000/08/28 17:23:20 achim Exp $

P=gtk-xemacs-21.1.11
A=gtk-xemacs-latest.tar.bz2
S=${WORKDIR}/gtk-xemacs
DESCRIPTION="XEmacs 21.1 GTK"
SRC_URI="http://www.cs.indiana.edu/elisp/gui-xemacs/dist/${A}"
HOMEPAGE="http://www.cs.indiana.edu/elisp/gui-xemacs/"

src_compile() {                           
  cd ${S}
  ./configure --prefix=/usr/X11R6
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 install
  prepinfo /usr/X11R6/lib/xemacs-21.1.11
  prepman /usr/X11R6
  dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}





