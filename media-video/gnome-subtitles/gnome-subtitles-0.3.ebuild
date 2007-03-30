# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/gnome-subtitles/gnome-subtitles-0.3.ebuild,v 1.1 2007/03/30 03:16:23 beandog Exp $

inherit mono gnome2

DESCRIPTION="Video subtitling for the Gnome desktop"
HOMEPAGE="http://gnome-subtitles.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnome-subtitles/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="mplayer"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=">=dev-lang/mono-1.1
	>=dev-dotnet/gtk-sharp-2.8
	>=dev-dotnet/gnome-sharp-2.8
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8"
RDEPEND="mplayer? ( media-video/mplayer )"

DOCS="AUTHORS ChangeLog CREDITS NEWS README TODO"
