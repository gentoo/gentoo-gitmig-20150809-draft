# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook/docbook-3.0-r1.ebuild,v 1.2 2000/08/16 04:37:55 drobbins Exp $

P=docbook-3.0
A="docbk30.zip ISOEnts.zip"
S=${WORKDIR}/${P}
DESCRIPTION="DocBook is an SGML DTD"
SRC_URI="http://www.oasis-open.org/docbook/sgml/3.0/docbk30.zip
	 http://www.oasis-open.org/cover/ISOEnts.zip"
HOMEPAGE="http://www.oasis-open.org/docbook/"

src_unpack() {
  mkdir ${S}
  cd ${S}
  unzip  ${DISTDIR}/docbk30.zip
  unzip  ${DISTDIR}/ISOEnts.zip
}

src_compile() {                           
  cd ${S}
  cp docbook.cat docbook.cat.orig
  sed -e "s/iso-/ISO/" -e "s/.gml//" docbook.cat.orig > docbook.cat
}

src_install() {                               
  cd ${S}
  insinto /usr/share/sgml/dtd/docbook-3.0
  doins *.dtd *.mod *.cat *.dcl ISO*
  dodoc *.txt

}




