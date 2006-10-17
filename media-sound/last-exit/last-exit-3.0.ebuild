# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/last-exit/last-exit-3.0.ebuild,v 1.1 2006/10/17 21:09:45 steev Exp $

inherit mono gnome2 eutils

DESCRIPTION="Gnome/GTK+ alternative to the last.fm player"
HOMEPAGE="http://www.o-hand.com/~iain/last-exit/"
SRC_URI="http://www.o-hand.com/~iain/last-exit/${PN}-3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=gnome-base/gconf-2.0
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
		>=dev-dotnet/gconf-sharp-1.9.2"

S=${WORKDIR}/"${PN}-3"

pkg_setup() {
	G2CONF="${G2CONF} \
	--disable-schemas-install"
}

src_install() {
	make DESTDIR=${D} install
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "You will unfortunately, need to restart X for this to work properly."
}
