# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/koules/koules-1.4-r2.ebuild,v 1.4 2007/02/24 01:28:44 nyhm Exp $

inherit eutils games

DESCRIPTION="fast action arcade-style game w/sound and network support"
HOMEPAGE="http://www.ucw.cz/~hubicka/koules/English/"
SRC_URI="http://www.ucw.cz/~hubicka/koules/packages/koules${PV}-src.tar.gz
	mirror://gentoo/${P}-gcc3.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc x86"
IUSE="joystick svga tk"

RDEPEND="svga? ( media-libs/svgalib )
	!svga? (
		x11-libs/libX11
		x11-libs/libXext
		media-fonts/font-schumacher-misc
	)
	tk? (
		dev-lang/tk
		dev-lang/tcl
	)
	!tk? ( dev-util/dialog )"
DEPEND="${RDEPEND}
	!svga? (
		x11-proto/xextproto
		x11-proto/xproto
		x11-misc/gccmakedep
		x11-misc/imake
		app-text/rman
	)"

S=${WORKDIR}/${PN}${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${P}-gcc3.patch
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
	if use tk ; then
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
			-e '/SYSDEFS =/d' \
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
	if use tk ; then
		dogamesbin koules.tcl || die "dogamebin failed (tcl)"
	fi
	insinto "${GAMES_DATADIR}/${PN}"
	doins sounds/* || die "doins failed (sounds)"

	doman xkoules.6
	use svga && doman koules.svga.6
	dodoc README ChangeLog BUGS ANNOUNCE TODO Koules.FAQ

	prepgamesdirs
}
