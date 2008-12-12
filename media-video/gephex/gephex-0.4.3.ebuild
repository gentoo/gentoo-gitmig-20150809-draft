# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gephex/gephex-0.4.3.ebuild,v 1.13 2008/12/12 16:20:30 ssuominen Exp $

inherit eutils

DESCRIPTION="GePhex is a modular video effect framework."
HOMEPAGE="http://www.gephex.org"
MY_P=${P}b
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

IUSE="aalib alsa joystick mmx mpeg opengl oss png sdl v4l"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"

DEPEND="=x11-libs/qt-3*
	sdl? ( >=media-libs/libsdl-1.2.6-r3
		>=media-libs/sdl-image-1.2.3
		>=media-libs/sdl-ttf-2.0.6 )
	png? ( >=media-libs/libpng-1.2.5-r4 )
	alsa? ( >=media-libs/alsa-lib-0.9.8 )
	aalib?	( >=media-libs/aalib-1.4_rc4-r2 )
	opengl? ( virtual/opengl )
	x11-libs/libXv"

src_unpack() {
	unpack ${A} || die
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	# qt wants to create lock files etc. in that directory
	addwrite "${QTDIR}/etc/settings"

	local myconf
	econf \
	`use_enable mmx` \
	`use_with aalib AALIB` \
	--without-FFMPEG \
	`use_with alsa ASOUNDLIB` \
	`use_with oss OSS` \
	`use_with v4l V4L` \
	`use_with joystick LINUX_JOYSTICK` \
	`use_with opengl GL` \
	`use_with sdl SDL` \
	`use_with png LIBPNG` \
	`use_with mpeg MPEG3` \
	${myconf} || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "Please read /usr/share/doc/gephex/html/documentation.html to get started."
}
