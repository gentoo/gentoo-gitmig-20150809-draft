# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# Updated by Sebastian Werner <sebastian@werner-productions.de>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gal/gal-0.9.1.ebuild,v 1.3 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Application Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=dev-util/xml-i18n-tools-0.8.4 sys-devel/perl
        >=gnome-base/gnome-vfs-1.0.1
	>=gnome-base/libunicode-0.4
        alsa? ( >=media-libs/alsa-lib-0.5.10 )
	>=gnome-base/gnome-print-0.24
	>=gnome-base/libglade-0.13
	>=gnome-base/libxml-1.8.8"

src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then                                                                                       
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome ${myconf}
  try make # Doesn't work with -j 4 (hallski)
}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install

  dodoc AUTHORS COPYING ChangeLog NEWS README

}





