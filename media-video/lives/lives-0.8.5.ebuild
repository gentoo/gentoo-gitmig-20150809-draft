# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lives/lives-0.8.5.ebuild,v 1.4 2005/01/15 22:58:24 luckyduck Exp $

DESCRIPTION="Linux Video Editing System"

HOMEPAGE="http://www.xs4all.nl/~salsaman/lives"

MY_PN=LiVES
MY_P=${MY_PN}-${PV}

SRC_URI="http://www.xs4all.nl/~salsaman/lives/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="xmms"

DEPEND=">=media-video/mplayer-0.90-r2
		>=media-gfx/imagemagick-5.5.6
		>=dev-lang/perl-5.8.0-r12
		>=x11-libs/gtk+-2.2.1
		media-libs/gdk-pixbuf
		media-libs/libsdl
		>=media-libs/jpeg-6b-r3
		>=media-sound/sox-12.17.3-r3
		xmms? ( >=media-sound/xmms-1.2.7-r20 )
		virtual/cdrtools"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	tar -xzf ${S}/lives-plugins-${PV}.tar.gz
	tar -xzf ${S}/lives-themes-${PV}.tar.gz
}

src_compile() {
		econf || die
		emake || die
		cd src-plugins
		gcc ${CFLAGS} `pkg-config gtk+-2.0 --cflags` `sdl-config --cflags` SDL.c \
			${LDFLAGS} `pkg-config gtk+-2.0 --libs` `sdl-config --libs` --shared \
			-fPIC -o SDL || die "SDL plugin not built"

}

src_install() {
		einstall || die
		insinto /usr/bin
		dobin ${S}/smogrify || die
		dobin ${S}/midistart || die
		dobin ${S}/midistop || die
		dodoc AUTHORS CHANGELOG FEATURES GETTING.STARTED
		dodir /usr/share/lives/plugins/
		cp -R  ${WORKDIR}/plugins ${D}/usr/share/lives/
		cp ${S}/src-plugins/SDL ${D}/usr/share/lives/plugins/playback/video/
		cp -R ${WORKDIR}/icons ${D}/usr/share/lives/
		cp -R ${WORKDIR}/themes ${D}/usr/share/lives/
}
