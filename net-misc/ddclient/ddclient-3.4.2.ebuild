# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ddclient/ddclient-3.4.2.ebuild,v 1.1 2001/07/09 15:03:18 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A perl based client for dyndns"
SRC_URI="http://burry.ca:4141/ddclient/${A}"
HOMEPAGE="http://burry.ca:4141/ddclient/"
RDEPEND="sys-devel/perl"

src_unpack() {
  unpack ${A}
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}
src_install () {

  exeinto /usr/sbin
  doexe ddclient
  insinto /etc/ddclient
  doins sample-*
  mv ${D}etc/ddclient/sample-etc_ddclient.conf ${D}etc/ddclient/ddclient.conf
  dodoc README COPYING COPYRIGHT
}

