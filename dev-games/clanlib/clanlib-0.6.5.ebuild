# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/clanlib/clanlib-0.6.5.ebuild,v 1.3 2003/09/05 11:57:11 msterret Exp $

inherit eutils

DESCRIPTION="multi-platform game development library"
HOMEPAGE="http://www.clanlib.org/"
SRC_URI="http://www.clanlib.org/download/files/ClanLib-${PV}-1.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="arts oss esd alsa png opengl truetype X oggvorbis mikmod jpeg directfb"

DEPEND=">=media-libs/hermes-1.3.2
	X? ( virtual/x11 )
	png? ( media-libs/libpng )
	jpeg? ( >=media-libs/jpeg-6b )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	truetype? ( >=media-libs/freetype-2.0 )
	directfb? ( dev-libs/DirectFB )
	oggvorbis? ( media-libs/libvorbis )"

S=${WORKDIR}/ClanLib-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	local myconf="`use_enable jpeg`"

	use jpeg || myconf="${myconf} --enable-smalljpeg"

	use alsa || use oss || use esd || use arts \
		&& myconf="${myconf} --enable-clansound" \
		|| myconf="${myconf} --disable-clansound"

	# this is not a USE flag yet, but there should be one
	# use joystick \
	#	&& myconf="${myconf} --enable-joystick" \
	#	|| myconf="${myconf} --disable-joystick"

	export CFLAGS=${CFLAGS/-O?/-O2}
	export CXXFLAGS=${CXXFLAGS/-O?/-O2}

	./autogen.sh

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--enable-joystick \
		--enable-network \
		--enable-asm386 \
		--enable-dyn \
		`use_enable X x11` \
		`use_enable directfb` \
		`use_enable opengl` \
		`use_enable oggvorbis vorbis` \
		`use_enable png` \
		`use_enable truetype ttf` \
		`use_enable mikmod` \
		--enable-vidmode \
		${myconf} || die

	emake || die
}

src_install() {
	make prefix=${D}/usr install || die
}
