# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.8-r1.ebuild,v 1.6 2000/11/01 04:44:15 achim Exp $

# also, this script now has pre/post inst/rm support

P=glib-1.2.8
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/"${A}
HOMEPAGE="http://www.gtk.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3"

src_compile() {
  cd ${S}                           
  try ./configure --host=${CHOST} --prefix=/usr --infodir=/usr/info --with-threads=posix
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/usr
  dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
  cd docs
  docinto html
  dodoc glib.html glib_toc.html
}





