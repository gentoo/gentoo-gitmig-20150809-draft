# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Reviewed by Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-apps/gedit/gedit-0.9.4.ebuild,v 1.4 2000/11/27 16:20:46 achim Exp
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gedit/gedit-0.9.6.ebuild,v 1.5 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Text Editor"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://gedit.sourceforge.net/"

DEPEND=">=gnome-base/libglade-0.15
	>=gnome-base/gnome-print-0.25
        >=gnome-base/gnome-vfs-1.0
        nls? ( sys-devel/gettext )"

RDEPEND=">=gnome-base/libglade-0.15
	>=gnome-base/gnome-print-0.25
        >=gnome-base/gnome-vfs-1.0"


src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome ${myconf}
  try pmake
}

src_install() {
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS BUGS COPYING ChangeLog FAQ NEWS README* THANKS TODO
}





