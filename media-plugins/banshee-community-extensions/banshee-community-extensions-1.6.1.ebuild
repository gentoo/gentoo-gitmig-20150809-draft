# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/banshee-community-extensions/banshee-community-extensions-1.6.1.ebuild,v 1.2 2010/07/09 17:19:48 pacho Exp $

EAPI=3

inherit base mono

DESCRIPTION="Community-developed plugins for the Banshee media player"
HOMEPAGE="http://banshee-project.org/"
SRC_URI="http://download.banshee-project.org/${PN}/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="lirc lyrics mirage telepathy"

DEPEND=">=dev-lang/mono-2.0
	>=media-sound/banshee-1.5.4
	>=gnome-base/gconf-2.0
	dev-dotnet/gconf-sharp:2
	lyrics? (
		>=dev-dotnet/webkit-sharp-0.2
	)
	mirage? (
		dev-libs/glib:2
		dev-db/sqlite:3
		sci-libs/fftw:3.0
		media-libs/libsamplerate
		>=media-libs/gstreamer-0.10.15
		>=media-libs/gst-plugins-base-0.10.15
	)
	telepathy? (
		dev-dotnet/notify-sharp
		>=dev-lang/mono-2.4.2
	)"
RDEPEND="${DEPEND}
	!media-plugins/banshee-lyrics
	!media-plugins/banshee-mirage"

src_configure() {
	# Disable ClutterFlow as we don't have clutter in tree yet
	# Disable UbuntuOneMusicStore as we don't have ubuntuone-sharp
	# Disable AppIndicator as it's not in tree
	local myconf="--enable-gnome --disable-static --enable-release
		--with-gconf-schema-file-dir=/etc/gconf/schemas
		--with-vendor-build-id=Gentoo/${PN}/${PVR}
		--disable-clutterflow --enable-liveradio
		--enable-coverwallpaper --enable-magnatune
		--disable-ubuntuonemusicstore --disable-appindicator"

	econf \
		$(use_enable lirc) \
		$(use_enable lyrics) \
		$(use_enable mirage) \
		$(use_enable telepathy) \
		$(use_enable test tests) \
		${myconf}
}

src_install() {
	base_src_install
}
