# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.28.ebuild,v 1.4 2004/03/21 09:40:34 mholzer Exp $

inherit flag-o-matic
replace-flags -march=pentium4 -march=pentium3

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
SRC_URI="http://download.blender.org/source/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2 | BL"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/x11
	blender-game? ( dev-games/ode )
	sdl? ( media-libs/libsdl )
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	mozilla? ( net-www/mozilla )
	truetype? ( >=media-libs/freetype-2.0 )
	fmod? ( media-libs/fmod )
	>=media-libs/openal-20020127
	>=media-libs/libsdl-1.2
	>=media-libs/libvorbis-1.0
	>=dev-libs/openssl-0.9.6"

src_compile() {
	local myconf=""

	# SDL Support
	if [ -n "`use sdl`" ]
	then
		myconf="${myconf} --with-sdl=/usr"
	fi

	# JPG Support (Should be there by default, but I'll put it in anyways)
	if [ -n "`use jpeg`" ]
	then
		myconf="${myconf} --with-libjpeg=/usr"
	fi

	# PNG Support (Same as above)
	if [ -n "`use png`" ]
	then
		myconf="${myconf} --with-libpng=/usr"
	fi

	# ./configure points at the wrong mozilla directories and will fail
	# with this enabled. (A simple patch should take care of this)
	#if [ -n "`use mozilla`" ]
	#then
	#	myconf="${myconf} --with-mozilla=/usr"
	#fi

	# TrueType support (For text objects)
	if [ -n "`use truetype`" ]
	then
		myconf="${myconf} --with-freetype2=/usr"
	fi

	# Build Staticly
	if [ -n "`use blender-static`" ]
	then
		myconf="${myconf} --enable-blenderstatic"
	fi

	# Build the game engine (Fails in 2.28)
	if [ -n "`use blender-game`" ]
	then
		myconf="${myconf} --enable-gameblender"
	fi

	# Build the plugin (Will probably fail, especially without mozilla)
	if [ -n "`use blender-plugin`" ]
	then
		myconf="${myconf} --enable-blenderplugin"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
}
