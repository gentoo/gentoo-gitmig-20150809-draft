# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-terms/powershell/powershell-0.80.ebuild,v 1.7 2001/08/31 03:23:39 pm Exp $


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
  try pmake
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
}



