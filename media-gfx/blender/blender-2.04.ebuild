# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.04.ebuild,v 1.2 2000/10/28 19:55:05 drobbins Exp $

A="blender${PV}-linux-glibc2.1.2-i386.tar.gz manual_1.5.zip"
S=${WORKDIR}/blender${PV}-linux-glibc2.1.2-i386
DESCRIPTION="Etremly fast and versatile 3D rendering package"
SRC_URI="ftp://ftp.blender.nl/pub/blender${PV}-linux-glibc2.1.2-i386.tar.gz ftp://ftp.blender.nl/pub/manual_1.5.zip"
HOMEPAGE="http://www.blender.nl"


src_unpack () {
  echo
}

src_install () {

    cd ${S}
    dodir /opt
    cd ${D}/opt
    tar xzf ${DISTDIR}/blender${PV}-linux-glibc2.1.2-i386.tar.gz
    mv blender${PV}-linux-glibc2.1.2-i386 blender-${PV}
    dodir /usr/doc/${P}
    cd ${D}/usr/doc/${P}
    unzip ${DISTDIR}/manual_1.5.zip
    mv manual_1.5 html
    insinto /usr/X11R6/bin
    insopts -m755
    doins ${FILESDIR}/blender    

}

