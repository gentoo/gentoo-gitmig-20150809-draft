# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/last-exit/last-exit-4.0.ebuild,v 1.6 2007/07/01 10:26:19 drac Exp $

inherit mono gnome2 eutils autotools

DESCRIPTION="Gnome/GTK+ alternative to the last.fm player"
HOMEPAGE="http://www.o-hand.com/~iain/last-exit/"
SRC_URI="http://www.o-hand.com/~iain/last-exit/${PN}-4.tar.bz2"

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
		>=dev-libs/dbus-glib-0.71"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}-4

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-dbus-sharp-parallel-build-fix.patch
	epatch "${FILESDIR}"/${PN}-4.0-decimal_parse.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "You will unfortunately, need to restart X for this to work properly."
}
