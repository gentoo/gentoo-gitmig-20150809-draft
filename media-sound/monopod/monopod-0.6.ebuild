# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/monopod/monopod-0.6.ebuild,v 1.1 2007/10/06 07:56:02 drac Exp $

inherit gnome2 mono

DESCRIPTION="A very lightweight podcast client with ipod support written in GTK#"
HOMEPAGE="http://monopod.berlios.de"
SRC_URI="http://download2.berlios.de/${PN}/${P}.tar.gz
	http://download.berlios.de/${PN}/${P}.tar.gz"
	
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ipod"

RDEPEND=">=dev-lang/mono-1.1.6
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=dev-dotnet/gtk-sharp-2.8
	dev-db/sqlite
	sys-apps/dbus
	ipod? ( >=dev-dotnet/ipod-sharp-0.5.15 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="$(use_enable ipod)"
