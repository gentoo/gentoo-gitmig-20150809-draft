# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-0.6.2.ebuild,v 1.3 2001/06/04 21:57:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="glade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/glade/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=x11-libs/gtk+-1.2.8
        bonobo? ( >=gnome-base/bonobo-1.0.4 )
	gnome? ( >=gnome-base/gnome-libs-1.2.8
        	 >=gnome-base/scrollkeeper-0.2 )"
 #gnome-db stuff disabled atm
 #>=gnome-office/gnome-db-0.2.0

src_compile() {

  local myopts
  if [ -n "`use gnome`" ]
  then
    echo "Using Gnome"
    myopts="--prefix=/opt/gnome"

  else
    myopts="--prefix=/usr/X11R6 --disable-gnome"
  fi
  if [ "`use bonobo`" ] ; then
    myopts="$myopts --with-bonobo"
  else
    myopts="$myopts --without-bonobo"
  fi
  try ./configure --host=${CHOST} ${myopts}
  # bonobo support does not work with 0.28 requires around 0.18
  try make
}

src_install() {

  local myopts
  if [ -n "`use gnome`" ]
  then
    try make prefix=${D}/opt/gnome install
  else
    try make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS COPYING* FAQ NEWS
  dodoc README* TODO
}





