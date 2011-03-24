# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.80-r1.ebuild,v 1.7 2011/03/24 07:21:32 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A heavily multi-threaded pluggable audio player."
HOMEPAGE="http://www.alsaplayer.org"
SRC_URI="http://www.${PN}.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ~ppc ~sparc x86"
IUSE="alsa audiofile doc esd flac gtk id3tag jack mad nas nls ogg opengl oss vorbis xosd"
# mikmod is disabled wrt #279344

RDEPEND="media-libs/libsndfile
	mad? ( media-libs/libmad )
	id3tag? ( media-libs/libid3tag )
	gtk? ( >=x11-libs/gtk+-2.8:2 )
	alsa? ( media-libs/alsa-lib )
	audiofile? ( media-libs/audiofile )
	esd? ( media-sound/esound )
	flac? ( media-libs/flac )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80 )
	nas? ( media-libs/nas )
	ogg? ( media-libs/libogg )
	opengl? ( virtual/opengl )
	vorbis? ( media-libs/libvorbis )
	xosd? ( x11-libs/xosd )"
# media-libs/libmikmod
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}"/${P}_rc3-flags.patch \
		"${FILESDIR}"/${P}-missing_limits_h.patch \
		"${FILESDIR}"/${P}-enable-libid3tag.patch \
		"${FILESDIR}"/${P}-glibc-2.10.patch
	eautoreconf
}

src_configure() {
	use xosd || export ac_cv_lib_xosd_xosd_create="no"
	use doc || export ac_cv_prog_HAVE_DOXYGEN="false"

	local myconf

	if ! use alsa && ! use oss && ! use esd && ! use jack && ! use nas; then
		ewarn "You've disabled alsa, oss, esd, jack and nas. Enabling oss for you."
		myconf="${myconf} --enable-oss"
	fi

	econf --disable-sgi \
		$(use_enable audiofile) \
		$(use_enable esd) \
		$(use_enable flac) \
		$(use_enable gtk gtk2) \
		$(use_enable id3tag) \
		$(use_enable jack) \
		--disable-mikmod \
		$(use_enable nas) \
		$(use_enable opengl) \
		$(use_enable oss) \
		$(use_enable vorbis oggvorbis) \
		$(use_enable alsa) \
		$(use_enable nls) \
		$(use_enable mad) \
		--disable-dependency-tracking \
		${myconf}
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" docdir="${D}/usr/share/doc/${PF}" install \
		|| die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO docs/*.txt
	newicon interface/gtk2/pixmaps/logo.xpm ${PN}.xpm
}
