# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/gnome-pim/gnome-pim-1.4.0.ebuild,v 1.2 2001/06/05 19:43:20 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-pim"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-pim/"${A}
HOMEPGAE="http://www.gnome.org/gnome-office/gnome-pim.shtml"

DEPEND=">=gnome-base/gnome-core-1.4.0 nls? ( sys-devel/gettext )"
RDEPEND=">=gnome-base/gnome-libs-1.2.13"

src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome $myconf
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}



