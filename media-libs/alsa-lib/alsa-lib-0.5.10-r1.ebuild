# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.5.10-r1.ebuild,v 1.1 2001/02/13 14:29:40 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Library"
SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc virtual/alsa"
RDEPEND="virtual/glibc"

src_compile() {                           

  try ./configure --host=${CHOST} --prefix=/usr
  try make

}

src_install() {

  try make DESTDIR=${D} install
  dodoc ChangeLog COPYING

}




