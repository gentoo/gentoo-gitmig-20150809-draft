# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipcheck/ipcheck-0.123.ebuild,v 1.1 2001/07/09 15:09:28 achim Exp $

A=${P}.py
S=${WORKDIR}/${P}
DESCRIPTION="A python based dyndns client"
SRC_URI="ftp://"
HOMEPAGE="http://ipcheck.sourceforge.net/"
RDEPEND="virtual/python"
src_unpack() {
  mkdir ${S}
  cp ${DISTDIR}/${A} ${S}
}
src_install () {

  exeinto /usr/sbin
  newexe ${P}.py ${PN}.py
}

