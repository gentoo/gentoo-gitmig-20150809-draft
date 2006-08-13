# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mmsv2/mmsv2-1.0.8_rc1.ebuild,v 1.2 2006/08/13 16:00:13 arj Exp $

inherit eutils

DESCRIPTION="Menu system for easy movie and audio playback and image viewing."
HOMEPAGE="http://mms.sunsite.dk/"

MY_P="${P/-1.0.8_rc/-1.0.8-rc}"

SRC_URI="http://mms.sunsite.dk/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug lirc svga sdl dvb xine dxr3"

RDEPEND="media-libs/imlib2
	x11-libs/libXScrnSaver
	media-libs/taglib
	>=dev-libs/libpcre-4.3
	=dev-db/sqlite-2*
	media-tv/xmltv
	lirc? ( app-misc/lirc )
	svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )
	dxr3? ( media-video/em8300-libraries )
	xine? ( media-libs/xine-lib
			media-video/cxfe )
	!xine? ( media-sound/alsaplayer
			media-video/mplayer
			media-video/dxr3player )"

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

S="${WORKDIR}/mmsv2-1.0.8-rc1"

src_compile() {

	local myconf=

	( use debug ) \
		&& myconf="${myconf} --enable-debug"

	( use lirc ) \
		&& myconf="${myconf} --enable-lirc"

	( use svga ) \
		&& myconf="${myconf} --enable-vgagl"

	( ! use sdl ) \
		&& myconf="${myconf} --disable-sdl"

	( use dxr3 ) \
		&& myconf="${myconf} --enable-dxr3"

	( use dvb ) \
		&& myconf="${myconf} --enable-dvb"

	( use xine ) \
		&& myconf="${myconf} --enable-xine-audio"

	cd ${S}

	./configure --prefix=/usr \
		${myconf} || die

	emake -j1 || die
}

src_install() {
	cd ${S}

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
	einfo
	einfo "Documentation is available online: http://mms.sunsite.dk/doc/index.html"
}
