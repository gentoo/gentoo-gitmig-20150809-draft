# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libghttp/libghttp-1.0.9.ebuild,v 1.3 2001/04/30 11:10:57 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libghttp"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               

        try make prefix=${D}/opt/gnome install
	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
	docinto html
	dodoc doc/ghttp.html
}

