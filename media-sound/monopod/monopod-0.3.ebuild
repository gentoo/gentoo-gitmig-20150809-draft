# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/monopod/monopod-0.3.ebuild,v 1.1 2006/02/17 19:27:34 johnm Exp $

inherit gnome2 mono

DESCRIPTION="A very lightweight podcast client in GTK#"
HOMEPAGE="http://downloads.usefulinc.com/monopod/"
SRC_URI="http://downloads.usefulinc.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=dev-lang/mono-1.1.6
		>=dev-dotnet/glade-sharp-1.9.5
		>=dev-dotnet/gconf-sharp-2.0
		>=dev-dotnet/gtk-sharp-1.9.5
		>=dev-dotnet/gnome-sharp-1.9.5
		dev-db/sqlite"

USE_DESTDIR=1
DOCS="ChangeLog NEWS README TODO AUTHORS"

src_compile() {
	gnome2_src_configure
	emake -j1 || "make failed"
}

src_install() {
	gnome2_src_install
}
