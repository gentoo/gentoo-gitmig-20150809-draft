# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-0.3.ebuild,v 1.2 2000/08/16 04:38:04 drobbins Exp $

P=eog-0.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Eye of GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/eog/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/eog.shtml"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets --without-bonobo
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING DEPENDS ChangeLog HACKING NEWS README TODO MAINTAINERS

}





