# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.12_p3.ebuild,v 1.6 2002/08/01 11:58:57 seemant Exp $

S=${WORKDIR}/gtk-xemacs
DESCRIPTION="XEmacs 21.1.12 GTK"
SRC_URI="http://www.cs.indiana.edu/elisp/gui-xemacs/dist/${PN}-09252000.tar.bz2"
HOMEPAGE="http://www.cs.indiana.edu/elisp/gui-xemacs/"

src_compile() {                           
  cd ${S}
  try ./configure --prefix=/usr/X11R6 
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 install
  prepinfo /usr/X11R6/lib/xemacs-21.1.12
  prepman /usr/X11R6
  dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}







