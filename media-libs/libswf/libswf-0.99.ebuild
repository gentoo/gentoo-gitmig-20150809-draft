# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libswf/libswf-0.99.ebuild,v 1.1 2001/07/03 16:52:07 achim Exp $

S=${WORKDIR}/dist
DESCRIPTION="A library for flash movies"
SRC_URI="http://reality.sgi.com/grafica/flash/dist.99.linux.tar.Z"
HOMEPAGE="http://reality.sgi.com/grafica/flash/"

DEPEND="virtual/glibc"

src_install () {

  dolib.a libswf.a
  dobin bin/*
  insinto /usr/include
  doins swf.h
  insinto /usr/share/swf/fonts
  doins fonts/*
  insinto /usr/share/swf/psfonts
  doins psfonts/*
  docinto html
  dodoc *.html
}

