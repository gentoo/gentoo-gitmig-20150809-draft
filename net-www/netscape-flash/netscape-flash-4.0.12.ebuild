# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-4.0.12.ebuild,v 1.1 2000/09/15 16:18:48 drobbins Exp $

A=flash_linux.tar.gz
S=${WORKDIR}/Linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://???"${A}
HOMEPAGE="http://macromedia.com"

src_install() {                               
  cd ${S}
  dodir /opt/netscape/plugins
  insinto /opt/netscape/plugins
  doins *.class *.so
  dodoc README.Linux
}
