# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmikmod/libmikmod-3.1.9-r1.ebuild,v 1.5 2000/11/01 04:44:17 achim Exp $

P=libmikmod-3.1.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The boldest sound on the planet"
SRC_URI="http://mikmod.darkorb.net/libmikmod/"${A}

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=media-libs/alsa-lib-0.5.9
	>=media-sound/esound-0.2.19"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr \
	--enable-alsa --enable-esd --enable-oss
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  prepman
  prepinfo
  dodoc AUTHORS COPYING* NEWS PROBLEMS README TODO *.lsm
  docinto html
  dodoc docs/*.html
}




