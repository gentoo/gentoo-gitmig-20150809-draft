# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.9.ebuild,v 1.1 2001/03/06 06:20:41 achim Exp $

# also, this script now has pre/post inst/rm support

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/"${A}
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/glibc"

src_compile() {

  local myconf

  if [ "${DEBUG}" ]
  then
    myconf="--enable-debug=yes"
  else
    myconf="--enable-debug=no"
  fi

  try ./configure --host=${CHOST} --prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man  \
	--with-threads=posix ${myconf}
  try make

}

src_install() {

  try make install prefix=${D}/usr infodir=${D}/usr/share/info \
	mandir=${D}/usr/share/man

  dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
  cd docs
  docinto html
  dodoc glib.html glib_toc.html

}





