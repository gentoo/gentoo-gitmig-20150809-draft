# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Christian Rubbert <crubb@xrc.de>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rar/rar-2.90.ebuild,v 1.1 2002/01/27 07:31:04 blocke Exp $

S=${WORKDIR}/rar
DESCRIPTION="rar compressor/uncompressor"
SRC_URI="ftp://ftp.elf.stuba.sk/pub/pc/pack/rarlnx29.sfx"
HOMEPAGE="ftp://ftp.elf.stuba.sk/pub/pc/pack"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"
# Might be more depends... probably not, though

src_unpack() {
  cp ${DISTDIR}/${A} ${WORKDIR}
  chmod 0755 ${WORKDIR}/${A}
  ${WORKDIR}/${A}
  rm ${WORKDIR}/${A}
}

src_compile() {
  echo ">>> Nothing to compile..."
}

src_install() {
  dobin rar unrar
  dodoc *.txt
}
