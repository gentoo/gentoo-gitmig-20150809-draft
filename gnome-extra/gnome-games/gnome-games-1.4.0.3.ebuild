# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Reviewed by Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-apps/gnome-utils/gnome-utils-1.2.1-r1.ebuild,v 1.2 2000/11/25 18:30:59 achim Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-1.4.0.3.ebuild,v 1.3 2001/08/30 17:31:35 pm Exp $


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




