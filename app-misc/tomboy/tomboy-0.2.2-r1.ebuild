# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tomboy/tomboy-0.2.2-r1.ebuild,v 1.3 2005/03/11 03:23:26 latexer Exp $

inherit gnome2 mono

DESCRIPTION="Desktop note-taking application"

HOMEPAGE="http://www.beatniksoftware.com/tomboy/"
SRC_URI="http://www.beatniksoftware.com/tomboy/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=dev-dotnet/gnome-sharp-1.0.4
		>=dev-dotnet/gconf-sharp-1.0.4
		>=dev-libs/atk-1.2.4
		>=app-text/gtkspell-2"

DOCS="AUTHORS Changelog INSTALL NEWS README"
