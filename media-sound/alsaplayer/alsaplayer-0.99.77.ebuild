# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.77.ebuild,v 1.1 2007/02/13 07:28:27 dirtyepic Exp $

inherit eutils autotools

DESCRIPTION="A heavily multi-threaded pluggable audio player."
HOMEPAGE="http://www.alsaplayer.org/"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa audiofile doc esd flac gtk jack mikmod nas nls ogg opengl oss vorbis xosd"

RDEPEND="
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	audiofile? ( media-libs/audiofile )
	esd? ( media-sound/esound )
	flac? ( media-libs/flac )
	gtk? ( >=x11-libs/gtk+-2.6 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80.0 )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	nas? ( media-libs/nas )
	ogg? ( media-libs/libogg )
	opengl? ( virtual/opengl )
	vorbis? ( media-libs/libvorbis )
	xosd? ( x11-libs/xosd )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/${P}-ppc-endian-fix.patch
	epatch "${FILESDIR}"/${P}-join-null-thread.patch
	epatch "${FILESDIR}"/${P}-cxxflags.patch

	eautoreconf
}

src_compile() {
	use xosd ||
		export ac_cv_lib_xosd_xosd_create="no"

	use doc ||
		export ac_cv_prog_HAVE_DOXYGEN="false"

	if use ogg && use flac; then
		myconf="${myconf} --enable-oggflac"
	fi

	econf \
		$(use_enable audiofile) \
		$(use_enable esd) \
		$(use_enable flac) \
		$(use_enable gtk gtk2) \
		$(use_enable jack) \
		$(use_enable mikmod) \
		$(use_enable nas) \
		$(use_enable opengl) \
		$(use_enable oss) \
		$(use_enable nls) \
		$(use_enable sparc) \
		$(use_enable vorbis oggvorbis) \
		${myconf} \
		--disable-gtk \
		--disable-sgi \
		--disable-dependency-tracking \
		|| die "econf failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" docdir="${D}/usr/share/doc/${PF}" install \
		|| die "make install failed"

	dodoc AUTHORS ChangeLog README TODO
	dodoc docs/wishlist.txt
}
