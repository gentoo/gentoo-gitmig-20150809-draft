# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Heade

P=nmap-2.53
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Portscanner"
SRC_URI="http://www.insecure.org/nmap/dist/"${A}
HOMEPAGE="http://www.insecure.org/nmap/"

DEPEND=">=x11-libs/gtk+-1.2.8"

src_unpack() {
  unpack ${A}
  if [ -n "`use glibc22`" ]
  then
	cd ${S}
	cp ${FILESDIR}/tcpip.h ${S}/tcpip.h
	cp ${FILESDIR}/nmap.h ${S}/nmap.h
  fi
}
src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  prepman /opt/gnome

  dodoc CHANGELOG COPYING README
  cd docs
  dodoc *.txt
  docinto html
  dodoc *.html
}



