# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/egoboo/egoboo-2.22.ebuild,v 1.1 2003/09/10 06:26:50 vapier Exp $

inherit flag-o-matic

N=egoboo
S=${WORKDIR}/${N}
DESCRIPTION="egoboo: a 3d dungeon crawling adventure in the spirit of NetHack"
SRC_URI="mirror://sourceforge/${PN}/ego${PV/./}.tar.gz"
HOMEPAGE="http://egoboo.sourceforge.net/"
KEYWORDS="x86 -ppc"
SLOT="0"

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	media-libs/libsdl"
LICENSE="GPL-2"

src_unpack() {
	SDLLIBS=`sdl-config --libs`
	SDLFLAGS=`sdl-config --cflags`

	unpack ${A}
	cd ${S}/code
	patch < ${FILESDIR}/${P}-makefile-gentoo.patch || die "Patch Failed"
	mv Makefile Makefile.bak
	echo SDLLIBS=${SDLLIBS} > /tmp/sdllibs.tmp || die "file already exists"
	echo SDLFLAGS=${SDLFLAGS} > /tmp/sdlflags.tmp || die "file already exists"a
	cat /tmp/sdllibs.tmp /tmp/sdlflags.tmp Makefile.bak > Makefile
	rm -f /tmp/sdllibs.tmp
	rm -f /tmp/sdlflags.tmp
}

src_compile() {
	replace-flags "-march=athlon*" "-march=i686"
	replace-flags "-march=pentium4" "-march=i686"

	cd code
	make clean || die "failed build"
	make egoboo || die "failed build"
	}

src_install () {
	dodir /usr/share/egoboo
	dodir /usr/bin
	dodoc egoboo.txt gpl.txt
	cp -r basicdat ${D}/usr/share/egoboo
	cp code/egoboo ${D}/usr/share/egoboo
	cp -r import ${D}/usr/share/egoboo
	cp -r modules ${D}/usr/share/egoboo
	cp -r players ${D}/usr/share/egoboo
	cp -r text ${D}/usr/share/egoboo
	cp controls.txt ${D}/usr/share/egoboo
	cp setup.txt ${D}/usr/share/egoboo
	cp ${FILESDIR}/${P}.sh ${D}/usr/bin/egoboo

	#chown to root.users and chmod g+w to let regular users run the app
	cd ${D}/usr/share/egoboo
	chown -R root.users *
	chmod -R g+w setup.txt basicdat players
}
