# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mmsv2/mmsv2-1.0.1.ebuild,v 1.1 2005/03/28 18:39:28 arj Exp $

inherit eutils

DESCRIPTION="Menu system for easy movie and audio playback and image viewing."
HOMEPAGE="http://mms.sunsite.dk/"

SRC_URI="http://mms.sunsite.dk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug lirc svga sdl dvb xine"

RDEPEND="media-libs/imlib2
	media-libs/taglib
	>=dev-libs/libpcre-4.3
	=dev-db/sqlite-2*
	media-tv/xmltv
	lirc? ( app-misc/lirc )
	svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )
	xine? ( media-libs/xine-lib
			media-video/cxfe )
	!xine? ( media-sound/alsaplayer
			media-video/mplayer
			media-video/dxr3player )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

src_compile() {

	local myconf=

	( use debug ) \
		&& myconf="${myconf} --enable-debug"

	( use lirc ) \
		|| myconf="${myconf} --disable-lirc"

	( use svga ) \
		&& myconf="${myconf} --enable-vgagl"

	( use sdl ) \
		&& myconf="${myconf} --enable-sdl"

	( use dvb ) \
		&& myconf="${myconf} --enable-dvb"

	( use xine ) \
		&& myconf="${myconf} --enable-xine-audio"

	if ! [ -e /usr/include/linux/em8300.h ]
	then
		myconf="${myconf} --disable-dxr3"
	fi

	./configure --prefix=/usr \
		--enable-fancy-audio \
		--enable-fancy-movie \
		--use-tags \
		${myconf} || die

	emake -j1 || die
}

src_install() {
	make PREFIX=${D}/usr \
	     BINDIR=${D}/usr/bin \
	     CONFIGDIR=${D}/etc/mms \
	     DATADIR=${D}/usr/share/mms \
	     install || die "Failed to install mmsv2!"

	dodoc doc/BUGS doc/Changelog doc/LICENSE doc/README doc/TODO
}

pkg_postinst() {
	einfo "Be sure to change /etc/mms/config and /etc/mms/input* to your needs"
	einfo "You also need to place a TV.xml file in /etc/mms for epg to work"
	einfo ""
	einfo "Documentation is available online: http://mms.sunsite.dk/doc/index.html"
}
