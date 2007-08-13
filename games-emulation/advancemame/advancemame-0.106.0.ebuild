# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/advancemame/advancemame-0.106.0.ebuild,v 1.5 2007/08/13 07:44:16 mr_bones_ Exp $

inherit eutils flag-o-matic games

DESCRIPTION="GNU/Linux port of the MAME emulator with GUI menu"
HOMEPAGE="http://advancemame.sourceforge.net/"
SRC_URI="mirror://sourceforge/advancemame/${P}.tar.gz"

LICENSE="GPL-2 XMAME"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="alsa expat fbcon oss sdl slang static svga truetype zlib"

# sdl is required (bug #158417)
RDEPEND="app-arch/unzip
	app-arch/zip
	media-libs/libsdl
	slang? ( =sys-libs/slang-1* )
	alsa? ( media-libs/alsa-lib )
	expat? ( >=dev-libs/expat-1.95.6 )
	zlib? ( sys-libs/zlib )
	truetype? ( media-libs/freetype )
	svga? ( >=media-libs/svgalib-1.9 )"
DEPEND="${RDEPEND}
	x86? ( >=dev-lang/nasm-0.98 )
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-pic.patch"
	sed -i \
		-e 's/"-s"//' \
		configure \
		|| die "sed failed"

	use x86 && \
		ln -s $(type -P nasm) "${T}/${CHOST}-nasm"
	ln -s $(type -P sdl-config) "${T}/${CHOST}-sdl-config"
	use truetype && \
		ln -s $(type -P freetype-config) "${T}/${CHOST}-freetype-config"
}

src_compile() {
	# Fix for bug #78030
	if use ppc; then
		append-ldflags "-Wl,--relax"
	fi

	PATH="${PATH}:${T}"
	egamesconf \
		--enable-sdl \
		$(use_enable alsa) \
		$(use_enable expat) \
		$(use_enable fbcon fb) \
		$(use_enable oss) \
		$(use_enable slang) \
		$(use_enable static) \
		$(use_enable svga svgalib) \
		$(use_enable truetype freetype) \
		$(use_enable zlib) \
		$(use_enable x86 asm) \
		--with-emu=${PN/advance} \
		|| die
	STRIPPROG=true emake || die "emake failed"
}

src_install() {
	local f

	for f in adv* ; do
		if [[ -L "${f}" ]] ; then
			dogamesbin "${f}" || die "dogamesbin failed"
		fi
	done

	insinto "${GAMES_DATADIR}/advance"
	doins support/event.dat
	keepdir "${GAMES_DATADIR}/advance/"{artwork,diff,image,rom,sample,snap}

	dodoc HISTORY README RELEASE
	cd doc
	dodoc *.txt
	dohtml *.html
	for f in *.1 ; do
		newman ${f} ${f/1/6}
	done

	prepgamesdirs
}
