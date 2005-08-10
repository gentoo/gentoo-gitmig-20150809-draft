# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.3.3.ebuild,v 1.1 2005/08/10 23:08:57 latexer Exp $

inherit gnome2 mono eutils

DESCRIPTION="Desktop note-taking application"

HOMEPAGE="http://www.beatniksoftware.com/tomboy/"
SRC_URI="http://www.beatniksoftware.com/tomboy/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=dev-dotnet/gnome-sharp-1.0.4
		>=dev-dotnet/gconf-sharp-1.0.4
		=dev-dotnet/gtk-sharp-1.0*
		=dev-dotnet/gnome-sharp-1.0*
		=dev-dotnet/gconf-sharp-1.0*
		>=gnome-base/gnome-panel-2.8.2
		>=dev-libs/atk-1.2.4
		>=app-text/aspell-0.60.2
		>=sys-apps/dbus-0.23
		>=app-text/gtkspell-2"
# Disable dbus for now, as it's causing some crashes

DOCS="AUTHORS Changelog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/${P}-1.1.x-compat.diff || die
	#epatch ${FILESDIR}/${P}-mono-1.1.7-compat.diff || die
	#epatch ${FILESDIR}/${P}-mono-1.1.8-compat.diff || die
}

