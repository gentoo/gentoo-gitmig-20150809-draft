# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape/netscape-4.73-r1.ebuild,v 1.2 2000/08/16 04:38:21 drobbins Exp $

P=netscape-4.73
A=communicator-v473-export.x86-unknown-linuxglibc2.0.tar.gz
S=${WORKDIR}/communicator-v473.x86-unknown-linux2.0
DESCRIPTION="Netscape Communicator 4.73"
SRC_URI="ftp://ftp.netscape.com/pub/communicator/english/4.73/unix/supported/linux20_glibc2/complete_install/"${A}
HOMEPAGE="http://developer.netscape.com/support/index.html"

src_install() {                               
  cd ${S}
  dodir /opt/netscape
  dodir /opt/netscape/java/classes
  dodir /usr/X11R6/bin
  dodoc README.install
  cd ${D}/opt/netscape
  gzip -dc ${S}/netscape-v473.nif | tar xf -
  gzip -dc ${S}/nethelp-v473.nif | tar xf -
  gzip -dc ${S}/spellchk-v473.nif | tar xf -
  cp ${S}/*.jar ${D}/opt/netscape/java/classes
  cp ${O}/files/netscape ${D}/usr/X11R6/bin/netscape
  rm ${D}/opt/netscape/netscape-dynMotif
  rm ${D}/opt/netscape/libnullplugin-dynMotif.so

}



