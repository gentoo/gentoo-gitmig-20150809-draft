# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sgi-oss-glu/oss-opengl-glu-1.3.ebuild,v 1.1 2001/08/16 23:19:35 lamer Exp $

A=oss-opengl-glu-20000925-1.i386.rpm
P=oss-opengl-glu-20000925-1.i386.rpm
S=${WORKDIR}/usr
DESCRIPTION="SGI'd GLU"
SRC_URI="ftp://mesa3d.sourceforge.net/pub/mesa3d/SI-GLU/${A}"
HOMEPAGE="http://www.mesa3d.org/downloads/sgi.html"

DEPEND=">=app-arch/rpm-3.0.6"


src_unpack() {

  rpm2cpio ${DISTDIR}/${P} |cpio -i --make-directories

}

src_compile() {

    einfo  "Only binary package, nothing to compile"

}

src_install () {

	insinto /usr/include/GL
	doins ${S}/include/GL/glu.h
	insinto /usr/lib
	doins ${S}/lib/*


}

