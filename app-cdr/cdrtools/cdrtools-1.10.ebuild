# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrtools/cdrtools-1.10.ebuild,v 1.1 2001/10/05 19:49:19 ryan Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="cdrtools - A set of tools for CDR drives, including cdrecord"
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/${A}"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"

DEPEND="virtual/glibc"

src_unpack() {

  unpack ${A}
  cd ${S}/DEFAULTS
  cp Defaults.linux Defaults.linux.bak
  sed -e "s:/opt/schily:/usr:g" Defaults.linux.bak > Defaults.linux
  cd ..

}


src_compile() {

  try ./Gmake.linux
}

src_install() {


  dobin cdda2wav/OBJ/*-linux-cc/cdda2wav
  dobin cdrecord/OBJ/*-linux-cc/cdrecord
  cd ${S}
  dobin mkisofs/OBJ/*-linux-cc/mkisofs
  dobin misc/OBJ/*-linux-cc/readcd
  insinto /usr/include
  doins incs/*-linux-cc/align.h incs/*-linux-cc/avoffset.h

  cd mkisofs/diag/OBJ/*-linux-cc
  dobin devdump isodump isoinfo isovfy

  cd ${S}/libs/*-linux-cc
  dolib.a *.a

  cd  ${S}
  dodoc Changelog COPYING PORTING README* START

  cd ${S}/doc
  dodoc cdrecord-1.8.1_de-doc_0.1.tar
  docinto print
  dodoc *.ps
  newman cdda2wav.man cdda2wav.1
  newman cdrecord.man cdrecord.1
  newman readcd.man readcd.1
  newman isoinfo.man isoinfo.8
  newman mkisofs.man mkisofs.8


}
