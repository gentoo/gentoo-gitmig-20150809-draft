# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-0.5.10.ebuild,v 1.3 2001/02/01 19:30:33 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Library"
SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	virtual/kernel"


src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc ChangeLog COPYING 
}

pkg_postinst() {
	/usr/sbin/env-update
}



