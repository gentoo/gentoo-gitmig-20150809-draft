# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.80_rc4.ebuild,v 1.1 2007/10/10 17:06:54 drac Exp $

inherit eutils autotools versionator

MY_PV="$(replace_version_separator _ -)"

DESCRIPTION="A heavily multi-threaded pluggable audio player."
HOMEPAGE="http://www.alsaplayer.org/"
SRC_URI="http://www.alsaplayer.org/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="alsa audiofile doc esd flac gtk jack mad mikmod nas nls ogg opengl oss vorbis xosd"

RDEPEND="media-libs/libsndfile
	mad? ( media-libs/libmad )
	gtk? ( >=x11-libs/gtk+-2.8 )
	alsa? ( media-libs/alsa-lib )
	audiofile? ( media-libs/audiofile )
	esd? ( media-sound/esound )
	flac? ( media-libs/flac )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80 )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	nas? ( media-libs/nas )
	ogg? ( media-libs/libogg )
	opengl? ( virtual/opengl )
	vorbis? ( media-libs/libvorbis )
	xosd? ( x11-libs/xosd )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

S="${WORKDIR}"/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.99.80_rc3-flags.patch
	eautoreconf
}

src_compile() {
	use xosd || export ac_cv_lib_xosd_xosd_create="no"
	use doc || export ac_cv_prog_HAVE_DOXYGEN="false"

	local myconf

	if ! use alsa && ! use oss && ! use esd && ! use jack && ! use nas && ! use	sparc; then
		ewarn "You've disabled alsa, oss, esd, jack and nas. Enabling oss for you."
		myconf="${myconf} --enable-oss"
	fi

	if use ogg && use flac && has_version "<media-libs/flac-1.1.3"; then
		myconf="${myconf} --enable-oggflac"
	fi

	econf --disable-gtk --disable-sgi \
		$(use_enable audiofile) \
		$(use_enable esd) \
		$(use_enable flac) \
		$(use_enable gtk gtk2) \
		$(use_enable jack) \
		$(use_enable mikmod) \
		$(use_enable nas) \
		$(use_enable opengl) \
		$(use_enable oss) \
		$(use_enable sparc) \
		$(use_enable vorbis oggvorbis) \
		$(use_enable alsa) \
		$(use_enable nls) \
		$(use_enable mad) \
		--disable-dependency-tracking \
		${myconf}

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" docdir="${D}/usr/share/doc/${PF}" install \
		|| die "emake install failed."

	dodoc AUTHORS ChangeLog README TODO docs/wishlist.txt
}
