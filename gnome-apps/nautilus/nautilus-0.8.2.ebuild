# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/nautilus/nautilus-0.8.2.ebuild,v 1.1 2001/03/06 06:05:34 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="nautlilus"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=media-libs/freetype-2.0
        >=sys-libs/pam-0.73
	>=gnome-base/bonobo-0.37
	>=gnome-base/libghttp-1.0.9
        >=gnome-base/scrollkeeper-0.1.2
	>=gnome-libs/medusa-0.3.2
        >=gnome-libs/ammonite-0.8.6"

src_compile() {                           
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
        --sysconfdir=/etc/opt/gnome --infodir=/opt/gnome/share/info \
	--mandir=/opt/gnome/share/man --enable-eazel-services=1 ${myconf}
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
        mandir=${D}/opt/gnome/share/man infodir=${D}/opt/gnome/share/info install
  dodoc AUTHORS COPYING* ChangeLog* NEWS TODO
}





