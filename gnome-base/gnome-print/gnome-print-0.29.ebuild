# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.28.ebuild,v 1.2 2001/04/19 16:37:12 achim Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.29.ebuild,v 1.5 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-print"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext ) 
        sys-devel/perl
	>=media-libs/gdk-pixbuf-0.9.0
	>=gnome-base/libglade-0.13
        >=app-text/ghostscript-6.50-r2"

RDEPEND=">=media-libs/gdk-pixbuf-0.9.0
	 >=gnome-base/libglade-0.13"


src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
  try pmake
}

src_install() {
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
  dosed /opt/gnome/share/fonts/fontmap
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}





