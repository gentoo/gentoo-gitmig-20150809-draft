# Copyrigth 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# Maintainer: Desktop Team
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xalf/xalf-0.12.ebuild,v 1.1 2001/08/22 10:40:33 hallski Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="X11 Application Launch Feedback"
SRC_URI="http://www.lysator.liu.se/~astrand/projects/xalf/${A}"
HOMEPAGE="http://www.lysator.liu.se/~astrand/projects/xalf/"

DEPEND=">=x11-libs/gtk+-1.2.0
	gnome? ( >=gnome-base/gnome-core-1.2.2.1
	         gnome-base/control-center )"

src_compile() {

  local myconf

  if [ "`use gnome`" ]
  then
	myconf="--prefix=/opt/gnome --enable-capplet"
  else
	myconf="--prefix=/usr/X11R6 --disable-capplet"
  fi

  ./configure --host=${CHOST} ${myconf} || die "Failed to configure package."

  emake || die "Failed to build package."
}

src_install() {

  if [ -n "`use gnome`" ] ; then
  	make prefix=${D}/opt/gnome install || die
  else
  	make prefix=${D}/usr/X11R6 install || die
  fi

  dodoc AUTHORS COPYING ChangeLog README
}
