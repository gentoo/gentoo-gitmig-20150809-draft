# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-subtitles/gnome-subtitles-0.8.ebuild,v 1.1 2008/05/30 23:22:24 jurek Exp $

inherit mono gnome2

DESCRIPTION="Video subtitling for the Gnome desktop"
HOMEPAGE="http://gnome-subtitles.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnome-subtitles/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-lang/mono-1.1
	>=dev-dotnet/gtk-sharp-2.8
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-base-0.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog CREDITS NEWS README"
