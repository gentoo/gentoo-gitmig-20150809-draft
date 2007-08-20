# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/linphone/linphone-1.7.1-r1.ebuild,v 1.1 2007/08/20 20:22:42 vapier Exp $

# Note: video support in linphone relies on swscaler being disabled
#       in ffmpeg.  this is because the video code in linphone is old
#       and uses the old interface.  solution: fix linphone's video
#       code.  workaround: build ffmpeg w/out --enable-swscaler.

inherit eutils

MY_DPV="${PV%.*}.x"

DESCRIPTION="Voice Over IP phone (internet phone which uses SIP)"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${MY_DPV}/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa arts console gtk ilbc ipv6 novideo xv"

DEPEND="dev-libs/glib
	dev-perl/XML-Parser
	net-dns/bind-tools
	>=net-libs/libosip-2.2.0
	>=media-libs/speex-1.1.12
	x86? ( xv? ( dev-lang/nasm ) )
	gtk? (
		>=x11-libs/gtk+-2
		gnome-base/libglade
	)
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	!novideo? (
		>=media-libs/libsdl-1.2.9
		media-video/ffmpeg
		>=media-libs/libtheora-1.0_alpha7
	)"
# use the bundled ortp until newer versions leave package.mask
#	>=net-libs/ortp-0.9.0
#	portaudio? ( >=media-libs/portaudio-19_pre )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/linphone-1.6.0-call.patch
	sed -i -e 's:wall_werror=yes:wall_werror=no:' mediastreamer2/configure
}

src_compile() {
	econf \
		--libdir=/usr/$(get_libdir)/linphone \
		$(use_enable console console_ui) \
		$(use_enable gtk gtk_ui) \
		$(use_with ilbc) \
		$(use_enable ipv6) \
		$(use_enable alsa) \
		$(use_enable arts artsc) \
		$(use_enable !novideo video) \
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

	# don't install ortp includes, docs and pkgconfig files
	# to avoid conflicts with net-libs/ortp
	rm -rf "${D}"/usr/include/ortp
	rm -rf "${D}"/usr/share/gtk-doc/html/ortp
	rm -rf "${D}"/usr/$(get_libdir)/linphone/pkgconfig
	rm -rf "${D}"/ortp
}
