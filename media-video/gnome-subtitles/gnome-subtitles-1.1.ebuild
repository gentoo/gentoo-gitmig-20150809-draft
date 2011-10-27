# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-subtitles/gnome-subtitles-1.1.ebuild,v 1.5 2011/10/27 06:34:01 tetromino Exp $

EAPI=2
inherit mono gnome2

DESCRIPTION="Video subtitling for the Gnome desktop"
HOMEPAGE="http://gnome-subtitles.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnome-subtitles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~ppc x86"

RDEPEND=">=dev-lang/mono-1.1
	>=dev-dotnet/glade-sharp-2.12
	>=dev-dotnet/gtk-sharp-2.12
	>=dev-dotnet/gconf-sharp-2.12
	media-libs/gstreamer:0.10
	>=app-text/gtkspell-2.0:2
	>=app-text/enchant-1.3
	media-libs/gst-plugins-base:0.10"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	app-text/gnome-doc-utils"

src_install() {
	gnome2_src_install
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}

DOCS="AUTHORS ChangeLog NEWS README"
