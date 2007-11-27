# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.3.0.ebuild,v 1.10 2007/11/27 11:57:23 zzam Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils flag-o-matic subversion autotools

MY_P=${PN}_${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="a52 aac alsa altivec arts encode esd mad nls vorbis sdl truetype x264 xvid xv oss"

RDEPEND="
	>=x11-libs/gtk+-2.6
	>=dev-libs/libxml2-2.6.7
	>=dev-lang/spidermonkey-1.5-r2
	>=media-sound/twolame-0.3.6
	a52? ( >=media-libs/a52dec-0.7.4 )
	encode? ( >=media-sound/lame-3.93 )
	aac? ( >=media-libs/faac-1.23.5
	       >=media-libs/faad2-2.0-r7 )
	esd? ( media-sound/esound )
	mad? ( media-libs/libmad )
	xvid? ( >=media-libs/xvid-1.0.0 )
	x264? ( media-libs/x264-svn )
	nls? ( >=sys-devel/gettext-0.12.1 )
	vorbis? ( >=media-libs/libvorbis-1.0.1 )
	arts? ( >=kde-base/arts-1.2.3 )
	truetype? ( >=media-libs/freetype-2.1.5 )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	sdl? ( media-libs/libsdl )
	xv? ( x11-libs/libXv )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender"

DEPEND="$RDEPEND
	x11-base/xorg-server
	x11-libs/libXt
	x11-proto/xextproto
	dev-util/pkgconfig"

pkg_setup() {
	filter-flags "-fno-default-inline"
	filter-flags "-funroll-loops"
	filter-flags "-funroll-all-loops"
	filter-flags "-fforce-addr"

	if ! built_with_use dev-lang/spidermonkey threadsafe; then
		eerror "dev-lang/spidermonkey is missing threadsafe support, please"
		eerror "enable the threadsafe USE flag and re-emerge"
		eerror "dev-lang/spidermonkey - this avidemux build will not compile"
		eerror "nor work without it!"
		die "dev-lang/spidermonkey needs threadsafe support"
	fi

	if ! ( use oss || use arts || use alsa ); then
		eerror "You must select at least one between oss, arts and alsa audio output."
		die "Fix USE flags"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-dts.patch"
	epatch "${FILESDIR}/${P}-configure.patch"
	epatch "${FILESDIR}/${P}-po.makefile.patch"
	epatch "${FILESDIR}/${P}-amprogas.patch"
	epatch "${FILESDIR}/${P}-twolame.patch"

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable altivec) \
		$(use_enable xv) \
		$(use_with arts) \
		$(use_with alsa) \
		$(use_with esd) \
		$(use_with oss) \
		$(use_with vorbis) \
		$(use_with sdl libsdl) \
		$(use_with truetype freetype2) \
		$(use_with aac faac) $(use_with aac faad2) \
		$(use_with encode lame) \
		--with-extern-twolame \
		--with-newfaad --with-jsapi-include=/usr/include/js \
		--disable-warnings --disable-dependency-tracking \
		${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog History README TODO
	insinto /usr/share/pixmaps
	newins "${S}"/avidemux_icon.png avidemux.png
	make_desktop_entry avidemux2 "Avidemux2" avidemux.png
}

pkg_postinst() {
	if use ppc && use oss; then
		elog ""
		elog "OSS sound output may not work on ppc"
		elog "If your hear only static noise, try"
		elog "changing the sound device to ALSA or arts"
	fi
}
