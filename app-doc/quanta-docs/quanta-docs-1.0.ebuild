# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/quanta-docs/quanta-docs-1.0.ebuild,v 1.1 2001/08/14 16:48:09 achim Exp $

S=${WORKDIR}
DESCRIPTION="Lot's of docs for quanta"

A="quanta-css-${PV}.tar.bz2 
   quanta-html-${PV}.tar.bz2 
   quanta-javascript-${PV}.tar.bz2
   quanta-php-${PV}.tar.bz2"

HOMEPAGE="http://quanta.sourceforge.net"


src_install () {

    dodir ${KDEDIR}/share/apps/quanta/doc
    for i in css html javascript php
    do
      cd ${S}/${i}
      cp -R $i $i.docrc ${D}/${KDEDIR}/share/apps/quanta/doc    
    done

}

