# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gdm/gdm-2.0beta4.ebuild,v 1.1 2000/08/15 15:27:04 achim Exp $

P=gdm-2.0beta4
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="gnome-apps"
DESCRIPTION="gdm"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gdm/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING ChangeLog NEWS README* RELEASENOTES TODO
}



