# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.2.1-r1.ebuild,v 1.3 2001/06/21 20:49:11 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GIMP"
SRC_URI="ftp://ftp.insync.net/pub/mirrors/ftp.gimp.org/gimp/v1.2/v${PV}/"${A}
HOMEPAGE="http://www.gimp.org"

DEPEND="nls? ( sys-devel/gettext )
	>=x11-libs/gtk+-1.2.8
	>=media-libs/mpeg-lib-1.3.1
	aalib? ( >=media-libs/aalib-1.2 )
	perl? ( >=dev-perl/PDL-2.2.1
        	>=dev-perl/Parse-RecDescent-1.80 )
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

RDEPEND=">=x11-libs/gtk+-1.2.8
	 aalib? ( >=media-libs/aalib-1.2 )
         perl? ( >=dev-perl/PDL-2.2.1
	         >=dev-perl/Parse-RecDescent-1.80 )
	 gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

src_unpac() {
  unpack ${A}
  cp ${FILESDIR}/psd_save.c $S/plug-ins/common
}
src_compile() {                           
  local myconf
  local mymake
  if [ -z "`use nls`" ] ; then
    myconf="--disable-nls"
  fi

  if [ -z "`use perl`" ] ; then
    myconf="$myconf --disable-perl"
  fi

  if [ -z "`use aalib`" ] ; then
    mymake="LIBAA= AA="
  fi

  if [ -z "`use gnome`" ] ; then
    mymake="$mymake HELPBROWSER="
  fi

  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc --with-mp ${myconf}

  try make $mymake  # Doesn't work with -j 4 (hallski)
}

src_install() {
  local mymake                               
  if [ -z "`use aalib`" ] ; then
    mymake="LIBAA= AA="
  fi

  if [ -z "`use gnome`" ] ; then
    mymake="$mymake HELPBROWSER="
  fi
  dodir /usr/X11R6/lib/gimp/1.2/plug-ins
  try make prefix=${D}/usr/X11R6 gimpsysconfdir=${D}/etc/gimp/1.2 \
	mandir=${D}/usr/X11R6/man PREFIX=${D}/usr $mymake install
  preplib /usr/X11R6
  dodoc AUTHORS COPYING ChangeLog* *MAINTAINERS README* TODO
  dodoc docs/*.txt docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
  docinto html/libgimp
  dodoc devel-docs/libgimp/html/*.html
  docinto devel
  dodoc devel-docs/*.txt
}





