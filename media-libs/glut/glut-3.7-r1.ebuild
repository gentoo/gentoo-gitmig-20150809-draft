# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7-r1.ebuild,v 1.2 2001/01/20 19:42:51 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GLUT API for Linux"
SRC_URI="http://reality.sgi.com/opengl/glut3/${A}"
HOMEPAGE="http://reality.sgi.com/opengl/glut3/glut3.html"

DEPEND=">=sys-libs/glibc-2.1.3 >=x11-base/xfree-4.0.1"

src_unpack() {
	unpack ${A}
	cd ${S}/lib/glut
	cp ${FILESDIR}/glutscript.sh .
}

src_compile() {
    cd ${S}/lib/glut
   	try ./glutscript.sh 
}

src_install () {
    cd ${S}
    insinto /usr/X11R6/include/GL
    doins include/GL/*.h
    into /usr/X11R6
    dolib lib/glut/libglut.so.3.7
    preplib /usr/X11R6
    prepallstrip
}

pkg_postinst() {
	/usr/sbin/env-update
}
