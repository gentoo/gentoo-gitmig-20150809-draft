# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.34_rc1-r1.ebuild,v 1.3 2005/04/15 14:45:43 luckyduck Exp $

inherit eutils flag-o-matic

MY_P="${P/_rc/-test}"
DESCRIPTION="Great Video editing/encoding tool"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://download.berlios.de/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="a52 aac alsa altivec arts debug encode mad mmx nls oggvorbis sdl truetype xvid xv"

RDEPEND="virtual/x11
	a52? ( >=media-libs/a52dec-0.7.4 )
	encode? ( >=media-sound/lame-3.93 )
	>=dev-libs/libxml2-2.6.7
	>=x11-libs/gtk+-2.4.1
	aac? ( >=media-libs/faac-1.23.5
	       >=media-libs/faad2-2.0-r2 )
	mad? ( media-libs/libmad )
	xvid? ( >=media-libs/xvid-1.0.0 )
	x86? ( dev-lang/nasm )
	nls? ( >=sys-devel/gettext-0.12.1 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0.1 )
	arts? ( >=kde-base/arts-1.2.3 )
	truetype? ( >=media-libs/freetype-2.1.5 )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	sdl? ( media-libs/libsdl )"
# media-sound/toolame is supported as well

DEPEND="$RDEPEND >=sys-devel/autoconf-2.58
		>=sys-devel/automake-1.8.3"

filter-flags "-fno-default-inline"
filter-flags "-funroll-loops"
filter-flags "-funroll-all-loops"
filter-flags "-fforce-addr"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S} || die
	cd ${S}/avidemux/ADM_audiofilter
	epatch ${FILESDIR}/avidemux-2.0.34-test1_faac.patch
	cd ${S}
}

src_compile() {
	local myconf
	myconf="--with-gnu-ld --disable-warnings"

	# --enable-profile        creates profiling infos default=no
	# --enable-pch            enables precompiled header support
	#                         (currently only KCC) default=no
	# --enable-final          build size optimized apps
	#                         (experimental - needs lots of memory)
	# --disable-closure       don't delay template instantiation

	use debug && myconf="${myconf} --enable-debug=full"
	use aac || myconf="${myconf} --disable-faac --disable-faad"

	use a52 || export ac_cv_header_a52dec_a52=no
	use alsa || export ac_cv_header_alsa_asoundlib_h=no
	use arts || export ac_cv_path_ART_CONFIG=no
	use encode || export ac_cv_header_lame_lame_h=no
	use mad || export ac_cv_header_mad_h=no
	use oggvorbis || export ac_cv_lib_vorbis_vorbis_info_init=no
	use sdl || export ac_cv_path_SDL_CONFIG=no
	use truetype || export ac_cv_path_FREETYPE_CONFIG=no
	use xv || export ac_cv_header_X11_extensions_XShm_h=no
	use xvid || export ac_cv_header_xvid_h=no

	econf \
		$(use_enable nls) \
		$(use_enalbe altivec) \
		$(use_enable mmx) \
		${myconf} || die "configure failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog History README TODO
}

pkg_postinst() {
	if use ppc ; then
		echo
		einfo "OSS sound output may not work on ppc"
		einfo "If your hear only static noise, try"
		einfo "changing the sound device to ALSA or arts"
	fi
}
