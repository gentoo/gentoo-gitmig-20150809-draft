# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.12_p2.ebuild,v 1.1 2000/09/14 01:14:41 achim Exp $

A=gtk-xemacs-09112000.tar.bz2
S=${WORKDIR}/gtk-xemacs
DESCRIPTION="XEmacs 21.1.12 GTK"
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
  prepinfo /usr/X11R6/lib/xemacs-21.1.12
  prepman /usr/X11R6
  dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}







