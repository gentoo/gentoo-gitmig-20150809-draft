# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/koules/koules-1.4-r1.ebuild,v 1.4 2004/03/27 09:58:47 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="fast action arcade-style game w/sound and network support"
HOMEPAGE="http://www.ucw.cz/~hubicka/koules/English/"
SRC_URI="http://www.ucw.cz/~hubicka/koules/packages/koules${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="X svga joystick"

DEPEND=">=sys-apps/sed-4
	|| (
		svga? ( media-libs/svgalib )
		X? ( virtual/x11 )
		virtual/x11 )"
RDEPEND="virtual/glibc
	|| (
		svga? ( media-libs/svgalib )
		X? ( virtual/x11 )
		virtual/x11 )
	|| (
		tcltk? ( dev-lang/tk dev-lang/tcl )
		dev-util/dialog
	)"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-gcc3.patch"
	sed -i \
		-e "/^KOULESDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^SOUNDDIR/s:=.*:=${GAMES_DATADIR}/${PN}:" \
		Iconfig || die
	sed -i \
		-e 's:-c -o $*.o:-c:' \
		-e 's:-S -o $*.s:-S:' \
		-e 's:$(ARCH)::' \
		-e "s:-fomit-frame-pointer -O3 -ffast-math:${CFLAGS}:" \
		Makefile.svgalib
	#[ ${ARCH} == "x86" ] && echo '#define I386ASSEMBLY' >> Iconfig
	[ `use joystick` ] && echo '#define JOYSTICK' >> Iconfig
	sed -i "s:/usr/local/bin:${GAMES_BINDIR}:" koules
	if [ `use tcltk` ] ; then
		sed -i \
			-e "s:/usr/bin/X11:${GAMES_BINDIR}:" \
			-e "s:/usr/local/bin:${GAMES_BINDIR}:" \
			-e "s:/usr/local/lib/koules:${GAMES_DATADIR}/${PN}:" \
			koules.tcl
	else
		sed -i 's:exec.*tcl:exec xkoules "$@":' koules
	fi
	ln -s xkoules.6 xkoules.man
	ln -s xkoules.6 xkoules._man
}

src_compile() {
	mkdir bins
	if [ `use X` ] || [ -z "`use X``use svga`" ] ; then
		xmkmf -a
		sed -i "/^ *CFLAGS =/s:$: ${CFLAGS}:" Makefile
		make || die "emake X failed"
		mv xkoules bins/
	fi
	if [ `use svga` ] ; then
		make clean
		ln -s ../init.o svgalib/
		make -f Makefile.svgalib || die "emake svga failed"
		mv koules.svga bins/
	fi
}

src_install() {
	dogamesbin bins/*
	exeinto ${GAMES_DATADIR}/${PN}
	doexe koules.sndsrv.linux
	[ `use tcltk` ] && dogamesbin koules.tcl
	insinto ${GAMES_DATADIR}/${PN}
	doins sounds/*
	dogamesbin koules

	doman xkoules.6
	use svga && doman koules.svga.6
	dodoc README ChangeLog BUGS ANNOUNCE TODO Koules.FAQ

	prepgamesdirs
}
