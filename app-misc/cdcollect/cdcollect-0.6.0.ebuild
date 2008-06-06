# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdcollect/cdcollect-0.6.0.ebuild,v 1.3 2008/06/06 20:56:32 drac Exp $

inherit gnome2 mono

DESCRIPTION="CDCollect is a CD catalog application for gnome 2. Its functionality is similar to the old gtktalog"
HOMEPAGE="http://cdcollect.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.17
	>=dev-dotnet/gtk-sharp-2.8.0
	>=x11-libs/gtk+-2.8.0
	>=dev-db/sqlite-3.3.5
	>=gnome-base/gconf-2.8.0
	dev-perl/XML-Parser
	>=dev-dotnet/gconf-sharp-2.8.0
	>=dev-dotnet/glade-sharp-2.8.0
	>=dev-dotnet/gnome-sharp-2.8.0
	>=dev-dotnet/gnomevfs-sharp-2.8.0"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

USE_DESTDIR="1"

DOCS="AUTHORS ChangeLog NEWS README TODO"
