# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-0.5.0.ebuild,v 1.1 2001/03/15 21:01:34 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxslt"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
	>=gnome-libs/libxml2-2.3.4"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               

        try make prefix=${D}/opt/gnome install
	dodoc AUTHORS COPYING* ChangeLog README NEWS TODO
}

