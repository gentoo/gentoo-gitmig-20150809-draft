# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-1.4.0.1.ebuild,v 1.1 2001/04/15 21:45:13 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-applets"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/gnome-core-1.4
	>=gnome-base/libgtop-1.0.12
	>=gnome-base/libghttp-1.0.9
        >=gnome-base/scrollkeeper-0.2"

src_compile() {

  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome \
        --infodir=/opt/gnome/share/info ${myconf}
  try make

}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome infodir=${D}/opt/gnome/share/info install
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}





