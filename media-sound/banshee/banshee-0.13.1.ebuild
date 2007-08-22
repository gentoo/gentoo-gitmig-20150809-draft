# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/banshee/banshee-0.13.1.ebuild,v 1.1 2007/08/22 20:47:34 metalgod Exp $

inherit autotools eutils gnome2 mono

DESCRIPTION="Banshee allows you to import CDs, sync your music collection, play
music directly from an iPod, create playlists with songs from your library, and
create audio and MP3 CDs from subsets of your library."
HOMEPAGE="http://banshee-project.org"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="aac boo doc daap encode ipod flac mad njb vorbis"

RDEPEND=">=dev-lang/mono-1.2.0
	>=dev-dotnet/gtk-sharp-2.8.0
	>=dev-dotnet/gnomevfs-sharp-2.8.0
	>=dev-dotnet/gconf-sharp-2.8.0
	>=media-libs/gstreamer-0.10.3
	>=media-libs/gst-plugins-base-0.10.3
	>=media-libs/gst-plugins-good-0.10.3
	>=media-libs/gst-plugins-ugly-0.10.3
	>=media-plugins/gst-plugins-alsa-0.10.3
	>=media-plugins/gst-plugins-gnomevfs-0.10.3
	>=media-plugins/gst-plugins-gconf-0.10.3
	encode? ( >=media-plugins/gst-plugins-lame-0.10.3
		>=media-plugins/gst-plugins-taglib-0.10.3 )
	mad? ( >=media-plugins/gst-plugins-mad-0.10.3 )
	vorbis? ( >=media-plugins/gst-plugins-ogg-0.10.3
		>=media-plugins/gst-plugins-vorbis-0.10.3 )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.3 )
	aac? ( >=media-plugins/gst-plugins-faad-0.10.3
		>=media-libs/faad2-2.0-r4 )
	>=media-plugins/gst-plugins-cdparanoia-0.10.3
	>=media-libs/musicbrainz-2.1.1
	njb? ( >=dev-dotnet/njb-sharp-0.3.0 )
	daap? ( >=net-dns/avahi-0.6.9 )
	>=dev-libs/glib-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/gnome-desktop-2.0
	ipod? ( >=dev-dotnet/ipod-sharp-0.6.3
		>=media-plugins/gst-plugins-faac-0.10.3 )
	>=sys-apps/hal-0.5.2
	boo? ( >=dev-lang/boo-0.7.6 )
	>=dev-db/sqlite-3
	>=gnome-extra/nautilus-cd-burner-2.12"

USE_DESTDIR=1
DOCS="ChangeLog HACKING NEWS README"

pkg_setup() {
	if use daap && ! built_with_use net-dns/avahi mono ; then
		echo
		eerror "In order to compile banshee with daap support"
		eerror "you need to have net-dns/avahi emerged"
		eerror "with 'mono' in your USE flags. Please add that flag, re-emerge"
		eerror "avahi, and then emerge banshee."
		die "net-dns/avahi is missing the .NET binding."
	fi

	if use daap; then
		G2CONF="${G2CONF} --enable-avahi"
		else
		G2CONF="${G2CONF} --disable-daap"
	fi

	if use boo; then
		G2CONF="${G2CONF} --enable-external-boo"
	fi

	G2CONF="${G2CONF} --disable-helix \
		--disable-docs \
		$( use_enable ipod) \
		$( use_enable njb)"
}

src_compile() {
	addpredict "/root/.gnome2"
	addpredict "/root/.gconf"
	addpredict "/root/.gconfd"
	gnome2_src_configure
	emake -j1 || "make failed"
}

src_install() {
	gnome2_src_install
	if ! use ipod; then
		dodir /usr/$(get_libdir)/banshee/Banshee.Dap
	fi
}
pkg_postinst() {
	gnome2_pkg_postinst
	elog
	elog "In case you have an ipod please rebuild this package with USE=ipod"
	elog "If you have a audio player supported by libnjb please"
	elog "rebuild this package with USE=njb"
	elog
}
