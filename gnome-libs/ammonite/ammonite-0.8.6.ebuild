# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-libs/ammonite/ammonite-0.8.6.ebuild,v 1.1 2001/03/06 06:05:34 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ammonite"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/gnome-libs-1.2.12
        >=gnome-base/gconf-0.50
        >=dev-libs/openssl-0.9.6"

src_compile() {
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome  --sysconfdir=/etc/opt/gnome ${myconf}
  try make
}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
  dodoc ABOUT-NLS AUTHORS COPYING* HACKING README NEWS
  dodoc TODO doc/*.txt

}




