# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/xscreensaver/xscreensaver-3.32-r2.ebuild,v 1.1 2001/10/06 12:36:36 azarah Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a modular screensaver for X11"
SRC_URI="http://www.jwz.org/xscreensaver/${A}"
HOMEPAGE="http://www.jwz.org/xscreensaver/"

DEPEND="virtual/x11 sys-devel/bc
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	opengl? ( virtual/opengl >=media-libs/gle-3.0.1 )
	gnome? ( >=gnome-base/control-center-1.4.0.1-r1 )
        pam? ( >=sys-libs/pam-0.75 )
        kde? ( kde-base/kde-env )"

RDEPEND="virtual/x11
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	motif? ( >=x11-libs/openmotif-2.1.30 )
	opengl? ( virtual/opengl >=media-libs/gle-3.0.1 )
	gnome? ( >=gnome-base/control-center-1.4.0.1-r1 )
        pam? ( >=sys-libs/pam-0.75 )
        kde? ( kde-base/kde-env )"

src_compile() {
    local myconf
    if [ "`use gnome`" ]
    then
      myconf="--with-gnome"
    else
      myconf="--without-gnome"
    fi
    if [ "`use gtk`" ]
    then
      myconf="$myconf --with-gtk"
    else
      myconf="$myconf --without-gtk"
    fi
    if [ "`use motif`" ]
    then
      myconf="$myconf --with-motif"
    else
      myconf="$myconf --without-motif"
    fi
    if [ "`use pam`" ]
    then
      myconf="$myconf --with-pam"
    else
      myconf="$myconf --without-pam"
    fi
    if [ "`use opengl`" ]
    then
      myconf="$myconf --with-gl --with-gle"
    else
      myconf="$myconf --without-gl --without-gle"
    fi
    

   try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	    --enable-subdir=/usr/lib/xscreensaver $myconf \
	    --with-mit-ext --with-dpms-ext --with-xf86vmode-ext \
	    --with-proc-interrupts --with-xpm --with-xshm-ext \
	    --with-xdbe-ext --enable-locking
  try make

}

src_install () {
    if [ "$KDEDIR" ]
    then
      dodir $KDEDIR/bin
    fi
    try make install_prefix=${D} install
    if [ "`use gnome`" ]
    then
      dodir /usr/bin
# not need i think, shout if it breaks control-center support
#      mv ${D}/usr/bin/screensaver-properties-capplet ${D}/usr/bin
   fi
}

