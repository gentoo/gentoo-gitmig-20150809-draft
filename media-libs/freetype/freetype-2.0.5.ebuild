# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/freetype/freetype-2.0.5.ebuild,v 1.1 2001/10/27 18:39:16 lordjoe Exp $


S=${WORKDIR}/${P}
DESCRIPTION="TTF-Library"
SRC_URI="http://prdownloads.sourceforge.net/freetype/${P}.tar.bz2"
HOMEPAGE="http://www.freetype.org/"

DEPEND="virtual/glibc"

src_compile() {

  make CFG="--host=${CHOST} --prefix=/usr" || die
  emake || die

}

src_install() {

  make prefix=${D}/usr install || die

  dodoc ChangeLog README 
  dodoc docs/{BUILD,CHANGES,*.txt,PATENTS,readme.vms,todo}

}
