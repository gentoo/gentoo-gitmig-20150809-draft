# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.5-r1.ebuild,v 1.2 2001/10/06 14:36:55 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X MultiMedia System"
SRC_URI="ftp://ftp.xmms.org/xmms/1.2.x/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org/"

DEPEND="gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 )
	>=dev-libs/libxml-1.8.15
	>=media-libs/libmikmod-3.1.9
    >=media-sound/esound-0.2.22
	vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	>=x11-libs/gtk+-1.2.10-r4
	virtual/opengl"

RDEPEND="gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 )
	 >=dev-libs/libxml-1.8.15
  	 >=media-libs/libmikmod-3.1.9
	 >=media-sound/esound-0.2.22
	 vorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	 >=x11-libs/gtk+-1.2.10-r4
	 virtual/opengl"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp configure configure.orig
  sed -e "s:-m486::" configure.orig > configure
}
src_compile() {

  local myopts
  if [ -n "`use gnome`" ]
  then
	myopts="--with-gnome"
        export CFLAGS="$CFLAGS -I/opt/gnome/include"
  else
	myopts="--without-gnome"
  fi
  if [ "`use 3dnow`" ] ; then
    myopts="$myopts --enable-3dnow"
  else
    myopts="$myopts --disable-3dnow"
  fi
  if [ "`use ogg`" ] ; then
    myopts="$myopts --with-ogg"
  else
    myopts="$myopts --disable-ogg-test"
  fi
if [ "`use vorbis`" ] ; then
    myopts="$myopts --with-vorbis"
  else
    myopts="$myopts --disable-vorbis-test"
  fi


  try ./configure --host=${CHOST} --prefix=/usr ${myopts}
  try make

}

src_install() {                               
  cd ${S}
  if [ -n "`use gnome`" ]
  then
    try make prefix=${D}/usr \
	gnorbadir=${D}/etc/gnome/CORBA/servers \
	sysdir=${D}/usr/share/applets/Multimedia \
	install
  else
    try make prefix=${D}/usr/X11R6 install
  fi
  dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO 
  insinto /usr/share/pixmaps/
  donewins gnomexmms/gnomexmms.xpm xmms.xpm
}
