# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.12_p3.ebuild,v 1.3 2000/10/29 20:36:58 achim Exp

#A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="XEmacs"

EFS=1.22
BASE=1.53

DEPEND=">=x11-base/xfree-4.0.3-r3"

SRC_URI="ftp://ftp.xemacs.org/pub/current/${P}.tar.bz2
	 ftp://ftp.xemacs.org/xemacs/packages/efs-${EFS}-pkg.tar.gz
	 ftp://ftp.xemacs.org/xemacs/packages/xemacs-base-${BASE}-pkg.tar.gz"
	 
HOMEPAGE="http://www.xemacs.org"

src_unpack() {
    cd ${WORKDIR}
    unpack ${P}.tar.bz2			# Extract the original package
}

src_compile() {                           
  try ./configure --prefix=/usr/X11R6 
  try make
}

src_install() {                               
  try make prefix=${D}/usr/X11R6 install
  # Install the two packages
  dodir /usr/X11R6/lib/xemacs/xemacs-packages/
  cd ${D}/usr/X11R6/lib/xemacs/xemacs-packages/
  unpack efs-${EFS}-pkg.tar.gz
  unpack xemacs-base-${BASE}-pkg.tar.gz
  cd ${S}
  prepinfo /usr/X11R6/lib/xemacs-21.1.14
  prepman /usr/X11R6
  dodoc BUGS CHANGES-beta COPYING GETTING* INSTALL ISSUES PROBLEMS README*
}







