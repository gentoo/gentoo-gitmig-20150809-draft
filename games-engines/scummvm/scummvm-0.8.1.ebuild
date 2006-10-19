# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/scummvm/scummvm-0.8.1.ebuild,v 1.3 2006/10/19 18:56:45 flameeyes Exp $

inherit eutils games

DESCRIPTION="Reimplementation of the SCUMM game engine used in Lucasarts adventures"
HOMEPAGE="http://scummvm.sourceforge.net/"
SRC_URI="mirror://sourceforge/scummvm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="alsa debug flac mp3 ogg vorbis zlib"
RESTRICT="test"  # it only looks like there's a test there #77507

RDEPEND=">=media-libs/libsdl-1.2.2
	>media-libs/libmpeg2-0.3.1
	ogg? ( media-libs/libogg media-libs/libvorbis )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	mp3? ( media-libs/libmad )
	flac? ( ~media-libs/flac-1.1.2 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.patch
	if use x86 ; then
		local f
		for f in common/scaler/{hq3x_i386.asm,hq2x_i386.asm}
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

	(use vorbis || use ogg) \
		&& myconf="${myconf} --enable-vorbis" \
		|| myconf="${myconf} --disable-vorbis --disable-mpeg2"

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
	doman scummvm.6
	dodoc NEWS README TODO
	doicon scummvm.xpm
	make_desktop_entry scummvm ScummVM
	prepgamesdirs
}
