# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/glade/glade-0.5.9.ebuild,v 1.5 2000/11/03 17:47:44 achim Exp $

P=glade-0.5.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="glade"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/glade/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=x11-libs/gtk+-1.2.8
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

src_compile() {                           
  cd ${S}
  local myopts
  if [ -n "`use gnome`" ]
  then
    echo "Using Gnome"
    myopts="--prefix=/opt/gnome --disable-gnome-db"
  else
    myopts="--prefix=/usr/X11R6 --disable-gnome"
  fi
  try ./configure --host=${CHOST} --with-catgets ${myopts}
  # bonobo support does not work yet
  try make
}

src_install() {                               
  cd ${S}
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



