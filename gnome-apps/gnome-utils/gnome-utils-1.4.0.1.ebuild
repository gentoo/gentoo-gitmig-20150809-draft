# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnome-utils/gnome-utils-1.4.0.1.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-core-1.2.4
	>=gnome-base/libgtop-1.0.0
        >=sys-apps/e2fsprogs-1.19-r2
        >=dev-util/guile-1.4
        >=sys-apps/shadow-20000000
	>=gnome-base/libglade-0.11
        nls? ( sys-devel/gettext )"
RDEPEND=">=gnome-base/gnome-core-1.2.4
	>=gnome-base/libgtop-1.0.10
	>=gnome-base/libglade-0.11
        >=sys-apps/e2fsprogs-1.19-r2"

src_compile() {                           
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-ncurses --with-messages=/var/log/syslog.d/current \
	--with-sysconfdir=/etc/opt/gnome $myconf
  try pmake
}

src_install() {

  #dodir /opt/gnome/bin
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}




