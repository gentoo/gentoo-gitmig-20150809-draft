# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/scrollkeeper/scrollkeeper-0.2.ebuild,v 1.5 2001/08/23 10:16:32 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Scrollkeeper"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/libxml-1.8.11 >=sys-libs/zlib-1.1.3"
RDEPEND=">=gnome-base/libxml-1.8.11 >=sys-libs/zlib-1.1.3"

src_compile() {
  local  myconf
  if [ -z "`use nls`" ] ; then
    myconf ="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome \
  --mandir=/opt/gnome/man --localstatedir=/var $myconf
  try pmake
}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome \
	localstatedir=${D}/var mandir=${D}/opt/gnome/man install

  dodoc AUTHORS COPYING* ChangeLog README NEWS

}





