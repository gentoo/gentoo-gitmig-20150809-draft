# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.1.5.ebuild,v 1.4 2000/11/01 04:44:17 achim Exp $

A=SDL-${PV}.tar.gz
S=${WORKDIR}/SDL-${PV}
DESCRIPTION="Simple Direct Media Layer"
SRC_URI="http://www.libsdl.org/release/"${A}
HOMEPAGE="http://www.libsdl.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=dev-lang/nasm-0.98
	>=media-libs/alsa-lib-0.5.9
	>=media-libs/audiofile-0.1.9
	>=media-sound/esound-0.2.19
	>=x11-base/xfree-4.0.1"

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
  prepman
  dodoc BUGS COPYING CREDITS README* TODO WhatsNew
  docinto html
  dodoc *.html
  docinto html/docs
  dodoc docs/*.html
  
}




