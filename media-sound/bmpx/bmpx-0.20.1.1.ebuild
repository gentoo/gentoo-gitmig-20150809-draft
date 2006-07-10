# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bmpx/bmpx-0.20.1.1.ebuild,v 1.1 2006/07/10 01:37:08 chutzpah Exp $

inherit versionator fdo-mime

MY_P=${PN}-$(replace_version_separator 3 '-' )

DESCRIPTION="Next generation Beep Media Player"
HOMEPAGE="http://www.beep-media-player.org"
SRC_URI="http://files.beep-media-player.org/releases/0.20/${MY_P}.tar.bz2
		mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="aac alsa cdparanoia debug flac ffmpeg hal libnotify mad musepack nls ogg oss sid stream theora vorbis"

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
	aac? ( media-libs/faad2 )
	sid? ( media-libs/libsidplay )
	>=media-libs/gst-plugins-base-0.10.8
	>=media-libs/gst-plugins-good-0.10.3
	>=media-libs/musicbrainz-2.1.1
	virtual/fam
	=net-misc/neon-0.25*
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
	aac? ( >=media-plugins/gst-plugins-faad-0.10.1 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.8 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.3 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.3 )
	theora? ( >=media-plugins/gst-plugins-theora-0.10.8 )
	stream? ( >=media-plugins/gst-plugins-gnomevfs-0.10.8 )
	sid? ( >=media-plugins/gst-plugins-sidplay-0.10.3 )
	cdparanoia? ( >=media-plugins/gst-plugins-cdparanoia-0.10.8 )
	musepack? ( >=media-plugins/gst-plugins-musepack-0.10.3 )"

src_compile() {
	econf \
		$(use_enable libnotify) \
		$(use_with aac mp4v2) \
		$(use_enable stream prefer-gnomevfs) \
		$(use_enable sid) \
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

	elog "Before filing bugs to Gentoo or upstream note following:"
	elog
	elog "As of 0.20 ${PN} stores it's configs in \$HOME/.config and local"
	elog "data to \$HOME/.local/share as per the freedesktop.org basedir"
	elog "spec. This means that your configs will be lost after you upgrade."
	elog
	elog "If you experience problems with DBUS, read documentation at"
	elog "http://bmpx.beep-media-player.org/site/FAQ#Running_with_D-BUS"
}
