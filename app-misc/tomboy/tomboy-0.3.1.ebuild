# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.3.1.ebuild,v 1.2 2005/02/20 00:11:03 dholm Exp $

inherit gnome2 mono eutils

DESCRIPTION="Desktop note-taking application"

HOMEPAGE="http://www.beatniksoftware.com/tomboy/"
SRC_URI="http://www.beatniksoftware.com/tomboy/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND=">=dev-dotnet/mono-1.0
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=dev-dotnet/gnome-sharp-1.0.4
		>=dev-dotnet/gconf-sharp-1.0.4
		>=gnome-base/gnome-panel-2.8.2
		>=dev-libs/atk-1.2.4
		>=app-text/aspell-0.60.2
		>=app-text/gtkspell-2"
# Disable dbus for now, as it's causing some crashes
		#>=sys-apps/dbus-0.23

DOCS="AUTHORS Changelog INSTALL NEWS README"
G2CONF="${G2CONF} --disable-dbus"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-mono-1.1.4-compat.diff || die
}

