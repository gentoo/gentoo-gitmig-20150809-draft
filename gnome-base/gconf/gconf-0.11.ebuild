# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

P=GConf-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gconf"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/GConf/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/oaf-0.6.1
	>=x11-libs/gtk+-1.2"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/bdb.h ${S}/backends/bdb.h
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS BUGS COPYING ChangeLog FAQ NEWS README* THANKS TODO
}





