# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.2.1.ebuild,v 1.3 2001/04/30 19:19:31 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GIMP"
SRC_URI="ftp://ftp.insync.net/pub/mirrors/ftp.gimp.org/gimp/v1.2/v${PV}/"${A}
HOMEPAGE="http://www.gimp.org"

DEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/slang-1.4.2
	>=gnome-base/gnome-libs-1.2.4
	>=media-libs/mpeg-lib-1.3.1
	aalib? ( >=media-libs/aalib-1.2 )
	>=dev-perl/PDL-2.2
	>=dev-perl/Parse-RecDescent-1.80"

RDEPEND=">=sys-libs/slang-1.4.2
	 >=gnome-base/gnome-libs-1.2.4
	 aalib? ( >=media-libs/aalib-1.2i )"


src_compile() {                           
  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc ${myconf}
  try make 
}

src_install() {                               

  dodir /usr/X11R6/lib/gimp/1.2/plug-ins
  try make prefix=${D}/usr/X11R6 gimpsysconfdir=${D}/etc/gimp/1.2 \
	mandir=${D}/usr/X11R6/share/man PREFIX=${D}/usr install
  preplib /usr/X11R6
  dodoc AUTHORS COPYING ChangeLog* *MAINTAINERS README* TODO
  dodoc docs/*.txt docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
  docinto html/libgimp
  dodoc devel-docs/libgimp/html/*.html
  docinto devel
  dodoc devel-docs/*.txt
}





