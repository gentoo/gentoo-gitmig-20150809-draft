# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.11.0.ebuild,v 1.3 2001/07/29 11:22:36 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/"${A}

DEPEND=">=x11-libs/gtk+-1.2.0
        gnome? ( >=gnome-base/gnome-libs-1.2.13 )"

src_compile() {
  local myprefix
  local mysysconfdir

  if [ "`use gnome`" ] ; then
    myprefix=/opt/gnome
    mysysconfdir=/etc/opt/gnome
  else
    myprefix=/usr/X11R6
    mysysconfdir=/etc/X11/gdk-pixbuf
  fi
 
  try ./configure --host=${CHOST} --prefix=${myprefix} --sysconfdir=${mysysconfdir}
  try pmake
}

src_install() {

  try make prefix=${D}${myprefix} sysconfdir=${D}${mysysconfdir} install
  dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}
