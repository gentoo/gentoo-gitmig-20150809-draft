# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape/netscape-4.76-r1.ebuild,v 1.1 2001/01/15 16:20:54 achim Exp $

P=netscape-4.76
A=communicator-v476-us.x86-unknown-linux2.2.tar.gz
S=${WORKDIR}/communicator-v476.x86-unknown-linux2.2
DESCRIPTION="Netscape Communicator 4.76"
SRC_URI="ftp://ftp.netscape.com/pub/communicator/english/4.76/unix/supported/linux22/complete_install/"${A}
HOMEPAGE="http://developer.netscape.com/support/index.html"

RDEPEND=">=sys-libs/lib-compat-1.0"
PROVIDE="virtual/x11-web-browser"

src_install() {                               
  cd ${S}
  dodir /opt/netscape
  dodir /opt/netscape/java/classes
  dodir /usr/X11R6/bin
  dodoc README.install
  cd ${D}/opt/netscape
  gzip -dc ${S}/netscape-v476.nif | tar xf -
  gzip -dc ${S}/nethelp-v476.nif | tar xf -
  gzip -dc ${S}/spellchk-v476.nif | tar xf -
  cp ${S}/*.jar ${D}/opt/netscape/java/classes
  cp ${O}/files/netscape ${D}/usr/X11R6/bin/netscape
  rm ${D}/opt/netscape/netscape-dynMotif
  rm ${D}/opt/netscape/libnullplugin-dynMotif.so
  insinto /usr/X11R6/bin
  doins ${FILESDIR}/netscape 
  chmod +x ${D}/usr/X11R6/bin/netscape
}

