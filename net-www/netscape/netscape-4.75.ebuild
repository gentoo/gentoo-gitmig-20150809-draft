# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape/netscape-4.75.ebuild,v 1.6 2000/12/03 23:12:28 drobbins Exp $

P=netscape-4.75
A=communicator-v475-us.x86-unknown-linux2.2.tar.gz
S=${WORKDIR}/communicator-v475.x86-unknown-linux2.2
DESCRIPTION="Netscape Communicator 4.75"
SRC_URI="ftp://ftp.netscape.com/pub/communicator/english/4.75/unix/supported/linux22/complete_install/"${A}
HOMEPAGE="http://developer.netscape.com/support/index.html"
PROVIDE="virtual/x11-web-browser"

src_install() {                               
  cd ${S}
  dodir /opt/netscape
  dodir /opt/netscape/java/classes
  dodir /usr/X11R6/bin
  dodoc README.install
  cd ${D}/opt/netscape
  gzip -dc ${S}/netscape-v475.nif | tar xf -
  gzip -dc ${S}/nethelp-v475.nif | tar xf -
  gzip -dc ${S}/spellchk-v475.nif | tar xf -
  cp ${S}/*.jar ${D}/opt/netscape/java/classes
  cp ${O}/files/netscape ${D}/usr/X11R6/bin/netscape
  rm ${D}/opt/netscape/netscape-dynMotif
  rm ${D}/opt/netscape/libnullplugin-dynMotif.so
  insinto /usr/X11R6/bin
  doins ${FILES}/netscape 
  chmod +x ${D}/usr/X11R6/bin/netscape
}

