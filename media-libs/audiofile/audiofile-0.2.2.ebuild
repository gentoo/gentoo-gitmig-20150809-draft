# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/audiofile/audiofile-0.2.2.ebuild,v 1.1 2001/09/04 19:19:02 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An elegant API for accessing audio files"
SRC_URI="ftp://oss.sgi.com/projects/audiofile/download/${A}"
HOMEPAGE="http://oss.sgi.com/projects/audiofile/"

DEPEND="virtual/glibc"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr
  try pmake
}

src_install() {

  try make prefix=${D}/usr install
  dodoc ACKNOWLEDGEMENTS AUTHORS COPYING* ChangeLog README TODO
  dodoc NEWS NOTES

}






