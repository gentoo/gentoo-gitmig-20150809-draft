# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnome-audio/gnome-audio-1.0.0.ebuild,v 1.2 2000/08/16 04:38:00 drobbins Exp $

P=gnome-audio-1.0.0
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-audio"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-audion/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  dodoc README
}



