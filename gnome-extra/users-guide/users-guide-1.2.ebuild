# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/users-guide/users-guide-1.2.ebuild,v 1.6 2001/06/11 08:11:28 hallski Exp $

P=users-guide-1.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-users-guide"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/users-guide/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=""

src_compile() {
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try pmake
}

src_install() {
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README* TODO
}



