# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetron/armagetron-0.1.4.9.ebuild,v 1.3 2004/02/20 06:13:56 mr_bones_ Exp $

inherit eutils flag-o-matic

DESCRIPTION="armagetron: 3d tron lightcycles, just like the movie"
HOMEPAGE="http://armagetron.sourceforge.net/"
SRC_URI="mirror://sourceforge/armagetron/armagetron_src_${PV}.tar.gz
	http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
	http://armagetron.sourceforge.net/addons/moviepack.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack armagetron_src_${PV}.tar.gz
	unpack moviesounds_fq.zip
	unpack moviepack.zip
	cd ${S}
	# Doesn't find libs in /usr/X11R6/lib for some reason...patched
	epatch ${FILESDIR}/${P}-configure.patch
	# Uses $SYNC which which conflicts with emerge
	epatch ${FILESDIR}/${P}-Makefile.global.in.patch
}

src_compile() {
	filter-flags -fno-exceptions
	econf || die "config failed"
	emake all || die "Make Failed"
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
