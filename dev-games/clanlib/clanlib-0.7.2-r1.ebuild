# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/clanlib/clanlib-0.7.2-r1.ebuild,v 1.1 2003/07/17 00:12:58 vapier Exp $

inherit flag-o-matic
replace-flags -O? -O2

DESCRIPTION="multi-platform game development library"
SRC_URI="http://www.clanlib.org/~sphair/download/ClanLib-${PV}-1.tar.bz2"
HOMEPAGE="http://www.clanlib.org/"

LICENSE="LGPL-2"
SLOT="0.7"
KEYWORDS="~x86"
IUSE="arts oss esd alsa png opengl truetype X oggvorbis mikmod jpeg directfb joystick"

DEPEND=">=media-libs/hermes-1.3.2
	X? ( virtual/x11 )
	png? ( media-libs/libpng )
	jpeg? ( >=media-libs/jpeg-6b )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	truetype? ( >=media-libs/freetype-2.0 )
	directfb? ( dev-libs/DirectFB )
	oggvorbis? ( media-libs/libvorbis )"

S=${WORKDIR}/ClanLib-${PV}

src_compile() {
	local myconf=""
	use jpeg || myconf="${myconf} --enable-smalljpeg"
	use alsa || use oss || use esd || use arts \
		&& myconf="${myconf} --enable-clansound" \
		|| myconf="${myconf} --disable-clansound"

	WANT_AUTOMAKE=1.6 ./autogen.sh

	econf \
		--libdir=/usr/lib/${P} \
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
		`use_enable joystick` \
		--enable-vidmode \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	mv ${D}/usr/include/{ClanLib,${P}}
	dobin ${FILESDIR}/clanlib-config
	dodoc BUGS CODING_STYLE CREDITS NEWS PATCHES PORTING README*
	dohtml -r Documentation/*
}

pkg_postinst() {
	clanlib-config ${PV}
}
