# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

P=GConf-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gconf"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/GConf/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/GConf/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/oaf-0.6.4
	>=x11-libs/gtk+-1.2.9
        >=dev-util/guile-1.4"

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

  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS README* TODO

}





