# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-core/gnome-core-1.2.4.ebuild,v 1.4 2001/01/13 20:07:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-core"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gtkhtml-0.7"

src_compile() {                           
  cd ${S}
  try LDFLAGS=\"-L/opt/gnome/lib -lunicode -lgtkhtml -lpspell\" ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-kde-datadir=/opt/kde2/share --enable-gtkhtml-help
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog README NEWS
}








