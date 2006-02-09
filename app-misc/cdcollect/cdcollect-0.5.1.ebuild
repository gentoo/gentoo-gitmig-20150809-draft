# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdcollect/cdcollect-0.5.1.ebuild,v 1.2 2006/02/09 17:32:06 metalgod Exp $

inherit gnome2 mono

DESCRIPTION="CDCollect is a CD catalog application for gnome 2. Its functionality is similar to the old gtktalog"
HOMEPAGE="http://cdcollect.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1.9
	>=dev-dotnet/gtk-sharp-2.4.0
	=dev-db/sqlite-2.8*
	>=dev-util/pkgconfig-0.9
	dev-perl/XML-Parser
	>=dev-util/intltool-0.25
	>=dev-dotnet/gconf-sharp-2.4.0
	>=dev-dotnet/glade-sharp-2.4.0
	>=dev-dotnet/gnome-sharp-2.4.0
	>=dev-dotnet/gnomevfs-sharp-2.4.0"

RDEPEND="${DEPEND}"

USE_DESTDIR="1"

DOCS="AUTHORS ChangeLog NEWS README TODO"
