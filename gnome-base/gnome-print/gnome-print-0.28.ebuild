# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.28.ebuild,v 1.1 2001/04/13 16:59:03 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/libxml-1.8.10
	>=gnome-base/gdk-pixbuf-0.9.0"

src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
  try make
}

src_install() {
  cd ${S}
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
  dosed /opt/gnome/share/fonts/fontmap
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}





