# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.9a.ebuild,v 1.2 2000/09/15 20:09:04 drobbins Exp $

P=alsa-utils-0.5.9a
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Advanced Linux Sound Architecture / Utils"
SRC_URI="ftp://ftp.alsa-project.org/pub/utils/"${A}
HOMEPAGE="http://www.alsa-project.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr
  try make

}

src_install() {                               
  cd ${S}/aplay
  cd aplay
  cp Makefile Makefile.orig
  sed -e "s:cd \$(bindir):cd \$(DESTDIR)\$(bindir):" \
  sed -e "s:cd \$(mandir):cd \$(DESTDIR)\$(mandir):" \
  Makefile.orig > Makefile
  cd ${S}
  try make DESTDIR=${D} install
  dodoc ChangeLog COPYING README
  newdoc alsamixer/README README.alsamixer
  dodoc seq/aconnect/README* seq/aseqnet/README*
  prepman
}




