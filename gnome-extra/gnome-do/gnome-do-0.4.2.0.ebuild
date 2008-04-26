# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do/gnome-do-0.4.2.0.ebuild,v 1.2 2008/04/26 06:45:40 graaff Exp $

inherit gnome2 mono versionator

PVC=$(get_version_component_range 1-2)

DESCRIPTION="GNOME Do allows you to search for and perform actions on items in your desktop environment"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/do/trunk/${PVC}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-dotnet/gtk-sharp-2.0
	>=dev-dotnet/gnome-sharp-2.0
	>=dev-dotnet/gconf-sharp-2.0
	>=dev-dotnet/glade-sharp-2.0
	>=dev-dotnet/gnomevfs-sharp-2.0
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-glib-sharp
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-util/pkgconfig
"
