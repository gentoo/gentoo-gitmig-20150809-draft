# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/sgi-oss-glu/oss-opengl-glu-1.3.ebuild,v 1.2 2002/04/27 11:44:02 seemant Exp $

MY_P=oss-opengl-glu-20000925-1
S=${WORKDIR}/usr
DESCRIPTION="SGI'd GLU"
SRC_URI="ftp://mesa3d.sourceforge.net/pub/mesa3d/SI-GLU/${MY_P}.i386.rpm"
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
