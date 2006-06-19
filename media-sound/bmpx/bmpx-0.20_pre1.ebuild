# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bmpx/bmpx-0.20_pre1.ebuild,v 1.1 2006/06/19 19:56:11 chutzpah Exp $

inherit eutils gnome2

DESCRIPTION="Next generation Beep Media Player"
HOMEPAGE="http://www.beep-media-player.org"
SRC_URI="mirror://sourceforge/beepmp/${PN}-0.20pre1.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa amazon cdparanoia debug flac ffmpeg hal mad nls ogg oss theora vorbis"

DOCS="AUTHORS ChangeLog README NEWS TODO"

S="${WORKDIR}/${PN}-0.20pre1"

DEPEND=">=dev-libs/glib-2.10
	>=x11-libs/gtk+-2.8.8
	>=x11-libs/pango-1.10.0
	>=dev-libs/libxml2-2.6.1
	>=x11-libs/cairo-1.0.2
	>=x11-libs/startup-notification-0.8
	>=gnome-base/libglade-2.5.1
	>=media-libs/taglib-1.4
	>=media-libs/gstreamer-0.10.8
	>=media-libs/gst-plugins-base-0.10.8
	>=media-libs/gst-plugins-good-0.10.3
	>=media-libs/musicbrainz-2.1.1
	virtual/fam
	>=net-misc/neon-0.25.5
	>=sys-apps/dbus-0.60
	hal? ( >=sys-apps/hal-0.5.5.1 )
	dev-libs/boost
	>=dev-db/sqlite-3.3
	>=dev-cpp/glibmm-2.8.3
	>=dev-cpp/gtkmm-2.8.3
	>=dev-cpp/libglademm-2.6"

RDEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.17
	nls? ( >=sys-devel/gettext-0.14.1
		>=dev-util/intltool-0.31.2 )
	mad? ( >=media-plugins/gst-plugins-mad-0.10.2 )
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.8 )
	ogg? ( >=media-plugins/gst-plugins-ogg-0.10.8 )
	ffmpeg? ( >=media-plugins/gst-plugins-ffmpeg-0.10.1 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10.8 )
	oss? ( >=media-plugins/gst-plugins-oss-0.10.3 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.3 )
	theora? ( >=media-plugins/gst-plugins-theora-0.10.8 )
	cdparanoia? ( >=media-plugins/gst-plugins-cdparanoia-0.10.8 )"

pkg_setup() {
	G2CONF="${G2CONF} \
		$(use_enable hal) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable amazon)"
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-64bit.patch"
}


src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog README NEWS TODO
	insinto /usr/share/bmpx/skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update

	einfo "As of 0.20 ${PN} stores it's configs in \$HOME/.config and local"
	einfo "data to \$HOME/.local/share as per the freedesktop.org basedir"
	einfo "spec. This means that your configs will be lost after you upgrade."
}
