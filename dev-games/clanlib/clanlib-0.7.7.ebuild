# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/clanlib/clanlib-0.7.7.ebuild,v 1.5 2004/02/12 06:58:13 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="multi-platform game development library"
HOMEPAGE="http://www.clanlib.org/"
SRC_URI="http://www.clanlib.org/~sphair/download/ClanLib-${PV}-1.tar.bz2"

LICENSE="LGPL-2"
SLOT="0.7"
KEYWORDS="x86 ppc"
IUSE="opengl X sdl oggvorbis doc mikmod clanVoice clanJavaScript ipv6"

DEPEND=">=media-libs/hermes-1.3.2
	media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl )
	X? ( virtual/x11 )
	mikmod? ( >=media-libs/libmikmod-3.1.9 )
	oggvorbis? ( media-libs/libvorbis )"

S=${WORKDIR}/ClanLib-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -name .cvsignore -exec rm -f \{\} \;
	epatch ${FILESDIR}/${PV}-port.patch
	epatch ${FILESDIR}/${PV}-gl-prototype.patch
}

src_compile() {
	#clanSound only controls mikmod/vorbis so theres
	# no need to pass --{en,dis}able-clanSound ...
	#clanDisplay only controls X, SDL, OpenGL plugins
	# so no need to pass --{en,dis}able-clanDisplay
	# also same reason why we dont have to use clanGUI
	[ `use doc` ] || sed -i '/^SUBDIRS/s:Documentation::' Makefile.in
	econf \
		--libdir=/usr/lib/${P} \
		`use_enable x86 asm386` \
		`use_enable doc docs` \
		--enable-dyn \
		`use_enable clanVoice` \
		`use_enable clanJavaScript` \
		--enable-clanNetwork \
		`use_enable opengl clanGL` \
		`use_enable sdl clanSDL` \
		`use_enable oggvorbis clanVorbis` \
		`use_enable mikmod clanMikMod` \
		`use_enable ipv6 getaddr` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	if use doc ; then
		dodir /usr/share/doc/${PF}/html
		mv ${D}/usr/share/doc/clanlib/* ${D}/usr/share/doc/${PF}/html/
		rm -rf ${D}/usr/share/doc/clanlib
		cp -r Examples ${D}/usr/share/doc/${PF}/
	fi
	mv ${D}/usr/include/{ClanLib-*/ClanLib,${P}}
	rm -rf ${D}/usr/include/ClanLib-*
	dobin ${FILESDIR}/clanlib-config
	dodoc CODING_STYLE CREDITS NEWS PATCHES README* INSTALL.linux
}

pkg_postinst() {
	clanlib-config ${PV}
}
