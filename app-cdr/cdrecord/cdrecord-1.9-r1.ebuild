# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrecord/cdrecord-1.9-r1.ebuild,v 1.3 2000/09/15 20:08:45 drobbins Exp $

P=cdrecord-1.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="cdrecord"
SRC_URI="ftp://ftp.fokus.gmd.de/pub/unix/cdrecord/"${A}
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"

src_unpack() {
  unpack ${A}
  cd ${S}/DEFAULTS
  cp Defaults.linux Defaults.linux.bak
  sed -e "s:/opt/schily:/usr:g" Defaults.linux.bak > Defaults.linux
  cd ..
} 
  

src_compile() {
  cd ${S}
  ./Gtry make.linux
}

src_install() {
  cd ${S}      
  dobin cdda2wav/OBJ/*-linux-cc/cdda2wav
  dobin cdrecord/OBJ/*-linux-cc/cdrecord
  cd mkisofs/diag/OBJ/*-linux-cc
  dobin devdump isodump isoinfo isovfy
  cd ${S}
  dobin mkisofs/OBJ/*-linux-cc/mkisofs
  dobin misc/OBJ/*-linux-cc/readcd
  insinto /usr/include
  doins incs/*-linux-cc/align.h incs/*-linux-cc/avoffset.h
  cd ${S}/libs/*-linux-cc
  dolib.a *.a
  cd ${S}/doc
  newman cdda2wav.man cdda2wav.1
  newman cdrecord.man cdrecord.1
  newman readcd.man readcd.1
  newman isoinfo.man isoinfo.8
  newman mkisofs.man mkisofs.8
  cd  ${S}
  dodoc Changelog COPYING PORTING README* START
}



