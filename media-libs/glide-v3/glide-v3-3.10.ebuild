# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Travis Tilley <lordviram@nesit.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/glide-v3/glide-v3-3.10.ebuild,v 1.1 2002/01/29 08:49:17 azarah Exp $

S=${WORKDIR}/${PN/-v3/3x}
DESCRIPTION="Hardware support for the voodoo3"
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

if [ "`use voodoo3`" ] ; then
	compilefor="h3"
elif [ "`use voodoo4`" ] ; then
	compilefor="h5"
elif [ "`use voodoo5`" ] ; then
	compilefor="h5"
else
#	die "You need voodoo3, voodoo4 or voodoo5 in your USE !!!"
# if we do this, a emerge --world update fails for people not using voodoo's,
# so default to h3 for now
	compilefor="h3"
fi

src_compile() {
	cd ${WORKDIR}
	chmod +x swlibs/include/make/ostype
	cd ${WORKDIR}/glide3x ; ln -fs ${WORKDIR}/swlibs swlibs
	cd ${WORKDIR}/glide3x/h3/minihwc ; ln -fs linhwc.c.dri linhwc.c
	cd ${WORKDIR}/glide3x/h3/glide3/src ; ln -fs gglide.c.dri gglide.c
	ln -fs gsst.c.dri gsst.c ; ln -fs glfb.c.dri glfb.c
	
	cd ${WORKDIR}/glide3x
	libtoolize -f && aclocal && automake && autoconf
	mkdir build
	cd build
	../configure --prefix=/usr \
		--enable-fx-glide-hw=$compilefor \
		--enable-fx-dri-build || die
		
	build.3dfx all || die
}

src_install() {
	cd ${WORKDIR}/glide3x/build
	build.3dfx DESTDIR=${D} install || die
}
