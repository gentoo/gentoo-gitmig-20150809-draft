# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/banshee/banshee-1.4.2.ebuild,v 1.1 2009/01/28 19:14:12 loki_val Exp $

EAPI=2

inherit eutils mono gnome2-utils fdo-mime

GVER=0.10.9

DESCRIPTION="Import, organize, play, and share your music using a simple and powerful interface."
HOMEPAGE="http://banshee-project.org"
SRC_URI="http://download.banshee-project.org/${PN}/${PN}-1-${PV}.tar.bz2
	mirror://gentoo/banshee-1.4.2-musicbrainz-fix.patch.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+aac boo daap doc +encode +flac ipod +mad mtp podcast test +vorbis"

RDEPEND=">=dev-lang/mono-2
	gnome-base/gnome-settings-daemon
	x11-themes/gnome-icon-theme
	sys-apps/dbus
	>=dev-dotnet/gtk-sharp-2.12
	>=dev-dotnet/gconf-sharp-2.24.0
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/notify-sharp-0.4.0_pre20080912-r1
	>=media-libs/gstreamer-0.10.21-r3
	>=media-libs/gst-plugins-bad-${GVER}
	>=media-libs/gst-plugins-good-${GVER}
	>=media-libs/gst-plugins-ugly-${GVER}
	>=media-plugins/gst-plugins-alsa-${GVER}
	>=media-plugins/gst-plugins-gnomevfs-${GVER}
	>=media-plugins/gst-plugins-gconf-${GVER}
	|| (
		>=media-plugins/gst-plugins-cdparanoia-${GVER}
		>=media-plugins/gst-plugins-cdio-${GVER}
	)
	media-libs/musicbrainz:1
	>=dev-dotnet/dbus-glib-sharp-0.4.1
	>=dev-dotnet/dbus-sharp-0.6.1a
	>=dev-dotnet/mono-addins-0.4[gtk]
	>=dev-dotnet/taglib-sharp-2.0.3.1
	>=dev-db/sqlite-3.4
	aac? (
		>=media-plugins/gst-plugins-faad-${GVER}
	)
	boo? (
		>=dev-lang/boo-0.8.1
	)
	daap? (
	 	>=dev-dotnet/mono-zeroconf-0.8.0-r1
	)
	doc? (
		virtual/monodoc
	)
	encode? (
		>=media-plugins/gst-plugins-lame-${GVER}
		>=media-plugins/gst-plugins-taglib-${GVER}
	)
	flac? (
		>=media-plugins/gst-plugins-flac-${GVER}
	)
	ipod? (
		>=dev-dotnet/ipod-sharp-0.8.1
	)
	mad? (
		>=media-plugins/gst-plugins-mad-${GVER}
	)
	mtp? (
		media-libs/libmtp
	)
	vorbis? (
		>=media-plugins/gst-plugins-ogg-${GVER}
		>=media-plugins/gst-plugins-vorbis-${GVER}
	)"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

S=${WORKDIR}/${PN}-1-${PV}

src_prepare() {
	#Upstream bug 563283
	#Author is thansen on freenode.
	epatch "${FILESDIR}/${PN}-1.4.2-metadata-writefail.patch"

	#Upstream bug 527788, our bug 249620
	#tacorner@cornersplace.org is author
	epatch "${WORKDIR}/${PN}-1.4.2-musicbrainz-fix.patch"
}

src_configure() {
		econf						\
		$(use_enable doc docs)				\
		$(use_enable boo)				\
		$(use_enable mtp)				\
		$(use_enable daap)				\
		$(use_enable ipod)				\
		$(use_enable podcast)				\
		--disable-static				\
		--enable-gnome					\
		--enable-schemas-install			\
		--with-gconf-schema-file-dir=/etc/gconf/schemas
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
