# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetron/armagetron-0.1.4.9.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="armagetron: 3d tron lightcycles, just like the movie"
SRC_URI="mirror://sourceforge/armagetron/armagetron_src_${PV}.tar.gz
	http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
	http://armagetron.sourceforge.net/addons/moviepack.zip"
HOMEPAGE="http://armagetron.sourceforge.net/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
CXXFLAGS=${CXXFLAGS/-fno-exceptions/}
RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"

DEPEND="$RDEPEND app-arch/unzip"

src_unpack() {
	unpack armagetron_src_${PV}.tar.gz
	unpack moviesounds_fq.zip
	unpack moviepack.zip
	set > /tmp/emerge-env.txt
	cd ${S}
	# Doesn't find libs in /usr/X11R6/lib for some reason...patched
	patch < ${FILESDIR}/${P}-configure.patch || die "Patch 1 Failed"
	# Uses $SYNC which which conflicts with emerge
	patch < ${FILESDIR}/${P}-Makefile.global.in.patch || dir "Patch 2 Failed"
}

src_compile() {
	CXXFLAGS="$CXXFLAGS" ./configure --prefix=/usr --host="${CHOST}" || die "config failed"
	make  all || die "Make Failed"
}

src_install () {
	# make install for armagetron is non-existant
	dodir /usr/bin
	dodir /usr/share/armagetron
	dodir /usr/X11R6/lib/X11/fonts/truetype
	cp src/tron/armagetron ${D}/usr/share/armagetron || die "No Armagetron Executable"
	cp -r arenas  ${D}/usr/share/armagetron/arenas
	cp -r models ${D}/usr/share/armagetron/models
	cp -r sound ${D}/usr/share/armagetron/sound
	cp -r textures ${D}/usr/share/armagetron/textures
	# maybe convert this to a .png or something
	#cp tron.ico ${D}/usr/share/armagetron
	dohtml doc
	cp ${FILESDIR}/${P}.sh ${D}/usr/bin/armagetron
	cp -r ../moviepack ${D}/usr/share/armagetron
	cp -r ../moviesounds ${D}/usr/share/armagetron
	chmod -R a+r ${D}
	chmod a+rx ${D}/usr/bin/armagetron
	chmod a+rx ${D}/usr/share/armagetron/armagetron
}
