# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gephex/gephex-0.4.3.ebuild,v 1.9 2006/10/16 19:50:24 hd_brummy Exp $

inherit eutils

DESCRIPTION="GePhex is a modular video effect framework."
HOMEPAGE="http://www.gephex.org"
MY_P=${P}b
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

IUSE="aalib alsa ffmpeg joystick mmx mpeg opengl oss png sdl static v4l"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"

DEPEND="virtual/x11
	=x11-libs/qt-3*
	sdl? ( >=media-libs/libsdl-1.2.6-r3 )
	sdl? ( >=media-libs/sdl-image-1.2.3 )
	png? ( >=media-libs/libpng-1.2.5-r4 )
	sdl? ( >=media-libs/sdl-ttf-2.0.6 )
	alsa? ( >=media-libs/alsa-lib-0.9.8 )
	aalib?	( >=media-libs/aalib-1.4_rc4-r2 )
	opengl? ( virtual/opengl )"

RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A} || die
	cd ${S}
	
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {

	# qt wants to create lock files etc. in that directory
	addwrite "${QTDIR}/etc/settings"

	local myconf
	econf \
	`use_enable mmx` \
	`use_enable static` \
	`use_with aalib AALIB` \
	`use_with ffmpeg FFMPEG` \
	`use_with alsa ASOUNDLIB` \
	`use_with oss OSS` \
	`use_with v4l V4L` \
	`use_with joystick LINUX_JOYSTICK` \
	`use_with opengl GL` \
	`use_with sdl SDL` \
	`use_with png LIBPNG` \
	`use_with mpeg MPEG3` \
	${myconf} \
	|| die
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	einfo "Please read /usr/share/doc/gephex/html/documentation.html to get started."
}
