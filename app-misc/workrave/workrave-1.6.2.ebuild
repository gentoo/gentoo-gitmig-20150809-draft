# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/workrave/workrave-1.6.2.ebuild,v 1.3 2004/10/26 23:49:07 malc Exp $

inherit eutils gnome2

DESCRIPTION="Helpful utility to attack Repetitive Strain Injury (RSI)"
HOMEPAGE="http://workrave.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
# Internal USE flags: distribution
IUSE="gnome nls xml2 distribution"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=dev-cpp/gtkmm-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-libs/libsigc++-2.0
	distribution? ( >=net-libs/gnet-2 )
	gnome? ( >=gnome-base/libgnomeui-2
		>=dev-cpp/libgnomeuimm-2.6
		>=gnome-base/gnome-panel-2.0.10
		>=gnome-base/libbonobo-2
		>=gnome-base/gconf-2 )
	nls? ( sys-devel/gettext )
	xml2? ( dev-libs/gdome2 )
	!xml2? ( !gnome? ( >=gnome-base/gconf-2 ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} $(use_enable distribution)"
G2CONF="${G2CONF} $(use_enable nls)"
G2CONF="${G2CONF} $(use_enable xml2 xml)"
G2CONF="${G2CONF} $(use_enable gnome)"

use gnome          && G2CONF="${G2CONF} --enable-gconf"

if ! use gnome && ! use xml2
then
	G2CONF="${G2CONF} --enable-gconf"
fi
