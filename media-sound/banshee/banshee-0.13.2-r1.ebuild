# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/banshee/banshee-0.13.2-r1.ebuild,v 1.1 2008/04/15 01:35:35 dang Exp $

GCONF_DEBUG=no

inherit eutils gnome2 mono

GVER=0.10.3

DESCRIPTION="Import, organize, play, and share your music using simple and powerful interface."
HOMEPAGE="http://banshee-project.org"
SRC_URI="http://banshee-project.org/files/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac encode ipod flac mad mtp njb vorbis zeroconf"

RDEPEND=">=dev-lang/mono-1.2
	>=dev-dotnet/gtk-sharp-2.10
	>=dev-dotnet/gnomevfs-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=media-libs/gst-plugins-bad-${GVER}
	>=media-libs/gst-plugins-good-${GVER}
	>=media-libs/gst-plugins-ugly-${GVER}
	>=media-plugins/gst-plugins-alsa-${GVER}
	>=media-plugins/gst-plugins-gnomevfs-${GVER}
	>=media-plugins/gst-plugins-gconf-${GVER}
	encode? ( >=media-plugins/gst-plugins-lame-${GVER}
		>=media-plugins/gst-plugins-taglib-${GVER} )
	mad? ( >=media-plugins/gst-plugins-mad-${GVER} )
	vorbis? ( >=media-plugins/gst-plugins-ogg-${GVER}
		>=media-plugins/gst-plugins-vorbis-${GVER} )
	flac? ( >=media-plugins/gst-plugins-flac-${GVER} )
	aac? ( >=media-plugins/gst-plugins-faad-${GVER} )
	|| (
		>=media-plugins/gst-plugins-cdparanoia-${GVER}
		>=media-plugins/gst-plugins-cdio-${GVER}
	)
	=media-libs/musicbrainz-2*
	njb? ( >=dev-dotnet/njb-sharp-0.3 )
	zeroconf? ( >=dev-dotnet/mono-zeroconf-0.7.2 )
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2
	>=gnome-base/gnome-desktop-2
	ipod? ( >=dev-dotnet/ipod-sharp-0.8
		>=media-plugins/gst-plugins-faac-${GVER} )
	>=sys-apps/hal-0.5.6
	>=dev-lang/boo-0.7.6
	>=dev-db/sqlite-3
	>=gnome-extra/nautilus-cd-burner-2.12
	mtp? ( >=media-libs/libmtp-0.2.1 )
	dev-dotnet/taglib-sharp
	dev-dotnet/dbus-glib-sharp"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	# --enable-daap also disables.
	use zeroconf || G2CONF="${G2CONF} --disable-daap"

	# --disable-gstreamer-plugins-check because it breaks detecting
	# decodebin when portage temp directory is on NFS share.
	G2CONF="${G2CONF} --disable-docs
		--enable-external-boo
		--enable-external-taglib-sharp
		--disable-gstreamer-plugins-check
		--enable-external-ndesk-dbus
		$(use_enable ipod) $(use_enable njb)
		$(use_enable mtp)"
	# TODO. missing USE karma, needs sharp-karma.
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix test suite.
	echo src/Plugins/Banshee.Plugins.LastFM/Resources/lastfm.glade >> po/POTFILES.skip
	echo src/Plugins/Banshee.Plugins.LastFM/banshee-plugin-lastfm.schemas.in >> po/POTFILES.skip
}

src_compile() {
	addpredict /root/.gnome2
	addpredict /root/.gconf
	addpredict /root/.gconfd
	gnome2_src_configure
	emake -j1 || "emake failed."
}

src_install() {
	gnome2_src_install
	use ipod || dodir /usr/$(get_libdir)/banshee/Banshee.Dap
}
