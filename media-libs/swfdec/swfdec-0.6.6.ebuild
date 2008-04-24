# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/swfdec/swfdec-0.6.6.ebuild,v 1.1 2008/04/24 13:40:39 pclouds Exp $

EAPI=1

inherit eutils versionator confutils

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Macromedia Flash decoding library"
HOMEPAGE="http://swfdec.freedesktop.org"
SRC_URI="http://swfdec.freedesktop.org/download/${PN}/${MY_PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

IUSE="alsa doc ffmpeg gstreamer gtk mad oss pulseaudio"

# For <media-video/ffmpeg-0.4.9_p2008032, see #216978
RDEPEND=">=dev-libs/glib-2.12
	>=dev-libs/liboil-0.3.1
	>=x11-libs/pango-1.16.4
	gtk? (
		>=x11-libs/gtk+-2.8.0
		net-libs/libsoup:2.4
		)
	>=x11-libs/cairo-1.2
	ffmpeg? (
		>=media-video/ffmpeg-0.4.9_p20070330
		<media-video/ffmpeg-0.4.9_p20080326
		)
	mad? ( >=media-libs/libmad-0.15.1b )
	gstreamer? (
		>=media-libs/gstreamer-0.10.11
		>=media-libs/gst-plugins-base-0.10.15
		)
	alsa? ( >=media-libs/alsa-lib-1.0.12 )
	pulseaudio? ( media-sound/pulseaudio )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.6 )"

pkg_setup() {
	if use !gtk ; then
		ewarn "swfdec will be built without swfdec-gtk convenience"
		ewarn "library, which is needed by swfdec-mozilla and"
		ewarn "swfdec-gnome. Please add 'gtk' to your USE flags"
		ewarn "unless you really know what you are doing."
	fi
	confutils_use_conflict oss alsa pulseaudio
}

src_compile() {
	local myconf
	local myaudio

	#--with-audio=[auto/alsa/oss/none]
	myaudio="none"
	use oss && myaudio="oss"
	use pulseaudio && myaudio="pa"
	use alsa && myaudio="alsa"
	myconf=" --with-audio=$myaudio"

	# bug #216009
	# avoid writing to /root/.gstreamer-0.10/registry.xml
	export GST_REGISTRY="${T}"/registry.xml
	# also avoid loading gconf plugins, which may write to /root/.gconfd
	export GST_PLUGIN_SYSTEM_PATH="${T}"

	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable gstreamer) \
		$(use_enable ffmpeg) \
		$(use_enable mad) \
		$(use_enable gtk) \
		${myconf} || die "configure failed"

	# bug #216284 image tests are not ready yet
	cat  >test/image/Makefile <<EOF
all:
check:
install:
EOF

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
