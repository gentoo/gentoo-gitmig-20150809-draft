# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Travis Tilley <lordviram@nesit.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/glide-v3/glide-v3-3.10-r2.ebuild,v 1.2 2002/04/15 10:23:58 seemant Exp $

S=${WORKDIR}/${PN/-v3/3x}
DESCRIPTION="Hardware support for the voodoo3, voodoo4 and voodoo5"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/glide3x-${PV}.tar.gz
	http://www.ibiblio.org/gentoo/distfiles/swlibs-${PV}.tar.gz"
# check for future updates here
# http://telia.dl.sourceforge.net/mirrors/slackware/slackware-8.0/contrib/contrib-sources/3dfx/voodoo4_voodoo5/
HOMEPAGE="http://glide.sourceforge.net/"

DEPEND=">=sys-devel/automake-1.4
	>=sys-devel/autoconf-2.13
	>=sys-devel/libtool-1.3.3
	>=sys-devel/m4-1.4
	>=sys-devel/perl-5.005"

PROVIDE="virtual/glide"

use voodoo3 \
	&& compilefor="h3" \
	|| compilefor="h5"

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}
	chmod +x swlibs/include/make/ostype
	cd ${S} ; ln -fs ${WORKDIR}/swlibs swlibs
	cd ${S}/h3/minihwc ; ln -fs linhwc.c.dri linhwc.c
	cd ${S}/h3/glide3/src ; ln -fs gglide.c.dri gglide.c
	ln -fs gsst.c.dri gsst.c ; ln -fs glfb.c.dri glfb.c
	
	cd ${WORKDIR}/swlibs/include/make
	cp makefile.autoconf.bottom makefile.autoconf.bottom.orig
	sed -e "s:-O6 -m486:${CFLAGS}:" makefile.autoconf.bottom.orig \
		> makefile.autoconf.bottom
	
	cd ${S}
	libtoolize -f && aclocal && automake && autoconf
}
	
src_compile() {
	mkdir build
	cd build
	../configure --prefix=/usr \
		--enable-fx-glide-hw=${compilefor} \
		--enable-fx-dri-build || die
		
	./build.3dfx all || die
}

src_install() {
	cd ${S}/build
	./build.3dfx DESTDIR=${D} install || die

	dodir /usr/X11R6/lib
	dosym /usr/lib/libglide3.so.${PV}.0 /usr/X11R6/lib/libglide3.so
}
