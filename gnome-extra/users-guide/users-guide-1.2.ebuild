# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/users-guide/users-guide-1.2.ebuild,v 1.4 2000/11/04 16:14:54 achim Exp $

P=users-guide-1.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-users-guide"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/users-guide/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-devel/automake-1.4
	>=sys-devel/autoconf-2.13
	>=sys-apps/texinfo-4.0"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README* TODO
}



