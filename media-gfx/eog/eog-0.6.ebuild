# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-0.6.ebuild,v 1.4 2001/06/11 08:11:28 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Eye of GNOME"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/eog/"${A}
HOMEPAGE="http://www.gnome.org/gnome-office/eog.shtml"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )
        >=gnome-base/bonobo-1.0.4
        >=gnome-base/gconf-1.0.1
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND="virtual/glibc
        >=gnome-base/gconf-1.0.1
        >=gnome-base/bonobo-1.0.4"

src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome $myconf
  try pmake
}

src_install() {
  try make prefix=${D}/opt/gnome sysconfdir=/etc/opt/gnome \
	GCONG_CONFIG_SOURCE=xml=${D}/etc/opt/gnome/gconf/gconf.xml.defaults install
  dodoc AUTHORS COPYING DEPENDS ChangeLog HACKING NEWS README TODO MAINTAINERS

}







