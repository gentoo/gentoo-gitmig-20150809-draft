# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/koules/koules-1.4-r1.ebuild,v 1.5 2004/03/28 06:00:36 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="fast action arcade-style game w/sound and network support"
HOMEPAGE="http://www.ucw.cz/~hubicka/koules/English/"
SRC_URI="http://www.ucw.cz/~hubicka/koules/packages/koules${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="svga joystick tcltk"

DEPEND=">=sys-apps/sed-4
	|| (
		svga? ( media-libs/svgalib )
		virtual/x11 )"
RDEPEND="virtual/glibc
	|| (
		svga? ( media-libs/svgalib )
		virtual/x11 )
	|| (
		tcltk? ( dev-lang/tk dev-lang/tcl )
		dev-util/dialog )"

S="${WORKDIR}/${PN}${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-gcc3.patch"
	sed -i \
		-e "/^KOULESDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^SOUNDDIR/s:=.*:=${GAMES_DATADIR}/${PN}:" Iconfig \
			|| die "sed Iconfig failed"
	sed -i \
		-e 's:-c -o $*.o:-c:' \
		-e 's:-S -o $*.s:-S:' \
		-e 's:$(ARCH)::' \
		-e "s:-fomit-frame-pointer -O3 -ffast-math:${CFLAGS}:" \
		Makefile.svgalib || die "sed Makefile.svgalib failed"
	use joystick && echo '#define JOYSTICK' >> Iconfig
	sed -i \
		-e "s:/usr/local/bin:${GAMES_BINDIR}:" koules \
			|| die "sed koules failed"
	if use tcltk ; then
		sed -i \
			-e "s:/usr/bin/X11:${GAMES_BINDIR}:" \
			-e "s:/usr/local/bin:${GAMES_BINDIR}:" \
			-e "s:/usr/local/lib/koules:${GAMES_DATADIR}/${PN}:" koules.tcl \
				|| die "sed koules.tcl failed"
	else
		sed -i \
			-e 's:exec.*tcl:exec xkoules "$@":' koules \
				|| die "sed koules failed"
	fi
	ln -s xkoules.6 xkoules.man
	ln -s xkoules.6 xkoules._man
}

src_compile() {
	mkdir bins
	if ! use svga ; then
		xmkmf -a
		sed -i \
			-e "/^ *CFLAGS =/s:$: ${CFLAGS}:" Makefile \
				|| die "sed Makefile failed"
		emake -j1 || die "emake X failed"
		mv xkoules bins/
	fi
	if use svga ; then
		make clean
		ln -s ../init.o svgalib/
		emake -j1 -f Makefile.svgalib || die "emake svga failed"
		mv koules.svga bins/
	fi
}

src_install() {
	dogamesbin koules bins/* || die "dogamesbin failed"
	exeinto "${GAMES_DATADIR}/${PN}"
	doexe koules.sndsrv.linux || die "doexe failed"
	if use tcltk ; then
		dogamesbin koules.tcl || die "dogamebin failed (tcl)"
	fi
	insinto ${GAMES_DATADIR}/${PN}
	doins sounds/* || die "doins failed (sounds)"

	doman xkoules.6
	use svga && doman koules.svga.6
	dodoc README ChangeLog BUGS ANNOUNCE TODO Koules.FAQ

	prepgamesdirs
}
