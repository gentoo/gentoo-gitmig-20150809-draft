# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-subtitles/gnome-subtitles-0.8-r1.ebuild,v 1.3 2009/01/05 17:25:34 loki_val Exp $

EAPI=2

inherit mono gnome2

DESCRIPTION="Video subtitling for the Gnome desktop"
HOMEPAGE="http://gnome-subtitles.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnome-subtitles/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-lang/mono-1.1
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gtk-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=media-libs/gstreamer-0.10
	>=media-libs/sublib-0.9
	>=app-text/gtkspell-2.0
	>=app-text/enchant-1.3
	>=media-libs/gst-plugins-base-0.10"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog CREDITS NEWS README"

#Can be removed in 0.9, upstream say it's fixed in SVN
MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}
