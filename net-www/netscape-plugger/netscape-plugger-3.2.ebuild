# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-plugger/netscape-plugger-3.2.ebuild,v 1.1 2000/09/15 16:18:48 drobbins Exp $

A=plugger-3.2-linux-x86-glibc.tar.gz
S=${WORKDIR}/plugger-3.2
DESCRIPTION="Plugger 3.2 streaming media plugin"
SRC_URI="http://fredrik.hubbe.net/plugger/"${A}
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"

src_install() {                               
  cd ${S}
  dodir /opt/netscape/plugins /etc
  insinto /opt/netscape/plugins
  doins *.so
  insinto /etc
  doins pluggerrc
  dodoc README
  doman plugger.7
}
