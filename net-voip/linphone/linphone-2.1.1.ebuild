# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/linphone/linphone-2.1.1.ebuild,v 1.8 2009/04/24 03:48:32 volkmar Exp $

# Note: video support in linphone relies on swscaler being disabled
#       in ffmpeg.  this is because the video code in linphone is old
#       and uses the old interface.  solution: fix linphone's video
#       code.  workaround: build ffmpeg w/out --enable-swscaler.

inherit eutils

DESCRIPTION="Voice Over IP phone (internet phone which uses SIP)"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/stable/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE="alsa arts console gsm gtk ipv6 xv"
# video disabled for #189774
# XXX: Should "video" be split into ffmpeg/libsdl ?  They are two distinct
#      things: libsdl is just for video display while ffmpeg is just for
#      video capture ... but does anyone actually want a one-way linphone ?

RDEPEND="dev-libs/glib
	dev-perl/XML-Parser
	net-dns/bind-tools
	>=net-libs/libosip-3.0.3
	>=net-libs/libeXosip-3.0.3
	>=media-libs/speex-1.2_beta3
	gsm? ( >=media-sound/gsm-1.0.12-r1 )
	gtk? (
		>=x11-libs/gtk+-2
		gnome-base/libglade
	)
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )"
#	video? (
#		>=media-libs/libsdl-1.2.9
#		media-video/ffmpeg
#		>=media-libs/libtheora-1.0_alpha7
#	)"
DEPEND="${RDEPEND}
	x86? ( xv? ( dev-lang/nasm ) )
	dev-util/pkgconfig"
# use the bundled ortp until newer versions leave package.mask
#	>=net-libs/ortp-0.9.0
#	portaudio? ( >=media-libs/portaudio-19_pre )"
# media-libs/gsm-1.0.12 fails on amd64 due to bug #192736

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/linphone-1.6.0-call.patch
	epatch "${FILESDIR}"/linphone-2.0.1-configure-gsm.patch
	epatch "${FILESDIR}"/linphone-2.0.1-speexdsp.patch #205893
	epatch "${FILESDIR}"/linphone-2.0.1-mediastreamer-deps.patch
	epatch "${FILESDIR}"/linphone-2.1.1-ortp-deps.patch
}

src_compile() {
	export ac_cv_path_DOXYGEN=false
#		$(use_enable video)
	econf \
		--disable-video \
		--disable-manual \
		--disable-strict \
		--libdir=/usr/$(get_libdir)/linphone \
		--libexecdir=/usr/$(get_libdir)/linphone/exec \
		$(use_enable console console_ui) \
		$(use_enable gtk gtk_ui) \
		$(use_enable ipv6) \
		$(use_enable alsa) \
		$(use_enable arts artsc) \
		$(use_enable gsm) \
		--disable-portaudio \
		$(use_enable x86 truespeech) \
		|| die "Unable to configure"
		#--enable-external-ortp \
		#$(use_enable portaudio)
	emake || die "Unable to make"
}

src_install () {
	emake DESTDIR="${D}" install || die "Failed to install"
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README README.arm TODO

	# don't install mediastreamer/ortp includes, docs and pkgconfig files
	# to avoid conflicts with net-libs/ortp
	rm -r "${D}"/usr/include/{mediastreamer2,ortp} || die
	rm -r "${D}"/usr/$(get_libdir)/linphone/pkgconfig/{mediastreamer,ortp}.pc || die
	mv "${D}"/usr/$(get_libdir)/{linphone/,}pkgconfig || die
}
