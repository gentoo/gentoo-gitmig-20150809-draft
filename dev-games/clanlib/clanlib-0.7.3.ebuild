# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/clanlib/clanlib-0.7.3.ebuild,v 1.1 2003/09/07 14:24:33 karltk Exp $

inherit flag-o-matic
replace-flags -O? -O2

DESCRIPTION="multi-platform game development library"
HOMEPAGE="http://www.clanlib.org/"
SRC_URI="http://www.clanlib.org/~sphair/download/ClanLib-${PV}-3.tar.bz2"

LICENSE="LGPL-2"
# 2003-09-07: karltk
# NOTE! According to the ClanLib developers, 0.<odd> are always unstable, 
# so we must  slot major.minor.patch
SLOT="0.7.3" 
KEYWORDS="~x86"
IUSE="arts oss esd alsa png opengl truetype X oggvorbis mikmod jpeg directfb joystick"

DEPEND=">=media-libs/hermes-1.3.2
	media-libs/libpng
	>=media-libs/jpeg-6b
	|| ( 
		opengl? ( virtual/opengl ) 
		>=media-libs/libsdl-1.2.5 
	)
	X? ( virtual/x11 )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	truetype? ( >=media-libs/freetype-2.0 )
	directfb? ( dev-libs/DirectFB )
	oggvorbis? ( media-libs/libvorbis )"


S=${WORKDIR}/ClanLib-${PV}

src_compile() {
	local myconf=""

	use alsa || use oss || use esd || use arts \
		&& myconf="${myconf} --enable-clanSound" \
		|| myconf="${myconf} --disable-clanSound"
	use opengl && myconf="${myconf} --enable-clanGL --disable-clanSDL" \
		|| myconf="${myconf} --enable-clanSDL --disable-clanGL"

	WANT_AUTOMAKE=1.6 ./autogen.sh

	econf \
		--libdir=/usr/lib/${P} \
		--enable-network \
		--enable-asm386 \
		--enable-dyn \
		--disable-clanVoice \
		--disable-clanJavaScript \
		--enable-clanDisplay \
		--enable-clanNetwork \
                --enable-clanGUI \
		`use_enable X x11` \
		`use_enable directfb` \
		`use_enable oggvorbis clanVorbis` \
		`use_enable mikmod clanMikMod` \
		`use_enable joystick` \
		--enable-vidmode \
		--enable-getaddr \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/clanlib/* ${D}/usr/share/doc/${PF}/html
	rm -rf ${D}/usr/share/doc/clanlib
	mv ${D}/usr/include/{ClanLib,${PF}}
	dodoc CODING_STYLE CREDITS NEWS PATCHES README* INSTALL.*
	dosym /usr/include/${PF} /usr/include/ClanLib
	dodir /usr/bin
	echo ${FILESDIR}/clanlib-config-0.7.in | sed "s/@VERSION@/${PF}/" \
		> ${D}/usr/bin/clanlib-config
}
