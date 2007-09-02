# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/last-exit/last-exit-5.0.ebuild,v 1.2 2007/09/02 14:48:52 steev Exp $

inherit mono gnome2 eutils autotools

DESCRIPTION="Gnome/GTK+ alternative to the last.fm player"
HOMEPAGE="http://lastexit-player.org/"
SRC_URI="http://lastexit-player.org/releases/${PN}-5.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.0
		>=x11-libs/gtk+-2.6
		>=media-libs/gstreamer-0.10
		>=media-libs/gst-plugins-base-0.10
		>=media-plugins/gst-plugins-mad-0.10
		>=media-plugins/gst-plugins-gconf-0.10
		>=media-plugins/gst-plugins-gnomevfs-0.10
		>=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-1.9.2
		>=dev-dotnet/gnome-sharp-1.9.2
		>=dev-dotnet/glade-sharp-1.9.2
		>=dev-dotnet/gconf-sharp-1.9.2
		>=dev-libs/dbus-glib-0.71
		>=x11-libs/libsexy-0.1.7"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}-5

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install"
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	gnome2_pkg_postinst
}
