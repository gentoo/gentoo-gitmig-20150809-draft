# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/nautilus/nautilus-0.5.ebuild,v 1.1 2000/11/25 13:03:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="nautlilus"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=media-libs/freetype-2.0
	=gnome-libs/bonobo-0.26
	>=gnome-base/libghttp-1.0.7
	>=gnome-apps/medusa-0.2.2"

src_compile() {                           
  cd ${S}
  MOZILLA=${S}/../../../mozilla-milestone-18/work/mozilla/dist
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--enable-eazel-services=1
#    --with-mozilla-lib-place=$MOZILLA/lib \
#    --with-mozilla-include-place=$MOZILLA/include
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog* NEWS TODO
}





