# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Heade

P=powershell-0.80
A=powershell-0.8.tar.gz
S=${WORKDIR}/powershell-0.8
DESCRIPTION="Terminal emulator, supports multiple terminals in a single window"
SRC_URI="http://powershell.pdq.net/download/"${A}
HOMEPAGE="http://powershell.pdq.net"

DEPEND=">=gnome-base/gnome-libs-1.2.4"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  LDFLAGS="-L/opt/gnome/lib"  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
}



