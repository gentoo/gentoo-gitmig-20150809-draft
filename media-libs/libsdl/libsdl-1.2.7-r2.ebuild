# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsdl/libsdl-1.2.7-r2.ebuild,v 1.2 2004/07/25 19:04:41 plasmaroo Exp $

inherit fixheadtails eutils

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="http://www.libsdl.org/"
SRC_URI="http://www.libsdl.org/release/SDL-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="oss alsa esd arts nas X dga xv xinerama fbcon directfb ggi svga aalib opengl libcaca noaudio novideo nojoystick"
# if you disable audio/video/joystick and something breaks, you pick up the pieces

RDEPEND=">=media-libs/audiofile-0.1.9
	alsa? ( media-libs/alsa-lib )
	esd? ( >=media-sound/esound-0.2.19 )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas virtual/x11 )
	X? ( virtual/x11 )
	directfb? ( >=dev-libs/DirectFB-0.9.19 )
	ggi? ( >=media-libs/libggi-2.0_beta3 )
	svga? ( >=media-libs/svgalib-1.4.2 )
	aalib? ( media-libs/aalib )
	libcaca? ( media-libs/libcaca )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/SDL-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-nobuggy-X.patch #30089
	epatch ${FILESDIR}/${PV}-libcaca.patch #40224
	epatch ${FILESDIR}/${PV}-gcc34.patch #48947
	epatch ${FILESDIR}/${PV}-joystick2.patch #52833
	epatch ${FILESDIR}/${PV}-26headers.patch #58192

	ht_fix_file configure.in

	if use nas && ! use X ; then #32447
		sed -i \
			-e 's:-laudio:-laudio -L/usr/X11R6/lib:' \
			configure.in || die "nas sed hack failed"
	fi

	./autogen.sh || die "autogen failed"
}

src_compile() {
	local myconf=""
	use noaudio && myconf="${myconf} --disable-audio"
	use novideo \
		&& myconf="${myconf} --disable-video" \
		|| myconf="${myconf} --enable-video-dummy"
	use nojoystick && myconf="${myconf} --disable-joystick"

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
		`use_enable libcaca video-caca` \
		`use_enable opengl video-opengl` \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	preplib
	dosed "s:-pthread::g" /usr/lib/libSDL.la # Bug 34804
	dodoc BUGS CREDITS README README-SDL.txt README.CVS TODO WhatsNew
	dohtml -r ./
}
