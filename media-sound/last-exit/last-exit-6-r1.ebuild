# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/last-exit/last-exit-6-r1.ebuild,v 1.4 2009/05/12 07:33:30 ssuominen Exp $

EAPI=2

inherit mono gnome2 eutils autotools

DESCRIPTION="Gnome/GTK+ alternative to the last.fm player"
HOMEPAGE="http://lastexit-player.org/"
SRC_URI="http://lastexit-player.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=x11-libs/gtk+-2.6
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10
	>=media-plugins/gst-plugins-mad-0.10
	>=media-plugins/gst-plugins-gconf-0.10
	>=media-plugins/gst-plugins-gnomevfs-0.10
	>=dev-lang/mono-1.0
	>=dev-dotnet/gtk-sharp-2
	>=dev-dotnet/glade-sharp-2
	>=dev-dotnet/gnome-sharp-2
	>=dev-dotnet/gnomevfs-sharp-2
	dev-dotnet/notify-sharp
	>=dev-dotnet/gconf-sharp-2
	>=dev-libs/dbus-glib-0.71
	>=dev-dotnet/dbus-sharp-0.6.0
	>=dev-dotnet/dbus-glib-sharp-0.4.1
	>=x11-libs/libsexy-0.1.7"
DEPEND="${RDEPEND}"

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install"
}

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${PN}-notify-sharp.patch \
		"${FILESDIR}"/${P}-es.patch
	eautoreconf
}

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
}
