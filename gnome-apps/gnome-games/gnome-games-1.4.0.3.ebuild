# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Reviewed by Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnome-games/gnome-games-1.4.0.3.ebuild,v 1.4 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-utils"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-core-1.4.0.4
        >=dev-util/guile-1.4
        >=gnome-base/scrollkeeper-0.2
	>=media-libs/gdk-pixbuf-0.9
        nls? ( sys-devel/gettext )"

RDEPEND=">=gnome-base/gnome-core-1.4.0.4 >=dev-util/guile-1.4"

src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome \
        --with-ncurses $myconf
  try pmake
}

src_install() {

  dodir /opt/gnome/bin
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
}




