# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.1.29.ebuild,v 1.1 2000/11/05 09:25:48 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GIMP"
SRC_URI="ftp://ftp.insync.net/pub/mirrors/ftp.gimp.org/gimp/v1.1/v${PV}/"${A}
HOMEPAGE="http://www.gimp.org"

DEPEND=">=sys-libs/slang-1.4.2
	>=gnome-base/gnome-libs-1.2.4
	>=media-libs/mpeg-lib-1.3.1
	>=media-libs/aalib-1.2
	|| ( net-print/LPRng net-print/cups )"
RDEPEND=">=sys-libs/slang-1.4.2
	 >=gnome-base/gnome-libs-1.2.4
	 >=media-libs/aalib-1.2"

src_unpack() {

  unpack ${A}
  cd ${S}
#  cp configure configure.orig
#  sed -e "s#--writemakefile \$perl_prefix#--writemakefile \$perl_prefix $PERLINSTALL#" configure.orig > configure
   
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc
  try make 
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc PREFIX=${D}/usr install
  preplib /usr/X11R6
  dodoc AUTHORS COPYING ChangeLog* *MAINTAINERS README* TODO
  dodoc docs/*.txt docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
  docinto html/libgimp
  dodoc devel-docs/libgimp/html/*.html
  docinto devel
  dodoc devel-docs/*.txt
}





