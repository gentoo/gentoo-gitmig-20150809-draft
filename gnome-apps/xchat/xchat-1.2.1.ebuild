# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/xchat/xchat-1.2.1.ebuild,v 1.2 2000/08/16 04:38:01 drobbins Exp $

P=xchat-1.2.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="xchat"
SRC_URI="http://www.xchat.org/files/source/1.4/"${A}
HOMEPAGE="http://www.xchat.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING ChangeLog NEWS README

}






