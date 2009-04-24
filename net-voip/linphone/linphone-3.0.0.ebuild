# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/linphone/linphone-3.0.0.ebuild,v 1.4 2009/04/24 04:12:34 volkmar Exp $

inherit eutils

DESCRIPTION="Voice Over IP phone (internet phone which uses SIP)"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/stable/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa arts console gsm gtk ipv6 video xv"

RDEPEND="dev-libs/glib
	dev-perl/XML-Parser
	net-dns/bind-tools
	>=net-libs/libosip-3.0.3
	>=net-libs/libeXosip-3.0.3
	>=media-libs/speex-1.1.12
	gsm? ( >=media-sound/gsm-1.0.12-r1 )
	gtk? (
		>=x11-libs/gtk+-2
		gnome-base/libglade
	)
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	video? (
		>=media-libs/libsdl-1.2.9
		media-video/ffmpeg
		>=media-libs/libtheora-1.0_alpha7
	)"
DEPEND="${RDEPEND}
	x86? ( xv? ( dev-lang/nasm ) )
	dev-util/pkgconfig"
# use the bundled ortp until newer versions leave package.mask
#	>=net-libs/ortp-0.13.0
#	portaudio? ( >=media-libs/portaudio-19_pre )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-pkg-config.patch
}

src_compile() {
	export ac_cv_path_DOXYGEN=false
	export ac_cv_path_INTLTOOL_UPDATE=true #252704
	export ac_cv_path_INTLTOOL_MERGE=true
	export ac_cv_path_INTLTOOL_EXTRACT=true
	econf \
		--disable-manual \
		--disable-strict \
		--libdir=/usr/$(get_libdir)/linphone \
		--libexecdir=/usr/$(get_libdir)/linphone/exec \
		$(use_enable console console_ui) \
		$(use_enable gtk gtk_ui) \
		$(use_enable ipv6) \
		$(use_enable alsa) \
		$(use_enable arts artsc) \
		$(use_with gsm) \
		$(use_enable video) \
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
