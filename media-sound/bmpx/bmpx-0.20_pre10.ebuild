# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bmpx/bmpx-0.20_pre10.ebuild,v 1.1 2006/07/03 20:18:45 chutzpah Exp $

inherit fdo-mime

MY_P="${P/_/}"

DESCRIPTION="Next generation Beep Media Player"
HOMEPAGE="http://www.beep-media-player.org"
SRC_URI="http://files.beep-media-player.org/releases/0.20/pre-releases/${MY_P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa cdparanoia debug flac ffmpeg hal libnotify mad nls ogg oss theora vorbis"

S="${WORKDIR}/${MY_P}"

RDEPEND=">=dev-libs/glib-2.10
	>=x11-libs/gtk+-2.8.8
	>=x11-libs/pango-1.10.0
	dev-libs/boost
	>=dev-cpp/glibmm-2.8.3
	>=dev-cpp/gtkmm-2.8.3
	>=gnome-base/libglade-2.5.1
	>=dev-cpp/libglademm-2.6
	>=x11-libs/startup-notification-0.8
	>=media-libs/taglib-1.4
	>=media-libs/gst-plugins-base-0.10.8
	>=media-libs/gst-plugins-good-0.10.3
	>=media-libs/musicbrainz-2.1.1
	virtual/fam
	>=net-misc/neon-0.25.3
	>=sys-apps/dbus-0.60
	hal? ( >=sys-apps/hal-0.5.5.1 )
	libnotify? ( >=x11-libs/libnotify-0.4.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.17
	nls? ( >=sys-devel/gettext-0.14.1
		>=dev-util/intltool-0.31.2 )
	mad? ( >=media-plugins/gst-plugins-mad-0.10.3 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.8 )
	ogg? ( >=media-plugins/gst-plugins-ogg-0.10.8 )
	ffmpeg? ( >=media-plugins/gst-plugins-ffmpeg-0.10.1 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.8 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.3 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.3 )
	theora? ( >=media-plugins/gst-plugins-theora-0.10.8 )
	cdparanoia? ( >=media-plugins/gst-plugins-cdparanoia-0.10.8 )"

src_compile() {
	econf \
		$(use_enable libnotify notify) \
		$(use_enable hal) \
		$(use_enable nls) \
		$(use_enable debug) || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README TODO
	insinto /usr/share/bmpx/skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	einfo "Before filing bugs to Gentoo or upstream please note following:"
	echo
	einfo "As of 0.20 ${PN} stores it's configs in \$HOME/.config and local"
	einfo "data to \$HOME/.local/share as per the freedesktop.org basedir"
	einfo "spec. This means that your configs will be lost after you upgrade."
	echo
	einfo "If you experience problems with DBUS, please read documentation at"
	einfo "http://bmpx.beep-media-player.org/site/FAQ#Running_with_D-BUS"
}
