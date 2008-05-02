# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/monopod/monopod-0.6.ebuild,v 1.7 2008/05/02 15:56:54 drac Exp $

inherit gnome2 mono

DESCRIPTION="A very lightweight podcast client with ipod support written in GTK#"
HOMEPAGE="http://monopod.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
#IUSE="ipod"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.6
	>=dev-dotnet/glade-sharp-2.8
	>=dev-dotnet/gconf-sharp-2.8
	>=dev-dotnet/gtk-sharp-2.8
	dev-db/sqlite
	sys-apps/dbus"
#	ipod? ( >=dev-dotnet/ipod-sharp-0.5.15 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
#	G2CONF="${G2CONF} $(use_enable ipod)"
	G2CONF="${G2CONF} --disable-ipod"
}
