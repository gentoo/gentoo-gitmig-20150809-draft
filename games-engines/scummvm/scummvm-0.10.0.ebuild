# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm/scummvm-0.10.0.ebuild,v 1.2 2007/07/05 20:00:02 corsair Exp $

inherit eutils games

DESCRIPTION="Reimplementation of the SCUMM game engine used in Lucasarts adventures"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa debug flac fluidsynth mp3 ogg vorbis zlib"
RESTRICT="test"  # it only looks like there's a test there #77507

RDEPEND=">=media-libs/libsdl-1.2.2
	>media-libs/libmpeg2-0.3.1
	ogg? ( media-libs/libogg media-libs/libvorbis )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	mp3? ( media-libs/libmad )
	flac? ( media-libs/flac )
	fluidsynth? ( media-sound/fluidsynth )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if use x86 ; then
		local f
		for f in graphics/scaler/{hq3x_i386.asm,hq2x_i386.asm}
		do
		cat >> $f <<EOF
		%ifidn __OUTPUT_FORMAT__,elf
		section .note.GNU-stack noalloc noexec nowrite progbits
		%endif
EOF
		done
	fi
}

src_compile() {
	local myconf="--backend=sdl" # x11 backend no worky (bug #83502)

	# let the engine find its data files in the right place (bug #178116)
	myconf="${myconf} --datadir=${GAMES_DATADIR}"

	( use vorbis || use ogg ) \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis --disable-mpeg2"

	# bug #137547
	use fluidsynth || myconf="${myconf} --disable-fluidsynth"

	# NOT AN AUTOCONF SCRIPT SO DONT CALL ECONF
	# mpeg2 support needs vorbis (bug #79149) so turn it off if -oggvorbis
	./configure \
		$(use_enable debug) \
		$(use_enable alsa) \
		$(use_enable mp3 mad) \
		$(use_enable flac) \
		$(use_enable zlib) \
		$(use_enable x86 nasm) \
		${myconf} \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin scummvm || die "dobin failed"
	doman dists/scummvm.6
	dodoc AUTHORS NEWS README TODO
	insinto "${GAMES_DATADIR}"/${PN}/engines
	doins gui/themes/modern.*
	doicon icons/scummvm.xpm
	make_desktop_entry scummvm ScummVM scummvm.xpm "Game;AdventureGame"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "If you want to use the new \"modern\" theme for ${PN},"
	elog "add the following line to the [scummvm] section of"
	elog "your ~/.scummvmrc file (after running scummvm once):"
	elog "themepath=${GAMES_DATADIR}/${PN}/engines/"
}
