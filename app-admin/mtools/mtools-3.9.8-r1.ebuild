# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@fet.org>

S=${WORKDIR}/${P}
DESCRIPTION="Mtools is a collection of utilities to access MS-DOS disks 
from Unix without mounting them. It supports Win95 style long file names,..." 

SRC_URI="http://mtools.linux.lu/mtools-3.9.8.tar.gz"
HOMEPAGE="http://mtools.linux.lu"
DEPEND="virtual/glibc sys-apps/texinfo"
RDEPEND="virtual/glibc"


src_compile() {
  try ./configure --prefix=${D}/usr --mandir=${D}/usr/share/man
  try make
}

src_install () {
  try make install
}

