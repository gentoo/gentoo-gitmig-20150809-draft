# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.6-r1.ebuild,v 1.4 2003/10/30 05:04:06 vapier Exp $

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org/"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc ~sparc ~hppa ~amd64"
IUSE="oss alsa esd arts nas X dga xv xinerama fbcon directfb ggi svga aalib opengl noaudio novideo nojoystick"
# if you disable audio/video/joystick and something breaks, you pick up the pieces

RDEPEND=">=media-libs/audiofile-0.1.9
	alsa? ( media-libs/alsa-lib )
	esd? ( >=media-sound/esound-0.2.19 )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas )
	X? ( >=x11-base/xfree-4.3.0 )
	directfb? ( >=dev-libs/DirectFB-0.9.19 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	svga? ( >=media-libs/svgalib-1.4.2 )
	aalib? ( media-libs/aalib )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/SDL-${PV}

src_compile() {
	sed -i 's:head -1:head -n 1:' configure

	local myconf=""
	[ `use noaudio` ] && myconf="${myconf} --disable-audio"
	[ `use novideo` ] \
		&& myconf="${myconf} --disable-video" \
		|| myconf="${myconf} --enable-video-dummy"
	[ `use nojoystick` ] && myconf="${myconf} --disable-joystick"

	econf \
		--enable-events \
		--enable-cdrom \
		--enable-threads \
		--enable-timers \
		--enable-endian \
		--enable-file \
		`use_enable oss` \
		`use_enable alsa` \
		`use_enable esd` \
		`use_enable arts` \
		`use_enable nas` \
		`use_enable x86 nasm` \
		`use_enable X video-x11` \
		`use_enable dga` \
		`use_enable xv video-x11-xv` \
		`use_enable xinerama video-x11-xinerama` \
		`use_enable dga video-dga` \
		`use_enable fbcon video-fbcon` \
		`use_enable directfb video-directfb` \
		`use_enable ggi video-ggi` \
		`use_enable svga video-svga` \
		`use_enable aalib video-aalib` \
		`use_enable opengl video-opengl` \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	preplib
	dodoc BUGS CREDITS README README-SDL.txt README.CVS TODO WhatsNew
	dohtml -r ./
}
