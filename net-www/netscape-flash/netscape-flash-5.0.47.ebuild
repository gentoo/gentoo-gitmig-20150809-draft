# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-5.0.47.ebuild,v 1.1 2001/07/05 23:15:06 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/flash_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://???"${A}
HOMEPAGE="http://macromedia.com"

src_install() {                               
  dodir /opt/netscape/plugins
  exeinto /opt/netscape/plugins
  doexe *.class *.so
  dodoc README.Linux
}
