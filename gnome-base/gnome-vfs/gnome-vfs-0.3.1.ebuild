# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-0.3.1.ebuild,v 1.2 2000/10/23 11:27:13 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-vfs"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

src_unpack() {
  unpack ${A}
#  cp ${FILESDIR}/efs-method.c ${S}/modules
   cp ${FILESDIR}/configure ${S}
}
src_compile() {                           
  cd ${S}
  try CFLAGS="\"$CFLAGS -I/opt/gnome/include/gconf/1\"" ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets --disable-libefs
  try make
}

src_install() {
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}



