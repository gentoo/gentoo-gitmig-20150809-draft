# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/gnome-apps/gedit/gedit-0.9.4.ebuild,v 1.4 2000/11/27 16:20:46 achim Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://gftp.seul.org/${A}"
HOMEPAGE="http://gftp.seul.org"

DEPEND=">=x11-libs/gtk+-1.2.10
        nls? ( sys-devel/gettext )"


src_compile() {
  local myconf
  if [ -z "`use nls`" ] ; then
     myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 \
        --mandir=/usr/X11R6/man ${myconf}
  try make
}

src_install() {

  try make prefix=${D}/usr/X11R6 mandir=${D}/usr/X11R6/man install

  dodoc COPYING ChangeLog README* THANKS TODO
  dodoc docs/USERS-GUIDE

}





