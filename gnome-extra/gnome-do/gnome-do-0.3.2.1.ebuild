# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do/gnome-do-0.3.2.1.ebuild,v 1.2 2008/03/04 19:18:44 graaff Exp $

inherit gnome2 mono

DESCRIPTION="GNOME Do allows you to search for and perform actions on items in your desktop environment"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/do/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-util/intltool-0.35
	dev-util/pkgconfig
	>=dev-dotnet/gtk-sharp-2.0
	>=dev-dotnet/gnome-sharp-2.0
	>=dev-dotnet/gconf-sharp-2.0
	>=dev-dotnet/glade-sharp-2.0
	>=dev-dotnet/gnomevfs-sharp-2.0
	dev-dotnet/dbus-sharp
	dev-dotnet/dbus-glib-sharp
"
